import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:school_360_app/provider/appData.dart';
import 'package:school_360_app/provider/attendance.dart';
import 'package:school_360_app/provider/result.dart';

import '../../../../functions/globar_variables.dart';

class AttendanceReportTable_Page extends StatefulWidget {
  static const routeName = '/school_hub/result_tabs/AttendanceReportTable_Page';
  AttendanceReportTable_Page({Key? key}) : super(key: key);

  @override
  State<AttendanceReportTable_Page> createState() =>
      _AttendanceReportTable_PageState();
}

class _AttendanceReportTable_PageState
    extends State<AttendanceReportTable_Page> {
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
          'Attendance Report',
          style: headerTSWhite,
        ),
      ),
      backgroundColor: white,
      body: Stack(
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
          Consumer<AttendanceProvider>(
              builder: (context, provider, childProperty) {
            return Container(
              padding: EdgeInsets.only(left: 5, right: 5, top: 0),
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.height,
              child: SingleChildScrollView(
                physics: BouncingScrollPhysics(),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 10,
                    ),
                    provider.getCalender(),
                    const SizedBox(
                      height: 5,
                    ),
                    Card(
                      elevation: 4,
                      child: Container(
                        padding: const EdgeInsets.all(10.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 5),
                              color: Theme.of(context).colorScheme.primary,
                              width: double.infinity,
                              child: Container(
                                width: 60,
                                child: Text('Student Information',
                                    style: headerTSWhite),
                              ),
                            ),
                            SizedBox(
                              height: 2,
                            ),
                            Container(
                              padding: EdgeInsets.symmetric(horizontal: 10),
                              child: Row(
                                children: [
                                  Text('Showing result for the month:',
                                      style: defaultTS),
                                  Text(
                                    ' ${provider.selectedMonth.substring(0, 3)} - ${provider.selectedYear}',
                                    style: defaultHighLightedTS,
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.symmetric(horizontal: 10),
                              child: Row(
                                children: [
                                  Text('Student Name:', style: defaultTS),
                                  Text(
                                    ' ${provider.dataModelForAttendance.data!.name.toString()}',
                                    style: defaultHighLightedTS,
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.symmetric(horizontal: 10),
                              child: Row(
                                children: [
                                  Text('Student Code:', style: defaultTS),
                                  Text(
                                    ' ${provider.dataModelForAttendance.data!.studentCode.toString()}',
                                    style: defaultHighLightedTS,
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.symmetric(horizontal: 10),
                              child: Row(
                                children: [
                                  Text('Student of:', style: defaultTS),
                                  Text(
                                    ' ${provider.dataModelForAttendance.data!.className.toString()}',
                                    style: defaultHighLightedTS,
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.symmetric(horizontal: 10),
                              child: Row(
                                children: [
                                  Text('Class:', style: defaultTS),
                                  Text(
                                    ' ${provider.selectedCourse}',
                                    style: defaultHighLightedTS,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Card(
                      elevation: 4,
                      child: Container(
                        padding: const EdgeInsets.all(10.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 5),
                              color: Theme.of(context).colorScheme.primary,
                              width: double.infinity,
                              child: Container(
                                width: 60,
                                child: Text('Attendance Summary',
                                    style: headerTSWhite),
                              ),
                            ),
                            const SizedBox(
                              height: 2,
                            ),
                            Container(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10),
                              child: Row(
                                children: [
                                  Text('Total Holidays:', style: defaultTS),
                                  Text(
                                    ' ${provider.dataModelForAttendance.data!.totalHolidays.toString()}',
                                    style: defaultHighLightedTS,
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.symmetric(horizontal: 10),
                              child: Row(
                                children: [
                                  Text('Total Present days: ',
                                      style: defaultTS),
                                  Text(
                                    '${provider.dataModelForAttendance.data!.totalPresentDays.toString()}',
                                    style: defaultHighLightedTS,
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.symmetric(horizontal: 10),
                              child: Row(
                                children: [
                                  Text('Total Absent days:', style: defaultTS),
                                  Text(
                                    ' ${provider.dataModelForAttendance.data!.totalAbsentDays.toString()}',
                                    style: defaultHighLightedTS,
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.symmetric(horizontal: 10),
                              child: Row(
                                children: [
                                  Text('Total Leave days:', style: defaultTS),
                                  Text(
                                    ' ${provider.dataModelForAttendance.data!.totalLeaveDays.toString()}',
                                    style: defaultHighLightedTS,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Card(
                      elevation: 4,
                      child: Container(
                        padding: const EdgeInsets.all(10.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 5),
                              color: Theme.of(context).colorScheme.primary,
                              width: double.infinity,
                              child: Container(
                                width: 60,
                                child: Text('Attendance Breakdown',
                                    style: headerTSWhite),
                              ),
                            ),
                            // Container(
                            //   padding: EdgeInsets.symmetric(
                            //       horizontal: 10, vertical: 5),
                            //   color: Theme.of(context).colorScheme.primary,
                            //   width: double.infinity,
                            //   child: Row(
                            //     children: [
                            //       Container(
                            //         width: 60,
                            //         child: Text(
                            //           'Date',
                            //           style: GoogleFonts.getFont(
                            //             'Ubuntu',
                            //             textStyle: const TextStyle(
                            //                 color: Colors.white,
                            //                 fontWeight: FontWeight.bold,
                            //                 fontSize: 17),
                            //           ),
                            //         ),
                            //       ),
                            //       const SizedBox(
                            //         width: 5,
                            //       ),
                            //       Expanded(
                            //         child: Text(
                            //           'Status',
                            //           style: GoogleFonts.getFont(
                            //             'Ubuntu',
                            //             textStyle: const TextStyle(
                            //                 color: Colors.white,
                            //                 fontWeight: FontWeight.bold,
                            //                 fontSize: 17),
                            //           ),
                            //         ),
                            //       ),
                            //     ],
                            //   ),
                            // ),
                            Column(
                              children: [
                                ListView.builder(
                                  physics: NeverScrollableScrollPhysics(),
                                  shrinkWrap: true,
                                  itemCount: provider.dataModelForAttendance
                                      .data!.attendanceInfo!.length
                                      .toInt(),
                                  itemBuilder: (context, index) {
                                    return Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 5),
                                      child: Container(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 10),
                                        height: 35,
                                        // color: Colors.red,
                                        child: Row(
                                          children: [
                                            Container(
                                                width: 60,
                                                alignment:
                                                    Alignment.bottomCenter,
                                                child: RichText(
                                                  text: TextSpan(
                                                    style: DefaultTextStyle.of(
                                                            context)
                                                        .style,
                                                    children: <TextSpan>[
                                                      TextSpan(
                                                        text: (index + 1)
                                                            .toString(),
                                                        style: headerTSBlack,
                                                      ),
                                                      TextSpan(
                                                        text: 'th ',
                                                        style:
                                                            GoogleFonts.getFont(
                                                          'Ubuntu',
                                                          textStyle: defaultTS,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                )),
                                            const SizedBox(
                                              width: 5,
                                            ),
                                            Expanded(
                                              child: Container(
                                                height: double.infinity,
                                                // color: Colors.purple,
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.end,
                                                  children: [
                                                    Text(
                                                      provider
                                                          .dataModelForAttendance
                                                          .data!
                                                          .attendanceInfo![
                                                              index]
                                                          .status
                                                          .toString(),
                                                      style: headerTSBlack
                                                          .copyWith(
                                                        color: provider
                                                                    .dataModelForAttendance
                                                                    .data!
                                                                    .attendanceInfo![
                                                                        index]
                                                                    .status
                                                                    .toString() ==
                                                                'Present'
                                                            ? red
                                                            : black,
                                                      ),
                                                    ),
                                                    // const SizedBox(
                                                    //   height: 5,
                                                    // ),
                                                    Container(
                                                      width: double.infinity,
                                                      height: 1,
                                                      color: provider
                                                                  .dataModelForAttendance
                                                                  .data!
                                                                  .attendanceInfo![
                                                                      index]
                                                                  .status
                                                                  .toString() ==
                                                              'Present'
                                                          ? red
                                                          : black
                                                              .withOpacity(0.3),
                                                    )
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    );
                                  },
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                  ],
                ),
              ),
            );
          })
        ],
      ),
    );
  }
}
