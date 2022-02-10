import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:school_360_app/view/home_screen.dart';

import '../../functions/globar_variables.dart';

class TransactionError extends StatelessWidget {
  TransactionError({Key? key}) : super(key: key);
  static const routeName = '/transaction_status-error';

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

  @override
  Widget build(BuildContext context) {
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
          'Error',
          style: headerTSWhite,
        ),
      ),
      backgroundColor: white,
      body: Container(
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              // color: Colors.red,
              height: MediaQuery.of(context).size.height * .2,
              child: Lottie.asset(
                'lib/assets/lottieAnimation/transactionFailed_lottieAnimation.json',
                fit: BoxFit.cover,
                repeat: false,
              ),
            ),
            Text('Transaction Failed.', style: headerTSBlack),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: Text(
                  'Please contact your local administration, for further details.',
                  textAlign: TextAlign.center,
                  style: defaultTS),
            ),
            const SizedBox(
              height: 30,
            ),
            // Container(
            //   height: 50,
            //   width: 50,
            //   decoration: BoxDecoration(
            //       color: Colors.red,
            //       borderRadius: BorderRadius.circular(50)),
            //   child: Center(
            //     child: IconButton(
            //       onPressed: () {
            //         Navigator.of(context).pop();
            //       },
            //       icon: const Icon(
            //         Icons.close,
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
