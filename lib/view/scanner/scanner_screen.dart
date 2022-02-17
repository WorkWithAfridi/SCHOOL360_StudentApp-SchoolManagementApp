import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:school_360_app/functions/open_webview.dart';
import 'package:school_360_app/model/student_id_validator.dart';
import 'package:school_360_app/provider/qrcode_data.dart';
import 'package:school_360_app/view/pay_slip_payment/payment_summary_screen.dart';
import 'package:school_360_app/view/school_hub/school_hub_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../functions/globar_variables.dart';
import '../../model/payment/data_model_for_pay_slip_payment.dart';

class QRScanner extends StatefulWidget {
  static const routeName = '/scanner';
  const QRScanner({Key? key}) : super(key: key);

  @override
  _QRScannerState createState() => _QRScannerState();
}

class _QRScannerState extends State<QRScanner> {
  Barcode? result;
  QRViewController? controller;
  late String schoolId;
  late String encryptedStudentId;
  late String receiptNo;
  bool isBillQR = false;
  bool isStudentIdQR = false;
  var mode = '00';
  bool _scanAgain = true;
  bool _showAlertBox = false;
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  DataModelForPaySlipPayment dataModel = DataModelForPaySlipPayment();

  TextStyle headerTextStyleBlack = GoogleFonts.getFont(
    'Ubuntu',
    textStyle: const TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: 20,
      color: Color(0xff212121),
    ),
  );
  TextStyle headerTextStyleWhite = GoogleFonts.getFont(
    'Ubuntu',
    textStyle: const TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: 20,
      color: Color(0xffEDECEF),
    ),
  );

  TextStyle normalTextStyle = GoogleFonts.getFont(
    'Ubuntu',
    textStyle: const TextStyle(
        color: Color(0xff212121), fontSize: 14, fontWeight: FontWeight.w400),
  );
  TextStyle normalHighLightTextStyle = GoogleFonts.getFont(
    'Ubuntu',
    textStyle: const TextStyle(
      fontSize: 15,
      fontWeight: FontWeight.w600,
      color: Color(0xffFF284C),
    ),
  );

  // In order to get hot reload to work we need to pause the camera if the platform
  // is android, or resume the camera if the platform is iOS.
  @override
  void reassemble() {
    super.reassemble();
    if (Platform.isAndroid) {
      controller!.pauseCamera();
    }
    controller!.resumeCamera();
  }

  bool rememberMe = false;

  @override
  Widget build(BuildContext context) {
    var routeArgs =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    mode = routeArgs['Mode'];
    encryptedStudentId = '';
    schoolId = '';
    receiptNo = '';
    if (mode == 'Bill') isBillQR = true;
    if (mode == 'StudentID') {
      isStudentIdQR = true;
    }
    return Scaffold(
      appBar: AppBar(
        backgroundColor: black,
        elevation: 6,
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: Icon(
            Icons.arrow_back,
            color: white,
            size: 25,
          ),
        ),
        centerTitle: true,
        title: Text(
          'QR SCANNER',
          style: GoogleFonts.getFont('Roboto', textStyle: headerTSWhite),
        ),
      ),
      backgroundColor: white,
      body: Stack(
        alignment: Alignment.center,
        children: <Widget>[
          _buildQrView(context),
          Positioned(
            bottom: 0,
            left: 0,
            child: Container(
              padding: EdgeInsets.only(top: 5),
              color: Theme.of(context).colorScheme.background,
              height: MediaQuery.of(context).size.height * .15,
              width: MediaQuery.of(context).size.width,
              alignment: Alignment.topCenter,
              child: SingleChildScrollView(
                physics: BouncingScrollPhysics(),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      // color: Colors.red,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          IconButton(
                            icon: const Icon(
                              Icons.flash_on,
                              color: Colors.black,
                            ),
                            onPressed: () async {
                              await controller?.toggleFlash();
                              setState(() {});
                            },
                          ),
                          const SizedBox(
                            width: 30,
                          ),
                          IconButton(
                            icon: const Icon(
                              Icons.cameraswitch_outlined,
                              color: Colors.black,
                            ),
                            onPressed: () async {
                              await controller?.flipCamera();
                              setState(() {});
                            },
                          )
                        ],
                      ),
                    ),
                    mode != 'Bill'
                        ? GestureDetector(
                            onTap: () {
                              setState(() {
                                rememberMe = !rememberMe;
                              });
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
                                  width: 30,
                                  child: Checkbox(
                                    checkColor: white,
                                    activeColor: red,
                                    value: rememberMe,
                                    onChanged: (value) {
                                      setState(() {
                                        rememberMe = value!;
                                      });
                                    },
                                  ),
                                ),
                                Text(
                                  'Remember me',
                                  style: defaultTS,
                                )
                              ],
                            ),
                          )
                        : Container(),
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            child: Container(
              color: Theme.of(context).colorScheme.background,
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width * .1,
            ),
          ),
          Positioned(
            bottom: 0,
            right: 0,
            child: Container(
              color: Theme.of(context).colorScheme.background,
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width * .1,
            ),
          ),
          Positioned(
            top: 0,
            left: 0,
            child: Container(
              color: Theme.of(context).colorScheme.background,
              // color: Colors.red,
              height: MediaQuery.of(context).size.height * .15,
              width: MediaQuery.of(context).size.width,
              child: Center(
                child: Text('Please scan the QR code to continue.',
                    style: defaultTS.copyWith(
                        fontWeight: FontWeight.w600, fontSize: 12)),
              ),
            ),
          ),
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: isLoading
                ? LinearProgressIndicator(
                    color: red,
                  )
                : Container(),
          ),
          _showAlertBox
              ? SizedBox(
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width,
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 2, sigmaY: 2),
                    child: AlertBoxLayout(context),
                  ),
                )
              : Container(),
        ],
      ),
    );
  }

  bool isLoading = false;

  Widget _buildQrView(BuildContext context) {
    var scanArea = (MediaQuery.of(context).size.width < 400 ||
            MediaQuery.of(context).size.height < 400)
        ? 200.0
        : 200.0;
    return QRView(
      key: qrKey,
      onQRViewCreated: _onQRViewCreated,
      overlay: QrScannerOverlayShape(
          borderColor: Theme.of(context).colorScheme.background,
          borderRadius: 10,
          borderLength: 30,
          borderWidth: 10,
          cutOutSize: scanArea),
      onPermissionSet: (ctrl, p) => _onPermissionSet(context, ctrl, p),
    );
  }

  void _onPermissionSet(BuildContext context, QRViewController ctrl, bool p) {
    log('${DateTime.now().toIso8601String()}_onPermissionSet $p');
    if (!p) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('no Permission')),
      );
    }
  }

  void _onQRViewCreated(QRViewController controller) {
    setState(() {
      this.controller = controller;
    });
    controller.scannedDataStream.listen(
      (scanData) {
        if (_scanAgain) {
          setState(() {
            _scanAgain = false;
            isLoading = true;
            result = scanData;
          });
          if (result!.code.toString().toLowerCase() == 'workwithafridi') {
            Navigator.of(context).pushReplacementNamed(OpenWebView.routeName,
                arguments: {
                  'Url': "https://sites.google.com/view/workwithafridi"
                });
          } else {
            extractData();
            checkQRData(context);
          }
        }
      },
    );
  }

  void extractData() {
    schoolId = result!.code.toString().substring(result!.code!.length - 6);
    print(schoolId);
    if (mode == 'Bill') {
      receiptNo =
          result!.code.toString().substring(0, result!.code!.length - 6);
      encryptedStudentId = 0.toString();
    } else if (mode == 'StudentID') {
      encryptedStudentId =
          result!.code.toString().substring(0, result!.code!.length - 6);
      receiptNo = 0.toString();
    }
  }

  late StudentIdValidator studentIdValidator;

  void validateStudentId() async {
    String tempSchoolId = schoolId;
    String url = 'https://school360.app/$schoolId/service_bridge/verifyQrCode';
    print(url);
    print(encryptedStudentId);
    http.Response response = await http.post(Uri.parse(url),
        body: {"security_pin": '311556', "student_code": encryptedStudentId});
    String data = response.body;
    print(data);
    if (data.isEmpty) {
      setState(() {
        _showAlertBox = true;
      });
      return;
    } else {
      var data1 = jsonDecode(data);
      if (data1["status"] == "error") {
        setState(() {
          _showAlertBox = true;
          isLoading = false;
        });
        return;
      }
      studentIdValidator = StudentIdValidator.fromJson(data1);
      if (studentIdValidator.status == "success") {
        QRCodeDataProvider qrCodeData =
            Provider.of<QRCodeDataProvider>(context, listen: false);
        qrCodeData.studentId =
            studentIdValidator.studentInfo!.studentCode.toString();
        qrCodeData.studentName =
            studentIdValidator.studentInfo!.name.toString();
        setState(() {
          isLoading = false;
        });
        if (rememberMe)
          saveUser(
              tempSchoolId,
              studentIdValidator.studentInfo!.studentCode.toString(),
              studentIdValidator.studentInfo!.name.toString());
        Navigator.pushNamedAndRemoveUntil(
          context,
          SchoolHub.routeName,
          (route) => false,
        );
      }
    }
  }

  void saveUser(
    String schoolId,
    String studentId,
    String studentName,
  ) async {
    final prefs = await SharedPreferences.getInstance();
    print(schoolId);
    await prefs.setString('schoolId', schoolId);
    await prefs.setString('studentId', studentId);
    await prefs.setString('studentName', studentName);
    return;
  }

  void checkQRData(BuildContext context) async {
    QRCodeDataProvider qrCodeData =
        Provider.of<QRCodeDataProvider>(context, listen: false);
    qrCodeData.schoolId = schoolId;

    String tempSchoolId = schoolId;
    try {
      if (mode == 'Bill') {
        String url =
            'https://school360.app/$schoolId/service_bridge/getPaySlipByReceiptNo';

        print('hello');
        print(url);
        print(receiptNo);
        http.Response response = await http.post(Uri.parse(url),
            body: {"security_pin": '311556', "receipt_no": receiptNo});
        String data = response.body;
        if (data.isEmpty) {
          setState(() {
            _showAlertBox = true;
          });
          return;
        } else {
          var data1 = jsonDecode(data);
          dataModel = DataModelForPaySlipPayment.fromJson(data1);
          if (dataModel.status == "success") {
            Navigator.of(context).pushReplacementNamed(PaymentSummary.routeName,
                arguments: {'dataModel': dataModel, 'schoolId': tempSchoolId});
            setState(() {
              isLoading = false;
            });
          }
        }
      } else if (mode == 'StudentID') {
        validateStudentId();
      }
    } catch (e) {
      setState(() {
        setState(() {
          isLoading = false;
        });
        _showAlertBox = true;
      });
    }
  }

  void reset() {
    _scanAgain = true;
    _showAlertBox = false;
    isLoading = false;
  }

  Widget AlertBoxLayout(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 1,
      child: AlertDialog(
        title: Text("Attention", style: headerTSBlack),
        content: Text("Invalid QR code. Please try again with a valid code!",
            style: defaultTS),
        actions: <Widget>[
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.3,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: Theme.of(context).colorScheme.primary,
              ),
              onPressed: () {
                setState(() {
                  reset();
                });
              },
              child: const Text('Retry'),
            ),
          )
        ],
      ),
    );
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }
}
