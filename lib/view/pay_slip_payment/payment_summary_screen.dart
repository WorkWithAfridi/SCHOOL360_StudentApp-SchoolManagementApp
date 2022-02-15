import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:school_360_app/functions/globar_variables.dart';
import 'package:school_360_app/functions/payment.dart';
import 'package:school_360_app/provider/appData.dart';

import '../../model/payment/data_model_for_pay_slip_payment.dart';

class PaymentSummary extends StatefulWidget {
  static const routeName = '/payment-summary';
  const PaymentSummary({Key? key}) : super(key: key);

  @override
  _PaymentSummaryState createState() => _PaymentSummaryState();
}

class _PaymentSummaryState extends State<PaymentSummary> {
  DataModelForPaySlipPayment _dataModel = DataModelForPaySlipPayment();
  late String _schoolId;

  late TextStyle headerTextStyleBlack;
  late TextStyle headerTextStyleWhite;
  late TextStyle normalTextStyle;
  late TextStyle normalHighLightTextStyle;
  late AppData appData;
  void getData() {
    appData = Provider.of<AppData>(context, listen: false);
    headerTextStyleBlack = appData.headerTextStyleBlack;
    headerTextStyleWhite = appData.headerTextStyleWhite;
    normalTextStyle = appData.normalTextStyle;
    normalHighLightTextStyle = appData.normalHighLightTextStyle;
  }

  @override
  void initState() {
    getData();
  }

