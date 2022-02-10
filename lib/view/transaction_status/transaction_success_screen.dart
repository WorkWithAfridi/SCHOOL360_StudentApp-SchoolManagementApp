import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:school_360_app/provider/appData.dart';
import 'package:school_360_app/provider/invoice.dart';
import 'package:school_360_app/view/home_screen.dart';

import '../../functions/globar_variables.dart';

class TransactionSuccess extends StatefulWidget {
  TransactionSuccess({Key? key}) : super(key: key);
  static const routeName = '/transaction_status-successful';

  @override
  State<TransactionSuccess> createState() => _TransactionSuccessState();
}

class _TransactionSuccessState extends State<TransactionSuccess> {
  late TextStyle headerTextStyleBlack;

  late TextStyle headerTextStyleWhite;

  late TextStyle normalTextStyle;

  late TextStyle normalHighLightTextStyle;

  late AppData appData;

  void getData(BuildContext context) {
    appData = Provider.of<AppData>(context, listen: false);
    headerTextStyleBlack = appData.headerTextStyleBlack;
    headerTextStyleWhite = appData.headerTextStyleWhite;
    normalTextStyle = appData.normalTextStyle;
    normalHighLightTextStyle = appData.normalHighLightTextStyle;
  }

  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    getData(context);
    return Scaffold(
      backgroundColor: white,
      body: Container(
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              // color: Colors.red,
              height: MediaQuery.of(context).size.height * .3,
              child: Lottie.asset(
                'lib/assets/lottieAnimation/transactionSuccessful_lottieAnimation.json',
                fit: BoxFit.cover,
                repeat: false,
              ),
            ),
            Text('Transaction Successful.', style: headerTSBlack),
            Text('Thank you for believing in SCHOOL360.',
                textAlign: TextAlign.center, style: defaultTS),
            SizedBox(
              height: 40,
            ),
            Column(
              children: [
                GestureDetector(
                  onTap: () async {
                    setState(() {
                      isLoading = true;
                    });

                    InvoiceProvider invoiceProvider =
                        Provider.of<InvoiceProvider>(context, listen: false);
                    invoiceProvider.getInvoice(context);

                    await Future.delayed(Duration(seconds: 1));
                    setState(() {
                      isLoading = false;
                    });
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        FontAwesomeIcons.receipt,
                        color: red,
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      Text(
                        'View Invoice   ',
                        style: defaultHighLightedTS,
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                isLoading
                    ? Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 50),
                        child: LinearProgressIndicator(
                          color: red,
                        ),
                      )
                    : Container(
                        padding: const EdgeInsets.symmetric(horizontal: 50),
                        child: Container(
                          height: 1,
                          width: double.infinity,
                          color: black.withOpacity(.5),
                        ),
                      ),
                const SizedBox(
                  height: 10,
                ),
                GestureDetector(
                  onTap: () {
                    appData.selectedTab = 0;
                    appData.navigateToPage(0);
                    Navigator.of(context).pop(context);
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Back to home',
                          style:
                              defaultTS.copyWith(fontWeight: FontWeight.w800)),
                      const SizedBox(
                        width: 5,
                      ),
                      Icon(
                        FontAwesomeIcons.home,
                        color: black,
                      ),
                    ],
                  ),
                ),
              ],
            )
            // const SizedBox(
            //   height: 20,
            // ),
            // Container(
            //   height: 50,
            //   width: 50,
            //   decoration: BoxDecoration(
            //       color: Theme.of(context).colorScheme.primary,
            //       borderRadius: BorderRadius.circular(50)),
            //   child: Center(
            //     child: IconButton(
            //       onPressed: () {
            //         Navigator.of(context)
            //             .pushReplacementNamed(Homepage.routeName);
            //       },
            //       icon: const Icon(
            //         Icons.done_rounded,
            //         size: 25,
            //         color: Colors.white,
            //       ),
            //     ),
            //   ),
            // )
          ],
        ),
      ),
    );
  }
}
