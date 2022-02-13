import 'package:flutter/material.dart';
import 'package:school_360_app/functions/globar_variables.dart';
import 'package:school_360_app/view/scanner/LogInWithUserCredentials/widgets/text_field_input.dart';

class LogInWithUserCredentials extends StatefulWidget {
  static const routeName = '/Scanner/LogInWithUserCredentials';
  const LogInWithUserCredentials({Key? key}) : super(key: key);

  @override
  _LogInWithUserCredentialsState createState() =>
      _LogInWithUserCredentialsState();
}

class _LogInWithUserCredentialsState extends State<LogInWithUserCredentials> {
  TextEditingController schoolTextController = TextEditingController();
  TextEditingController UserIDTextController = TextEditingController();
  TextEditingController PasswordTextController = TextEditingController();
  bool _isLoadingLoggingIn = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Log In',
          style: headerTSWhite,
        ),
        centerTitle: true,
      ),
      backgroundColor: white,
      body: Container(
        padding: EdgeInsets.all(25),
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.height,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CustomTextField(
                textEditingController: schoolTextController,
                hintText: 'Please enter your School ID.',
                textInputType: TextInputType.number),
            SizedBox(
              height: 5,
            ),
            CustomTextField(
                textEditingController: UserIDTextController,
                hintText: 'Please enter your ID.',
                textInputType: TextInputType.number),
            SizedBox(
              height: 5,
            ),
            CustomTextField(
                textEditingController: PasswordTextController,
                hintText: 'Please enter your password.',
                textInputType: TextInputType.text),
            SizedBox(
              height: 5,
            ),
            _isLoadingLoggingIn
                ? CircularProgressIndicator(
                    color: red,
                  )
                : Container(
                    width: MediaQuery.of(context).size.width,
                    height: 40,
                    child: ElevatedButton(
                      onPressed: () async {},
                      child: Text(
                        'Log in',
                        style: headerTSBlack,
                      ),
                      style: ElevatedButton.styleFrom(
                          primary: Theme.of(context).primaryColor),
                    ),
                  ),
            SizedBox(
              height: 15,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Forgotten your login details?', style: defaultTS),
                Text(' Get help with logging in.', style: defaultHighLightedTS),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
