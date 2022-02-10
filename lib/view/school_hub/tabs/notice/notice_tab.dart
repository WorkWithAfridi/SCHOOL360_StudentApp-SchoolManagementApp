import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:math' as math;
import 'package:provider/provider.dart';
import 'package:school_360_app/functions/download_file.dart';
import 'package:school_360_app/provider/appData.dart';
import 'package:school_360_app/provider/notice.dart';
import 'package:school_360_app/provider/qrcode_data.dart';

import '../../../../functions/globar_variables.dart';

class NoticeTab extends StatefulWidget {
  const NoticeTab({Key? key}) : super(key: key);

  @override
  State<NoticeTab> createState() => _NoticeTabState();
}

class _NoticeTabState extends State<NoticeTab> {
  late bool showContent;
  late bool titleIsInEnglish;
  late int maxLine = 1;
  late NoticeProvider _notice;
  late QRCodeDataProvider _qrCodeData;
  late TextStyle headerTextStyleBlack;
  late TextStyle headerTextStyleWhite;
  late TextStyle normalTextStyle;
  late TextStyle normalHighLightTextStyle;
  late AppData appData;

  Future<void> _getData() async {
    appData = Provider.of<AppData>(context, listen: false);
    headerTextStyleBlack = appData.headerTextStyleBlack;
    headerTextStyleWhite = appData.headerTextStyleWhite;
    normalTextStyle = appData.normalTextStyle;
    normalHighLightTextStyle = appData.normalHighLightTextStyle;
    _notice = Provider.of<NoticeProvider>(context, listen: false);
    _notice.pageNo = 0;
    _qrCodeData = Provider.of<QRCodeDataProvider>(context, listen: false);
    await _notice.getNotice(context);
  }

