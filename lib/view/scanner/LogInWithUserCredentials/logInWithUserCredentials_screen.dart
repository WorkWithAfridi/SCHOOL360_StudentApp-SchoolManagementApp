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
  bool rememberMe = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 6,
        title: Text(
          'Log In',
          style: headerTSWhite,
        ),
        centerTitle: true,
      ),
      backgroundColor: white,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 25),
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.height,
          child: Stack(
            children: [
              SizedBox(
                height: double.infinity,
                width: double.infinity,
                child: GridPaper(
                  color: red.withOpacity(0.05),
                  divisions: 4,
                  interval: 500,
                  subdivisions: 8,
                ),
              ),
              Container(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.height,
                child: SingleChildScrollView(
                  physics: BouncingScrollPhysics(),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        height: MediaQuery.of(context).size.height * .1,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Powered By ',
                            style: headerTSBlack.copyWith(fontWeight: FontWeight.w400),
                          ),
                          Container(
                            // color: Colors.red,
                            height: MediaQuery.of(context).size.height * .1,
                            width: MediaQuery.of(context).size.height * .2,
                            child: Image.asset(
                              'lib/assets/logo.png',
                              fit: BoxFit.cover,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 25,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            'Log In',
                            style: headerTSBlack.copyWith(fontSize: 30),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      CustomTextField(
                          textEditingController: schoolTextController,
                          hintText: 'Please enter your School ID.',
                          textInputType: TextInputType.number),
                      SizedBox(
                        height: 6,
                      ),
                      CustomTextField(
                          textEditingController: UserIDTextController,
                          hintText: 'Please enter your ID.',
                          textInputType: TextInputType.number),
                      SizedBox(
                        height: 6,
                      ),
                      CustomTextField(
                          textEditingController: PasswordTextController,
                          hintText: 'Please enter your password.',
                          textInputType: TextInputType.text),
                      SizedBox(
                        height: 5,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
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
                      // SizedBox(
                      //   height: 0
                      // ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 25.0),
                        child: Divider(
                          color: black.withOpacity(.5),
                        ),
                      ),
                      SizedBox(
                        height: 20,
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
                                  style: headerTSWhite,
                                ),
                                style: ElevatedButton.styleFrom(primary: red, elevation: 6),
                              ),
                            ),
                      SizedBox(
                        height: 15,
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('Forgotten your login details?',
                              style: defaultTS),
                          Text(' Get help with logging in.',
                              style: defaultHighLightedTS),
                        ],
                      ),
                      SizedBox(height: 35,)
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
