import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:school_360_app/model/notebook/data_model_for_notebook.dart';
import 'package:school_360_app/provider/appData.dart';
import 'package:school_360_app/provider/notebook.dart';
import 'package:school_360_app/view/school_hub/tabs/notebook/widgets/animation/coverLottieAnimation.dart';

import '../../../../functions/globar_variables.dart';

class NotebookTab extends StatefulWidget {
  static const routeName = '/school_hub/notebook_tabs';
  const NotebookTab({Key? key}) : super(key: key);
  @override
  State<NotebookTab> createState() => _NotebookTabState();
}

class _NotebookTabState extends State<NotebookTab> {
  late DateTime _selectedDateTime;
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
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      child: Consumer<NotebookProvider>(
          builder: (context, notebook, childProperty) {
        return Stack(
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
              width: MediaQuery.of(context).size.width,
              child: Stack(
                children: [
                  Positioned(
                      bottom: 0,
                      left: 0,
                      right: 0,
                      child:
                          notebook.showLoading ? showLoading() : Container()),
                  Container(
                    height: MediaQuery.of(context).size.height,
                    width: MediaQuery.of(context).size.width,
                    alignment: Alignment.center,
                    child: notebookDatePickerPage(context),
                  )
                ],
              ),
            ),
            notebook.showAlertBox
                ? SizedBox(
                    height: double.infinity,
                    width: double.infinity,
                    child: BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 2, sigmaY: 2),
                      child: AlertBoxLayout(context),
                    ),
                  )
                : Container(),
          ],
        );
      }),
    );
  }

  Container AlertBoxLayout(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 1,
      child: Consumer<NotebookProvider>(
          builder: (context, notebook, childProperty) {
        return AlertDialog(
          title: Text(notebook.alertBoxTitle, style: headerTSBlack),
          content: Text(notebook.alertBoxText, style: defaultTS),
          actions: <Widget>[
            Container(
              width: MediaQuery.of(context).size.width * 0.3,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: Theme.of(context).colorScheme.primary,
                ),
                onPressed: () {
                  setState(
                    () {
                      if (notebook.alertBoxButtonAction ==
                          "Close-StatusError") {
                        notebook.showNotebookList = false;
                        notebook.showLoading = false;
                        notebook.showAlertBox = false;
                      }
                      if (notebook.alertBoxButtonAction ==
                          "Close-NoInternetList") {
                        notebook.showAlertBox = false;
                        // notebook.getNotebookData(context);
                      }
                      if (notebook.alertBoxButtonAction == "Close") {
                        notebook.showAlertBox = false;
                        // notebook.getNotebookData(context);
                      }
                    },
                  );
                },
                child: Text(notebook.alertBoxButtonTitle),
              ),
            )
          ],
        );
      }),
    );
  }

  bool isLoading = false;
  Widget notebookDatePickerPage(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        isLoading
            ? LinearProgressIndicator(
                color: Theme.of(context).colorScheme.secondary,
              )
            : Container(),
        Expanded(
          // flex: 1,
          child: Container(
            // color: Colors.red,
            height: double.infinity,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CoverLottieAnimationForNotebook(),
                SizedBox(
                  height: 10,
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: RichText(
                    text: TextSpan(
                      style: DefaultTextStyle.of(context).style,
                      children: <TextSpan>[
                        TextSpan(text: 'Please select a ', style: defaultTS),
                        TextSpan(
                            text: 'Valid Date ', style: defaultHighLightedTS),
                        TextSpan(text: 'to view ', style: defaultTS),
                        TextSpan(
                            text: 'notebook.', style: defaultHighLightedTS),
                      ],
                    ),
                  ),
                ),
                // SizedBox(
                //   height: 2,
                // ),
                // Container(
                //   // color: Colors.red,
                //   alignment: Alignment.center,
                //   padding: const EdgeInsets.symmetric(horizontal: 15),
                //   child: Row(
                //     mainAxisAlignment: MainAxisAlignment.center,
                //     crossAxisAlignment: CrossAxisAlignment.center,
                //     children: [
                //       Consumer<NotebookProvider>(
                //         builder: (context, notebook, childProperty) {
                //           return Text('Date:  ', style: defaultTS);
                //         },
                //       ),
                //       Consumer<NotebookProvider>(
                //           builder: (context, notebook, childProperty) {
                //         return Text(notebook.pickedDate,
                //             style: defaultHighLightedTS);
                //       }),
                //     ],
                //   ),
                // ),
                SizedBox(
                  height: 10,
                ),
                GestureDetector(
                  onTap: () {
                    setDate();
                  },
                  child: Chip(
                    elevation: 4,
                    backgroundColor: black,
                    label: Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Container(
                        width: MediaQuery.of(context).size.width / 3,
                        alignment: Alignment.center,
                        child: Text('Select Date',
                            style: headerTSWhite.copyWith(fontSize: 15)),
                      ),
                    ),
                  ),
                ),
                // Container(
                //   alignment: Alignment.center,
                //   // color: Colors.blue,
                //   child: ElevatedButton(
                //     onPressed: setDate,
                //     style: ElevatedButton.styleFrom(
                //       primary: Colors.black.withOpacity(.8),
                //     ),
                //     child: Text(
                //       'Select Date',
                //       style: GoogleFonts.getFont(
                //         'Ubuntu',
                //         textStyle: TextStyle(
                //             fontWeight: FontWeight.bold,
                //             fontSize: 15,
                //             color: Theme.of(context).colorScheme.background),
                //       ),
                //     ),
                //   ),
                // ),
                const SizedBox(
                  height: 10,
                ),
              ],
            ),
          ),
        ),
        // Container(
        //   padding: const EdgeInsets.symmetric(horizontal: 15),
        //   child: Text(
        //     '📓 Notebook',
        //     style: headerTextStyleBlack,
        //   ),
        // ),
        // Container(
        //   alignment: Alignment.bottomCenter,
        //   child: Consumer<NotebookProvider>(
        //       builder: (context, notebook, childProperty) {
        //     return GestureDetector(
        //       onTap: () async {
        //         setState(() {
        //           isLoading = true;
        //         });
        //         // notebook.showLoading = true;
        //         notebook.getNotebookData(context);
        //         await Future.delayed(Duration(seconds: 1));
        //         setState(() {
        //           isLoading = false;
        //         });
        //       },
        //       child: Container(
        //         height: 40,
        //         width: MediaQuery.of(context).size.width,
        //         color: red,
        //         child: Padding(
        //           padding: const EdgeInsets.symmetric(horizontal: 10),
        //           child: Row(
        //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //             children: [
        //               Text(
        //                 'Next',
        //                 style: GoogleFonts.getFont(
        //                   'Ubuntu',
        //                   textStyle: headerTSWhite,
        //                 ),
        //               ),
        //               const SizedBox(
        //                 width: 3,
        //               ),
        //               Icon(
        //                 FontAwesomeIcons.arrowRight,
        //                 size: 16,
        //                 color: white,
        //               ),
        //             ],
        //           ),
        //         ),
        //       ),
        //     );
        //   }),
        // ),
      ],
    );
  }

  void setDate() async {
    NotebookProvider notebookProvider =
        Provider.of<NotebookProvider>(context, listen: false);
    _selectedDateTime = (await showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(2000),
            lastDate: DateTime.now())) ??
        DateTime.now();
    print(_selectedDateTime);

    if (_selectedDateTime.toString().endsWith('00:00:00.000')) {
      notebookProvider.pickedDate =
          DateFormat('yyyy-MM-dd').format(_selectedDateTime).toString();

      setState(() {
        isLoading = true;
      });
      // notebook.showLoading = true;
      notebookProvider.getNotebookData(context);
      await Future.delayed(Duration(seconds: 1));
      setState(() {
        isLoading = false;
      });
    }
  }

  Widget showLoading() {
    return Container(
      height: MediaQuery.of(context).size.height * .25,
      child: appData.showLoading(context),
    );
  }
}