  @override
  Widget build(BuildContext context) {
    var routeArgs =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    _dataModel = routeArgs['dataModel'] as DataModelForPaySlipPayment;
    _schoolId = routeArgs['schoolId'] as String;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primary,
        elevation: 6,
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: Icon(
            Icons.arrow_back,
            color: Theme.of(context).colorScheme.background,
            size: 25,
          ),
        ),
        centerTitle: true,
        title: Text('PAYMENT INFO.', style: headerTSWhite),
      ),
      backgroundColor: white,
      body: Stack(
        children: [
          _background(),
          _paymentSummaryPage(context),
          Positioned(
            bottom: 0,
            left: 0,
            child: bottomProceedToCheckoutNavbar(context),
          )
        ],
      ),
    );
  }

  GestureDetector bottomProceedToCheckoutNavbar(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Payment makePayment = Payment();
        makePayment.sslCommerzGeneralCall_LIVE(
            studentCode: '000',
            year: '000',
            month: '0',
            mode: 'PaySlipPayment',
            schoolId: _schoolId,
            total: double.parse(
                _dataModel.data!.paymentInfo![0].totalPaidAmount.toString()),
            receipt_no: _dataModel.data!.paymentInfo![0].receiptNo.toString(),
            context: context,
            getPaymentGatewayCredential_url:
                'https://school360.app/$_schoolId/service_bridge/getSSLPaymentGatewayCredential');
      },
      child: Container(
        height: 40,
        width: MediaQuery.of(context).size.width,
        color: Theme.of(context).colorScheme.secondary,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Proceed to Checkout', style: headerTSWhite),
              const SizedBox(
                width: 3,
              ),
              Icon(
                FontAwesomeIcons.arrowRight,
                size: 16,
                color: Theme.of(context).colorScheme.background,
              ),
            ],
          ),
        ),
      ),
    );
  }

  SizedBox _background() {
    return SizedBox(
      height: double.infinity,
      width: double.infinity,
      child: GridPaper(
        color: red.withOpacity(0.05),
        divisions: 2,
        interval: 200,
        subdivisions: 8,
      ),
    );
  }

  SizedBox _paymentSummaryPage(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height,
      // color: Colors.red,
      width: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 10.0,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _paymentSummaryView(context),
                  const SizedBox(
                    height: 10,
                  ),
                  _billSummaryView(context),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Expanded _billSummaryView(BuildContext context) {
    return Expanded(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Bill Summary: ', style: headerTSBlack),
          const SizedBox(
            height: 5,
          ),
          Container(
            width: double.infinity,
            height: 40,
            color: Theme.of(context).colorScheme.primary,
            child: Row(
              children: [
                SizedBox(
                  width: 30,
                  child: Center(
                    child: Text('#', style: headerTSWhite),
                  ),
                ),
                Expanded(
                  child: Container(
                    alignment: Alignment.centerLeft,
                    child: Text('Summary', style: headerTSWhite),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  const SizedBox(
                    height: 5,
                  ),
                  ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: _dataModel.data!.collectionSheetDetails!.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Column(
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                width: 30,
                                alignment: Alignment.topCenter,
                                child: Text('${(index + 1).toString()}.',
                                    style: defaultTS),
                              ),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                        _dataModel
                                            .data!
                                            .collectionSheetDetails![index]
                                            .subCategory
                                            .toString(),
                                        style: defaultTS),
                                    RichText(
                                      text: TextSpan(
                                        style:
                                            DefaultTextStyle.of(context).style,
                                        children: <TextSpan>[
                                          TextSpan(
                                            text: 'Allocated Amount: ',
                                            style: defaultTS,
                                          ),
                                          TextSpan(
                                              text:
                                                  '${_dataModel.data!.collectionSheetDetails![index].actualAmount.toString()}.',
                                              style: defaultHighLightedTS),
                                        ],
                                      ),
                                    ),
                                    RichText(
                                      text: TextSpan(
                                        style:
                                            DefaultTextStyle.of(context).style,
                                        children: <TextSpan>[
                                          TextSpan(
                                            text: 'Already Paid: ',
                                            style: defaultTS,
                                          ),
                                          TextSpan(
                                              text:
                                                  '${_dataModel.data!.collectionSheetDetails![index].paidAmount.toString()}.',
                                              style: defaultHighLightedTS),
                                        ],
                                      ),
                                    ),
                                    RichText(
                                      text: TextSpan(
                                        style:
                                            DefaultTextStyle.of(context).style,
                                        children: <TextSpan>[
                                          TextSpan(
                                            text: 'Discounted: ',
                                            style: defaultTS,
                                          ),
                                          TextSpan(
                                              text:
                                                  '${_dataModel.data!.collectionSheetDetails![index].discountAmount.toString()}.',
                                              style: defaultHighLightedTS),
                                        ],
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 5,
                                    ),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        RichText(
                                          text: TextSpan(
                                            style: DefaultTextStyle.of(context)
                                                .style,
                                            children: <TextSpan>[
                                              TextSpan(
                                                text: 'Total: ',
                                                style: defaultTS,
                                              ),
                                              TextSpan(
                                                  text: _dataModel
                                                      .data!
                                                      .collectionSheetDetails![
                                                          index]
                                                      .actualAmount
                                                      .toString(),
                                                  style: defaultHighLightedTS),
                                              TextSpan(
                                                  text: 'TK.',
                                                  style: defaultTS),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          Container(
                            color: Theme.of(context)
                                .colorScheme
                                .onBackground
                                .withOpacity(0.4),
                            height: 1,
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                        ],
                      );
                    },
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Container(
                    height: 100,
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                      color: silver.withOpacity(.25),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Text(
                          'Total: ',
                          style: headerTSBlack.copyWith(fontSize: 25),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              _dataModel.data!.paymentInfo![0].totalPaidAmount
                                  .toString(),
                              style: defaultHighLightedTS.copyWith(
                                fontSize: 25,
                                fontWeight: FontWeight.w800,
                              ),
                            ),
                            Text(
                              ' Tk.',
                              style: defaultTS.copyWith(
                                fontSize: 25,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 50,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  SizedBox _paymentSummaryView(BuildContext context) {
    return SizedBox(
      // color: Colors.red,
      width: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 10.0),
            child: Text('Payment Summary.', style: headerTSBlack),
          ),
          RichText(
            text: TextSpan(
              style: DefaultTextStyle.of(context).style,
              children: <TextSpan>[
                TextSpan(
                  text: 'Name: ',
                  style: defaultTS.copyWith(decoration: TextDecoration.none),
                ),
                TextSpan(
                  text:
                      '${_dataModel.data!.paymentInfo![0].studentName.toString()}.',
                  style: defaultHighLightedTS.copyWith(
                      decoration: TextDecoration.none),
                ),
              ],
            ),
          ),
          RichText(
            text: TextSpan(
              style: DefaultTextStyle.of(context).style,
              children: <TextSpan>[
                TextSpan(
                  text: 'Receipt number: ',
                  style: defaultTS.copyWith(decoration: TextDecoration.none),
                ),
                TextSpan(
                  text:
                      '${_dataModel.data!.paymentInfo![0].receiptNo.toString()}.',
                  style: defaultHighLightedTS.copyWith(
                      decoration: TextDecoration.none),
                ),
              ],
            ),
          ),
          RichText(
            text: TextSpan(
              style: DefaultTextStyle.of(context).style,
              children: <TextSpan>[
                TextSpan(
                  text: 'Due: ',
                  style: defaultTS.copyWith(decoration: TextDecoration.none),
                ),
                TextSpan(
                  text: _dataModel.data!.paymentInfo![0].totalPaidAmount
                      .toString(),
                  style: defaultHighLightedTS.copyWith(
                      decoration: TextDecoration.none),
                ),
                TextSpan(
                  text: 'TK.',
                  style: defaultTS.copyWith(decoration: TextDecoration.none),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
