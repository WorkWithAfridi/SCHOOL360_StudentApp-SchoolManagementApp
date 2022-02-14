import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:school_360_app/functions/globar_variables.dart';
import 'package:school_360_app/model/attendance/data_model_for_attendance.dart';
import 'package:school_360_app/model/attendance/data_model_for_log_in_log_out_timings.dart';
import 'package:school_360_app/model/dropdown_list/data_model_for_course_dropdown_list.dart';
import 'package:school_360_app/model/dropdown_list/data_model_for_year_dropdown_list.dart';
import 'package:school_360_app/provider/appData.dart';
import 'package:school_360_app/provider/attendance.dart';

class AttendanceTab extends StatefulWidget {
  const AttendanceTab({Key? key}) : super(key: key);

  @override
  State<AttendanceTab> createState() => _AttendanceTabState();
}

class _AttendanceTabState extends State<AttendanceTab> {
  int _currentStep = 0;
  DataModelForAttendance dataModelForAttendance = DataModelForAttendance();
  DataModelForYearDropDown yearDropdownList = DataModelForYearDropDown();
  DataModelForCourseDropDown courseDropdownAPI = DataModelForCourseDropDown();
  DataModelForLogInLogOutTimings dataModelForLogInLogOutTimings =
      DataModelForLogInLogOutTimings();
  late TextStyle headerTextStyleBlack;
  late TextStyle headerTextStyleWhite;
  late TextStyle normalTextStyle;
  late TextStyle normalHighLightTextStyle;
  late AppData appData;
  late AttendanceProvider attendanceProvider;

  void getData() {
    appData = Provider.of<AppData>(context, listen: false);
    headerTextStyleBlack = appData.headerTextStyleBlack;
    headerTextStyleWhite = appData.headerTextStyleWhite;
    normalTextStyle = appData.normalTextStyle;
    normalHighLightTextStyle = appData.normalHighLightTextStyle;
    attendanceProvider =
        Provider.of<AttendanceProvider>(context, listen: false);
    attendanceProvider.getData(context);
  }