  @override
  void initState() {
    _getData();
    titleIsInEnglish = true;
    super.initState();
  }

  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          height: double.infinity,
          width: double.infinity,
          child: GridPaper(
            color: red.withOpacity(0.05),
            divisions: 4,
            interval: 500,
            subdivisions: 5,
          ),
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 00, vertical: 0),
          width: double.infinity,
          height: MediaQuery.of(context).size.height,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // SizedBox(
              //   width: MediaQuery.of(context).size.width,
              //   // color: Colors.purple,
              //   child: Row(
              //     crossAxisAlignment: CrossAxisAlignment.end,
              //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //     children: [
              //       Text('📌 Notice Board',
              //           textAlign: TextAlign.left, style: headerTextStyleBlack),
              //       GestureDetector(
              //         onTap: () {
              //           setState(() {
              //             titleIsInEnglish = !titleIsInEnglish;
              //           });
              //         },
              //         child: Container(
              //           child:
              //               Text('ENG 🔄 BAN', style: normalHighLightTextStyle),
              //           alignment: Alignment.centerLeft,
              //         ),
              //       ),
              //     ],
              //   ),
              // ),
              // Row(
              //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //   children: [
              //     Text(
              //       '*Tap and hold title to expand title.',
              //       style: normalHighLightTextStyle,
              //     ),
              //     GestureDetector(
              //       onTap: () {
              //         if (maxLine == 1) {
              //           setState(() {
              //             maxLine = 3;
              //           });
              //         } else {
              //           setState(() {
              //             maxLine = 1;
              //           });
              //         }
              //       },
              //       child: maxLine == 3
              //           ? Row(
              //               children: [
              //                 Text('Shrink', style: normalTextStyle),
              //                 const Icon(
              //                   Icons.expand_less,
              //                   color: Colors.green,
              //                 ),
              //               ],
              //             )
              //           : Row(
              //               children: [
              //                 Text('Expand', style: normalTextStyle),
              //                 Icon(
              //                   Icons.expand_more,
              //                   color: Theme.of(context).colorScheme.secondary,
              //                 ),
              //               ],
              //             ),
              //     ),
              //   ],
              // ),

              isLoading
                  ? LinearProgressIndicator(
                      color: red,
                    )
                  : Container(),
              const SizedBox(
                height: 5,
              ),
              Expanded(
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 0),
                  child: SizedBox(
                    height: double.infinity,
                    child: Column(
                      children: [
                        // Container(
                        //   height: 40,
                        //   // color: Theme.of(context).colorScheme.primary,
                        //   color: Colors.black.withOpacity(.8),
                        //   child: Row(
                        //     mainAxisAlignment: MainAxisAlignment.center,
                        //     crossAxisAlignment: CrossAxisAlignment.center,
                        //     children: [
                        //       SizedBox(
                        //         width: 30,
                        //         child: Center(
                        //           child: Text('#', style: headerTextStyleWhite),
                        //         ),
                        //       ),
                        //       Expanded(
                        //         child: Text(
                        //           'Title',
                        //           style: headerTextStyleWhite,
                        //         ),
                        //       ),
                        //       Container(
                        //         // width: 80,
                        //         padding: const EdgeInsets.symmetric(horizontal: 10),
                        //         child: const Center(
                        //           child: Icon(
                        //             Icons.download,
                        //             color: Colors.white,
                        //             size: 17,
                        //           ),
                        //         ),
                        //       ),
                        //     ],
                        //   ),
                        // ),
                        // const SizedBox(
                        //   height: 5,
                        // ),
                        Consumer<NoticeProvider>(
                          builder: (context, notice, childProperty) {
                            return notice.showAlertBox
                                ? showAlertBox(context)
                                : notice.showLoading
                                    ? Expanded(
                                        child: Center(
                                          child: showLoading(),
                                        ),
                                      )
                                    : Expanded(
                                        child: getNoticeTable(),
                                      );
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              bottomNavigationBar(context),
            ],
          ),
        ),
      ],
    );
  }

  Expanded showAlertBox(BuildContext context) {
    return Expanded(
      child: Consumer<NoticeProvider>(
        builder: (context, notice, childProperty) {
          return AlertDialog(
            title: Text(
              notice.alertBoxTitle,
              style: headerTSBlack,
            ),
            content: RichText(
              text: TextSpan(
                style: DefaultTextStyle.of(context).style,
                children: <TextSpan>[
                  TextSpan(
                    text: notice.alertBoxText,
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
                    if (notice.alertBoxButtonAction ==
                        "Retry-NoInternetConnection") {
                      notice.showAlertBox = false;
                      notice.getNotice(context);
                    }
                    if (notice.alertBoxButtonAction == "Close-EndOfPage") {
                      notice.showAlertBox = false;
                      notice.getNotice(context);
                    }
                  },
                  child: Text(notice.alertBoxButtonTitle),
                ),
              )
            ],
          );
        },
      ),
    );
  }

  Widget bottomNavigationBar(BuildContext context) {
    return Container(
      height: 35,
      color: Theme.of(context).colorScheme.background,
      child: Consumer<NoticeProvider>(
        builder: (context, notice, childProperty) {
          return Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Consumer<NoticeProvider>(
                builder: (context, notice, child) {
                  return Flexible(
                    flex: 1,
                    child: GestureDetector(
                      onTap: () {
                        if (!notice.showAlertBox) {
                          if (notice.pageNo > 0) {
                            notice.showLoading = true;
                            notice.decrementPage();
                            notice.getNotice(context);
                          }
                        }
                      },
                      child: Container(
                        color: Colors.transparent,
                        height: double.infinity,
                        width: double.infinity,
                        child: Icon(
                          FontAwesomeIcons.chevronLeft,
                          color: notice.showAlertBox
                              ? Colors.grey
                              : notice.pageNo == 0
                                  ? Colors.grey
                                  : black,
                          size: 17,
                        ),
                      ),
                    ),
                  );
                },
              ),
              Flexible(
                flex: 1,
                child: Center(
                  child: Consumer<NoticeProvider>(
                    builder: (context, notice, child) {
                      return Text('page: ${notice.pageNo + 1}',
                          style: notice.showAlertBox
                              ? defaultTS.copyWith(color: Colors.grey)
                              : defaultTS);
                    },
                  ),
                ),
              ),
              Flexible(
                flex: 1,
                child: GestureDetector(
                  onTap: () {
                    if (!notice.showAlertBox) {
                      notice.showLoading = true;
                      _notice.incrementPage();
                      _notice.getNotice(context);
                    }
                  },
                  child: Container(
                    color: Colors.transparent,
                    height: double.infinity,
                    width: double.infinity,
                    child: Icon(
                      FontAwesomeIcons.chevronRight,
                      color: notice.showAlertBox ? Colors.grey : black,
                      size: 17,
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Consumer<NoticeProvider> getNoticeTable() {
    return Consumer<NoticeProvider>(
      builder: (context, notice, childProperty) {
        return SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ListView.builder(
                itemCount: notice.dataModelForNotice.data!.length.toInt(),
                physics: const BouncingScrollPhysics(),
                shrinkWrap: true,
                itemBuilder: (BuildContext context, int index) {
                  return GestureDetector(
                    onTap: () async {
                      setState(() {
                        isLoading = true;
                      });
                      String url =
                          "https://school360.app/${_qrCodeData.schoolId}/homes/download/notice~${notice.dataModelForNotice.data![index].url}";
                      Download download = Download();
                      download.downloadAndOpenFile(
                          url,
                          notice.dataModelForNotice.data![index].url
                              .toString());
                      await Future.delayed(Duration(seconds: 1));

                      setState(() {
                        isLoading = false;
                      });
                    },
                    child: Card(
                      elevation: 4,
                      child: ListTile(
                        trailing: Icon(
                          Icons.download,
                          color: red,
                        ),
                        leading: CircleAvatar(
                          backgroundColor: black,

                          // Color(
                          //         (math.Random().nextDouble() * 0xFFFFFF)
                          //             .toInt())
                          //     .withOpacity(1.0),
                          child: Text(
                            (index + 1).toString(),
                            style: headerTSWhite,
                          ),
                          // radius: 23,
                        ),
                        title: Text(
                            notice.dataModelForNotice.data![index].title
                                .toString(),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: headerTSBlack.copyWith(fontSize: 14)),
                        subtitle: Text(
                          "Uploaded on: ${notice.dataModelForNotice.data![index].date.toString()}",
                          style: subtitleTS,
                        ),
                      ),
                    ),
                  );

                  // Padding(
                  //   padding: const EdgeInsets.only(bottom: 5, top: 5),
                  //   child: SizedBox(
                  //     width: MediaQuery.of(context).size.width,
                  //     child: Column(
                  //       children: [
                  //         GestureDetector(
                  //           onTap: () {
                  //             String url =
                  //                 "https://school360.app/${_qrCodeData.schoolId}/homes/download/notice~${notice.dataModelForNotice.data![index].url}";
                  //             Download download = Download();
                  //             download.downloadAndOpenFile(
                  //                 url,
                  //                 notice.dataModelForNotice.data![index].url
                  //                     .toString());
                  //           },
                  //           onLongPress: () {
                  //             if (maxLine == 1) {
                  //               setState(() {
                  //                 maxLine = 3;
                  //               });
                  //             } else {
                  //               setState(() {
                  //                 maxLine = 1;
                  //               });
                  //             }
                  //           },
                  //           child: Row(
                  //             mainAxisAlignment: MainAxisAlignment.center,
                  //             crossAxisAlignment: CrossAxisAlignment.start,
                  //             children: [
                  //               Container(
                  //                 width: 30,
                  //                 alignment: Alignment.topCenter,
                  //                 child: Text(
                  //                   '${(index + 1).toString()}.',
                  //                   style: normalTextStyle,
                  //                 ),
                  //               ),
                  //               Expanded(
                  //                 child: Container(
                  //                   alignment: Alignment.topLeft,
                  //                   child: Column(
                  //                     crossAxisAlignment:
                  //                         CrossAxisAlignment.start,
                  //                     children: [
                  //                       Text(
                  //                           titleIsInEnglish
                  //                               ? notice.dataModelForNotice
                  //                                   .data![index].title
                  //                                   .toString()
                  //                               : notice.dataModelForNotice
                  //                                   .data![index].titleBn
                  //                                   .toString(),
                  //                           overflow: TextOverflow.ellipsis,
                  //                           maxLines: maxLine,
                  //                           style: normalTextStyle),
                  //                       Text(
                  //                         "Uploaded on: ${notice.dataModelForNotice.data![index].date.toString()}",
                  //                         style: normalTextStyle.copyWith(
                  //                             color:
                  //                                 Colors.black.withOpacity(.4),
                  //                             fontSize: 13),
                  //                       )
                  //                     ],
                  //                   ),
                  //                 ),
                  //               ),
                  //               Container(
                  //                 // width: 80,
                  //                 padding: const EdgeInsets.symmetric(
                  //                     horizontal: 10),
                  //                 child: Center(
                  //                   child: Icon(
                  //                     Icons.download,
                  //                     color: Theme.of(context)
                  //                         .colorScheme
                  //                         .secondary,
                  //                     size: 17,
                  //                   ),
                  //                 ),
                  //               ),
                  //             ],
                  //           ),
                  //         ),
                  //         const SizedBox(
                  //           height: 10,
                  //         ),
                  //         Container(
                  //           color: Theme.of(context)
                  //               .colorScheme
                  //               .onBackground
                  //               .withOpacity(0.4),
                  //           height: 1,
                  //         ),
                  //       ],
                  //     ),
                  //   ),
                  // );
                },
              ),
            ],
          ),
        );
      },
    );
  }

  Widget showLoading() {
    return appData.showLoading(context);
  }
}
