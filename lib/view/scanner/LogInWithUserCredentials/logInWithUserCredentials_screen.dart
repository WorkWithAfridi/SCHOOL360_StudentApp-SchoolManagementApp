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
  TextEditingController studentIDTextController = TextEditingController();
  TextEditingController passwordTextController = TextEditingController();
  bool _isLoadingLoggingIn = false;
  bool rememberMe = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        elevation: 6,
        title: Text(
          'Log In',
          style: headerTSWhite,
        ),
        centerTitle: true,
      ),
      backgroundColor: white,
      body: Container(
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
              child: Column(
                children: [
                  _isLoadingLoggingIn
                      ? LinearProgressIndicator(
                          color: red,
                        )
                      : Container(),
                  Expanded(
                    child: SingleChildScrollView(
                      physics: BouncingScrollPhysics(),
                      child: Column(
                        children: [
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: 25),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
                                  height:
                                      MediaQuery.of(context).size.height * .1,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      'Powered By   ',
                                      style: headerTSBlack.copyWith(
                                          fontSize: 15,
                                          fontWeight: FontWeight.w400,
                                          color: black.withOpacity(.8)),
                                    ),
                                    Container(
                                      // color: Colors.red,
                                      height:
                                          MediaQuery.of(context).size.height *
                                              .1,
                                      width:
                                          MediaQuery.of(context).size.height *
                                              .2,
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
                                      style:
                                          headerTSBlack.copyWith(fontSize: 30),
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
                                    textEditingController:
                                        studentIDTextController,
                                    hintText: 'Please enter your ID.',
                                    textInputType: TextInputType.number),
                                SizedBox(
                                  height: 6,
                                ),
                                CustomTextField(
                                  textEditingController: passwordTextController,
                                  hintText: 'Please enter your password.',
                                  textInputType: TextInputType.text,
                                  isPass: true,
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      rememberMe = !rememberMe;
                                    });
                                  },
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
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
                                ),
                                // SizedBox(
                                //   height: 0
                                // ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 25.0),
                                  child: Divider(
                                    color: black.withOpacity(.5),
                                  ),
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                Container(
                                  width: MediaQuery.of(context).size.width,
                                  height: 40,
                                  child: ElevatedButton(
                                    onPressed: () async {
                                      setState(() {
                                        _isLoadingLoggingIn = true;
                                      });
                                      String schoolId =
                                          schoolTextController.text;
                                      String studentId =
                                          studentIDTextController.text;
                                      String password =
                                          passwordTextController.text;

                                      if (studentId.isEmpty ||
                                          schoolId.isEmpty ||
                                          password.isEmpty) {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                          SnackBar(
                                            content: Text(
                                              'User credentials cannot be empty! Please try again.',
                                              style: defaultTSWhite,
                                            ),
                                            backgroundColor: red,
                                          ),
                                        );
                                        await Future.delayed(
                                            Duration(seconds: 1));
                                        setState(() {
                                          _isLoadingLoggingIn = false;
                                        });
                                      }
                                      checkCredentials(
                                          schoolId, studentId, password);
                                    },
                                    child: Text(
                                      'Log In',
                                      style: headerTSWhite,
                                    ),
                                    style: ElevatedButton.styleFrom(
                                        primary: red, elevation: 6),
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
                                Container(
                                  height:
                                  MediaQuery.of(context).size.height * .1,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void checkCredentials(
      String schoolId, String studentId, String password) async {
    await Future.delayed(Duration(seconds: 1));
  }
}
