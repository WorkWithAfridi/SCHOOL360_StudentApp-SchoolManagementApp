import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:school_360_app/functions/globar_variables.dart';
import 'package:school_360_app/provider/appData.dart';
import 'package:school_360_app/provider/result.dart';

class ResultCardPage extends StatefulWidget {
  static const routeName = '/school_hub/result_tabs/result_card';
  ResultCardPage({Key? key}) : super(key: key);

  @override
  State<ResultCardPage> createState() => _ResultCardPageState();
}

class _ResultCardPageState extends State<ResultCardPage> {
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
        backgroundColor: Colors.white,
        elevation: 6,
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: Icon(
            Icons.arrow_back,
            color: Theme.of(context).colorScheme.primary,
            size: 25,
          ),
        ),
        centerTitle: true,
        title: Text(
          '💯 Results',
          style: headerTextStyleBlack,
        ),
      ),
      backgroundColor: backgroundColor,
      body: Stack(
        children: [
          SizedBox(
            height: double.infinity,
            width: double.infinity,
            child: GridPaper(
              color: Colors.black.withOpacity(0.08),
              divisions: 4,
              interval: 500,
              subdivisions: 8,
            ),
          ),
          Consumer<ResultProvider>(
              builder: (context, resultProvider, childProperty) {
            return Container(
              // color: Colors.red,
              width: MediaQuery.of(context).size.width,
              padding: const EdgeInsets.only(left: 5, right: 5, top: 0),
              child: SingleChildScrollView(
                physics: BouncingScrollPhysics(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 10,
                    ),
                    Column(
                      children: [
                        SizedBox(
                          // height: 200 * 5,
                          child: ListView.builder(
                            physics: const NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: resultProvider
                                .dataModelForResult.resultInfo!.length
                                .toInt(),
                            itemBuilder: (context, index) {
                              return Padding(
                                padding: const EdgeInsets.only( bottom: 15.0),
                                child: Card(
                                  elevation: 4,
                                  child: Container(
                                    // height: 200,
                                    // color: Colors.yellow,
                                    padding: EdgeInsets.only(top: 10, left: 10, right: 10),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 10),
                                          color: Theme.of(context)
                                              .colorScheme
                                              .primary,
                                          width: double.infinity,
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                  resultProvider
                                                      .dataModelForResult
                                                      .resultInfo![index]
                                                      .name
                                                      .toString(),
                                                  style: headerTextStyleWhite),
                                            ],
                                          ),
                                        ),
                                        Container(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 10, vertical: 2),
                                          child: Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              Flexible(
                                                flex: 1,
                                                child: Container(
                                                  alignment: Alignment.topLeft,
                                                  child: Text(
                                                    'Grade: ',
                                                    style: normalTextStyle,
                                                  ),
                                                ),
                                              ),
                                              Flexible(
                                                flex: 1,
                                                child: Container(
                                                  alignment: Alignment.topLeft,
                                                  child: Text(
                                                      resultProvider
                                                          .dataModelForResult
                                                          .resultInfo![index]
                                                          .cAlphaGpaWithOptional
                                                          .toString(),
                                                      style:
                                                          normalHighLightTextStyle),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Container(
                                          width: double.infinity,
                                          height: 1,
                                          color: Colors.black.withOpacity(0.4),
                                        ),
                                        Container(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 10, vertical: 2),
                                          child: Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              Flexible(
                                                flex: 1,
                                                child: Container(
                                                  alignment: Alignment.topLeft,
                                                  child: Text(
                                                    'GPA: ',
                                                    style: normalTextStyle,
                                                  ),
                                                ),
                                              ),
                                              Flexible(
                                                flex: 1,
                                                child: Container(
                                                  alignment: Alignment.topLeft,
                                                  child: Text(
                                                      resultProvider
                                                          .dataModelForResult
                                                          .resultInfo![index]
                                                          .gpaWithOptional
                                                          .toString(),
                                                      style:
                                                          normalHighLightTextStyle),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Container(
                                          width: double.infinity,
                                          height: 1,
                                          color: Colors.black.withOpacity(0.4),
                                        ),
                                        Container(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 10, vertical: 2),
                                          child: Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              Flexible(
                                                flex: 1,
                                                child: Container(
                                                  alignment: Alignment.topLeft,
                                                  child: Text(
                                                    'Mark Obtained: ',
                                                    style: normalTextStyle,
                                                  ),
                                                ),
                                              ),
                                              Flexible(
                                                flex: 1,
                                                child: Container(
                                                  alignment: Alignment.topLeft,
                                                  child: Text(
                                                      resultProvider
                                                          .dataModelForResult
                                                          .resultInfo![index]
                                                          .totalObtainMark
                                                          .toString(),
                                                      style:
                                                          normalHighLightTextStyle),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Container(
                                          width: double.infinity,
                                          height: 1,
                                          color: Colors.black.withOpacity(0.4),
                                        ),
                                        Container(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 10, vertical: 2),
                                          child: Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              Flexible(
                                                flex: 1,
                                                child: Container(
                                                  alignment: Alignment.topLeft,
                                                  child: Text(
                                                    'Class Position: ',
                                                    style: normalTextStyle,
                                                  ),
                                                ),
                                              ),
                                              Flexible(
                                                flex: 1,
                                                child: Container(
                                                  alignment: Alignment.topLeft,
                                                  child: Text(
                                                      resultProvider
                                                          .dataModelForResult
                                                          .resultInfo![index]
                                                          .classPosition
                                                          .toString(),
                                                      style:
                                                          normalHighLightTextStyle),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Container(
                                          width: double.infinity,
                                          height: 1,
                                          color: Colors.black.withOpacity(0.4),
                                        ),
                                        Container(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 10, vertical: 2),
                                          child: Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              Flexible(
                                                flex: 1,
                                                child: Container(
                                                  alignment: Alignment.topLeft,
                                                  child: Text(
                                                    'Credits Completed: ',
                                                    style: normalTextStyle,
                                                  ),
                                                ),
                                              ),
                                              Flexible(
                                                flex: 1,
                                                child: Container(
                                                  alignment: Alignment.topLeft,
                                                  child: Text(
                                                      resultProvider
                                                          .dataModelForResult
                                                          .resultInfo![index]
                                                          .totalCredit
                                                          .toString(),
                                                      style:
                                                          normalHighLightTextStyle),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Container(
                                          width: double.infinity,
                                          height: 1,
                                          color: Colors.black.withOpacity(0.4),
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          children: [
                                            Chip(
                                              elevation: 0,
                                              backgroundColor: Theme.of(context)
                                                  .colorScheme
                                                  .secondary,
                                              label: Text(
                                                'View marksheet',
                                                style: GoogleFonts.getFont(
                                                  'Ubuntu',
                                                  textStyle: TextStyle(
                                                    decoration:
                                                        TextDecoration.none,
                                                    fontSize: 14,
                                                    fontWeight: FontWeight.bold,
                                                    color: Theme.of(context)
                                                        .colorScheme
                                                        .background,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        // const SizedBox(
                                        //   height: 25,
                                        // ),
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      ],
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
