import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

import '../../../../../functions/globar_variables.dart';
import '../../../../../provider/qrcode_data.dart';

class GetWelcomeMessage extends StatelessWidget {
  const GetWelcomeMessage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    QRCodeDataProvider qrCodeData= Provider.of<QRCodeDataProvider>(context, listen: false);
    return Column(
      children: [

        const SizedBox(
          height: 10,
        ),
        Stack(
          children: [
            Container(
              // color: Colors.red,
              alignment: Alignment.bottomRight,
              height: MediaQuery.of(context).size.height * .25,
              child: Lottie.asset(
                  'lib/assets/lottieAnimation/hiLottieAnimation.json',
                  fit: BoxFit.fill),
            ),
            Container(
              height: MediaQuery.of(context).size.height * .25,
              alignment: Alignment.centerLeft,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: Text('Powered by ', style: defaultTS),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: Text('SCHOOL360.', style: userNameTS),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: Container(
                      height: 1,
                      width: MediaQuery.of(context).size.width * .1,
                      color: Theme.of(context)
                          .colorScheme
                          .primary
                          .withOpacity(.3),
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: Text('Welcome back, ', style: defaultTS),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: Text('${qrCodeData.studentName}.',
                        style: userNameTS),
                  ),
                ],
              ),
            )
          ],
        ),
      ],
    );
  }
}