  @override
  void initState() {
    getData();
    super.initState();
  }

  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    return Consumer<AttendanceProvider>(
        builder: (context, attendance, childProperty) {
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
          attendance.showLoading
              ? showLoading()
              : attendanceParameterInputPage(context),
          attendance.showAlertBox
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
    });
  }

  Widget AlertBoxLayout(BuildContext context) {
    return Consumer<AttendanceProvider>(
      builder: (context, provider, childProperty) {
        return AlertDialog(
          title: Text(
            provider.alertBoxTitle,
            style: headerTSBlack,
          ),
          content: RichText(
            text: TextSpan(
              style: DefaultTextStyle.of(context).style,
              children: <TextSpan>[
                TextSpan(
                  text: provider.alertBoxText,
                  style: defaultTS,
                ),
              ],
            ),
          ),
          actionsAlignment: MainAxisAlignment.end,
          actions: [
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.3,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: Theme.of(context).colorScheme.primary,
                ),
                onPressed: () {
                  if (provider.alertBoxButtonAction == "Close") {
                    provider.getData(context);
                  }
                  if (provider.alertBoxButtonAction ==
                      "Close-NoInternetFMData") {
                    provider.showAlertBox = false;
                    provider.callApiForFMData(context);
                  }
                  if (provider.alertBoxButtonAction ==
                      "Close-NoInternetConnectionResult") {
                    provider.showAlertBox = false;
                    // provider.getResult(context);
                  }
                  if (provider.alertBoxButtonAction == "Close-error") {
                    provider.showAlertBox = false;
                    // provider.getResult(context);
                  }
                },
                child: Text(provider.alertBoxButtonTitle),
              ),
            )
          ],
        );
      },
    );
  }

  DropdownMenuItem<String> buildMonthMenuItem(String month) => DropdownMenuItem(
        value: month,
        child: Text(month),
      );
  DropdownMenuItem<String> buildYearMenuItem(String year) => DropdownMenuItem(
        value: year,
        child: Text(year),
      );
  DropdownMenuItem<String> buildYearCourseItem(String course) =>
      DropdownMenuItem(
        value: course,
        child: Text(course),
      );

  Widget attendanceParameterInputPage(BuildContext context) {
    return Consumer<AttendanceProvider>(
        builder: (context, provider, childProperty) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Padding(
          //   padding: const EdgeInsets.symmetric(horizontal: 20),
          //   child: Text(
          //     '👋 Attendance',
          //     style: headerTextStyleBlack,
          //   ),
          // ),
          isLoading
              ? LinearProgressIndicator(
                  color: red,
                )
              : Container(),
          Stepper(
            steps: [
              Step(
                isActive: (_currentStep == 0) ? true : false,
                title: RichText(
                  text: TextSpan(
                    style: DefaultTextStyle.of(context).style,
                    children: <TextSpan>[
                      TextSpan(
                        text: 'Please select a ',
                        style: defaultTS,
                      ),
                      TextSpan(
                        text: 'Month, ',
                        style: defaultHighLightedTS,
                      ),
                      TextSpan(
                        text: 'Year ',
                        style: defaultHighLightedTS,
                      ),
                      TextSpan(
                        text: 'and a ',
                        style: defaultTS,
                      ),
                      TextSpan(
                        text: 'Class Period ',
                        style: defaultHighLightedTS,
                      ),
                      TextSpan(
                        text: 'to continue.',
                        style: defaultTS,
                      )
                    ],
                  ),
                ),
                content: Container(
                  color:
                      Theme.of(context).colorScheme.background.withOpacity(.3),
                  child: Container(
                    // height: MediaQuery.of(context).size.height * .4,
                    width: MediaQuery.of(context).size.width * .8,
                    alignment: Alignment.center,
                    color: Colors.transparent,
                    child: Column(
                      children: [
                        Container(
                          padding: const EdgeInsets.only(right: 15),
                          alignment: Alignment.centerRight,
                          // color: Colors.red,
                          child: DropdownButtonHideUnderline(
                            child: DropdownButton(
                              dropdownColor: white,
                              style: defaultTS,
                              isExpanded: true,
                              elevation: 4,
                              value: provider.selectedMonth,
                              items: provider.months
                                  .map(buildMonthMenuItem)
                                  .toList(),
                              onChanged: (value) => setState(() {
                                provider.selectedMonth = value as String;
                              }),
                            ),
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.only(right: 15),
                          alignment: Alignment.centerRight,
                          // color: Colors.transparent,
                          width: double.infinity,
                          child: DropdownButtonHideUnderline(
                            child: DropdownButton(
                              dropdownColor: white,
                              style: defaultTS,
                              isExpanded: true,
                              elevation: 4,
                              value: provider.selectedYear,
                              items: provider.years
                                  .map(buildYearMenuItem)
                                  .toList(),
                              onChanged: (value) => setState(() {
                                provider.selectedYear = value as String;
                              }),
                            ),
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.only(right: 15),
                          alignment: Alignment.centerRight,
                          // color: Colors.red,
                          child: DropdownButtonHideUnderline(
                            child: DropdownButton(
                              dropdownColor: white,
                              style: defaultTS,
                              isExpanded: true,
                              elevation: 4,
                              value: provider.selectedCourse,
                              items: provider.courses
                                  .map(buildMonthMenuItem)
                                  .toList(),
                              onChanged: (value) => setState(
                                () {
                                  provider.selectedCourse = value as String;
                                },
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Step(
                isActive: (_currentStep == 1) ? true : false,
                title: RichText(
                  text: TextSpan(
                    style: DefaultTextStyle.of(context).style,
                    children: <TextSpan>[
                      TextSpan(text: 'Generate an ', style: defaultTS),
                      TextSpan(
                          text: 'Attendance report.',
                          style: defaultHighLightedTS),
                    ],
                  ),
                ),
                content: Container(
                  padding: const EdgeInsets.only(right: 25),
                  // height: MediaQuery.of(context).size.height * .4,
                  width: MediaQuery.of(context).size.width * .8,
                  alignment: Alignment.center,
                  // color: Colors.pink,
                  child: RichText(
                    text: TextSpan(
                      style: DefaultTextStyle.of(context).style,
                      children: <TextSpan>[
                        TextSpan(
                          text: 'Generating report for ',
                          style: defaultTS,
                        ),
                        TextSpan(
                            text: provider.selectedCourse,
                            style: defaultHighLightedTS),
                        TextSpan(
                          text: ' for ',
                          style: defaultTS,
                        ),
                        TextSpan(
                            text:
                                '${provider.selectedMonth}-${provider.selectedYear}.',
                            style: defaultHighLightedTS),
                      ],
                    ),
                  ),
                ),
              ),
            ],
            onStepContinue: () async {
              if (_currentStep == 0) {
                if (provider.selectedMonth != "Select month" &&
                    provider.selectedYear != "Select year" &&
                    provider.selectedCourse != "Select course") {
                  setState(() {
                    _currentStep += 1;
                  });
                  return;
                } else {
                  var snackBar = SnackBar(
                    backgroundColor: Theme.of(context).colorScheme.secondary,
                    content: Text(
                      'Please select a valid input to continue.',
                      style:
                          appData.normalTextStyle.copyWith(color: Colors.white),
                    ),
                  );
                  ScaffoldMessenger.of(context).showSnackBar(snackBar);
                }
              }
              if (_currentStep == 1) {
                setState(() {
                  isLoading = true;
                });
                print(isLoading);
                print('pressed continue;');
                //Generate attendance report
                if (provider.selectedCourse ==
                    "From Machine (Login & Logout)") {
                  int len =
                      provider.courseDropdownAPI.periodData!.length.toInt();
                  for (int i = 0; i < len; i++) {
                    if (provider.courseDropdownAPI.periodData![i].name ==
                        provider.selectedCourse) {
                      provider.selectedCourseID = provider
                          .courseDropdownAPI.periodData![i].id
                          .toString();
                    }
                  }

                  provider.callApiForFMData(context);
                  await Future.delayed(Duration(seconds: 1));
                  setState(() {
                    isLoading = false;
                  });
                } else {
                  // await Future.delayed(Duration(seconds: 5));
                  int len =
                      provider.courseDropdownAPI.periodData!.length.toInt();
                  for (int i = 0; i < len; i++) {
                    if (provider.courseDropdownAPI.periodData![i].name ==
                        provider.selectedCourse) {
                      provider.selectedCourseID = provider
                          .courseDropdownAPI.periodData![i].id
                          .toString();
                    }
                  }

                  provider.callApiForAttendanceData(context);

                  await Future.delayed(Duration(seconds: 1));
                  setState(() {
                    isLoading = false;
                  });
                }
              }
            },
            onStepCancel: () {
              if (_currentStep == 0) {
                // Navigator.of(context).pop();
              }
              if (_currentStep != 0) {
                setState(
                  () {
                    _currentStep -= 1;
                  },
                );
              }
            },
            currentStep: _currentStep,
          ),
        ],
      );
    });
  }

  Widget showLoading() {
    return appData.showLoading(context);
  }
}
