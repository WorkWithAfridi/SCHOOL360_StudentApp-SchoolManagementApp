import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:school_360_app/view/scanner/LogInWithUserCredentials/logInWithUserCredentials_screen.dart';
import 'package:school_360_app/view/scanner/scanner_screen.dart';

import '../functions/globar_variables.dart';

class GetBottomSheet extends StatefulWidget {
  const GetBottomSheet({Key? key}) : super(key: key);

  @override
  _GetBottomSheetState createState() => _GetBottomSheetState();
}

class _GetBottomSheetState extends State<GetBottomSheet> {
  @override
  Widget build(BuildContext context) {
    return BackdropFilter(
      filter:
      ImageFilter.blur(sigmaX: 2, sigmaY: 2),
      child: Container(
          height: 220,
          width: MediaQuery.of(context).size.width,
          // height: 500,
          color: black,
          child: Column(
            children: [
              Container(
                // height: 20,
                padding: EdgeInsets.only(top: 10),
                width: MediaQuery.of(context)
                    .size
                    .width,
                alignment: Alignment.center,
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius:
                    BorderRadius.circular(5),
                    color: Colors.grey,
                  ),
                  height: 5,
                  width: MediaQuery.of(context)
                      .size
                      .width *
                      .1,
                ),
              ),
              Expanded(
                child: Column(
                  mainAxisAlignment:
                  MainAxisAlignment.center,
                  crossAxisAlignment:
                  CrossAxisAlignment.start,
                  children: [
                    // Container(
                    //   alignment: Alignment.center,
                    //   height: MediaQuery.of(context).size.height * .4,
                    //   width: MediaQuery.of(context).size.width,
                    //   child: Lottie.asset(
                    //       'lib/assets/lottieAnimation/lottie_animation_lock.json', repeat: false),
                    // ),
                    // SizedBox(
                    //   height: 20,
                    // ),
                    // Padding(
                    //   padding: EdgeInsets.symmetric(horizontal: 15),
                    //   child: Text(
                    //     'Please',
                    //     style: headerTSBlack.copyWith(fontSize: 30, height: .9),
                    //   ),
                    // ),
                    // Padding(
                    //   padding: EdgeInsets.symmetric(horizontal: 15),
                    //   child: Text(
                    //     'Choose',
                    //     style: headerTSBlack.copyWith(fontSize: 30, height: .9),
                    //   ),
                    // ),
                    // Padding(
                    //   padding: EdgeInsets.symmetric(horizontal: 15),
                    //   child: Text(
                    //     'a Log In method',
                    //     style: headerTSBlack.copyWith(fontSize: 30, height: .9),
                    //   ),
                    // ),
                    Row(
                      mainAxisAlignment:
                      MainAxisAlignment.center,
                      children: [
                        Text(
                          'Log In by:',
                          textAlign:
                          TextAlign.center,
                          style: defaultTS.copyWith(
                            color: Colors.white60,
                            fontSize: 11,
                            fontWeight:
                            FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: 15),
                      child: Card(
                        // shape: const RoundedRectangleBorder(
                        //     borderRadius: BorderRadius.all(Radius.circular(15))),
                        elevation: 10,
                        // color: Colors.transparent,
                        child: GestureDetector(
                          onTap: () {
                            Navigator.of(context)
                                .pop();
                            Navigator.of(context)
                                .pushNamed(
                              LogInWithUserCredentials
                                  .routeName,
                            );
                          },
                          child: Container(
                            // height: MediaQuery.of(context).size.height,
                            width: MediaQuery.of(
                                context)
                                .size
                                .width,
                            padding:
                            EdgeInsets.all(15),
                            alignment:
                            Alignment.center,
                            color:
                            Colors.transparent,
                            child: Text(
                              'Using User ID and Password',
                              style: defaultTS
                                  .copyWith(
                                  fontWeight:
                                  FontWeight
                                      .w600),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: 15),
                      child: Card(
                        // shape: const RoundedRectangleBorder(
                        //     borderRadius: BorderRadius.all(Radius.circular(15))),
                        elevation: 10,
                        color: Colors.white,
                        // color: Colors.transparent,
                        child: GestureDetector(
                          onTap: () {
                            Navigator.of(context)
                                .pop();
                            Navigator.of(context)
                                .pushNamed(
                                QRScanner
                                    .routeName,
                                arguments: {
                                  'Mode':
                                  'StudentID'
                                });
                            // Navigator.of(context).pushNamed(QRScanner.routeName,
                            //     arguments: {'Mode': 'StudentID'});
                          },
                          child: Container(
                            color:
                            Colors.transparent,
                            // height: MediaQuery.of(context).size.height,
                            width: MediaQuery.of(
                                context)
                                .size
                                .width,
                            padding:
                            EdgeInsets.all(15),
                            alignment:
                            Alignment.center,
                            // color: white,
                            child: Text(
                              'Scanning ID Card',
                              style: defaultTS
                                  .copyWith(
                                fontWeight:
                                FontWeight.w600,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Row(
                      mainAxisAlignment:
                      MainAxisAlignment.center,
                      children: [
                        Text(
                          'Terms & conditions',
                          style: defaultTS.copyWith(
                              color: Colors.white60,
                              fontSize: 10,
                              fontWeight:
                              FontWeight.w600),
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        Text(
                          '|',
                          style: defaultTS.copyWith(
                              color: Colors.white60,
                              fontSize: 10,
                              fontWeight:
                              FontWeight.w600),
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        Text(
                          'Privacy policy',
                          style: defaultTS.copyWith(
                              color: Colors.white60,
                              fontSize: 10,
                              fontWeight:
                              FontWeight.w600),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          )),
    );
  }
}
