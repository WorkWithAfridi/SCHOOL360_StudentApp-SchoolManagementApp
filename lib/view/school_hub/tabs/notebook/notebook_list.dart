import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:school_360_app/functions/globar_variables.dart';
import 'package:school_360_app/provider/appData.dart';
import 'package:school_360_app/provider/notebook.dart';
import 'package:school_360_app/view/school_hub/tabs/notebook/notebook_page.dart';

class NotebookList extends StatefulWidget {
  static const routeName = '/school_hub/notebook_tabs/notebook_list';
  NotebookList({Key? key}) : super(key: key);

  @override
  State<NotebookList> createState() => _NotebookListState();
}

class _NotebookListState extends State<NotebookList> {
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
          '📓 Notebook',
          style: headerTSWhite,
        ),
      ),
      backgroundColor: backgroundColor,
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
          Consumer<NotebookProvider>(
            builder: (context, notebook, childProperty) {
              return Container(
                padding: const EdgeInsets.only(left: 10, right: 10, top: 0),
                // color: Colors.pink,
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(
                        height: 10,
                      ),
                      // Container(
                      //   padding:
                      //   const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                      //   color: Theme.of(context).colorScheme.primary,
                      //   width: double.infinity,
                      //   child: SizedBox(
                      //     width: 60,
                      //     child: Text(
                      //       'Notes',
                      //       style: headerTextStyleWhite,
                      //     ),
                      //   ),
                      // ),
                      // const SizedBox(
                      //   height: 2,
                      // ),
                      notebook.dataModelForNotebook.data!.noteBookList!.isEmpty
                          ? Center(
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 10.0),
                                child: Text(
                                  'Its quite empty down here, maybe ask your teacher for some homework?',
                                  style: defaultTS,
                                ),
                              ),
                            )
                          : ListView.builder(
                              physics: const NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              itemCount: notebook.dataModelForNotebook.data!
                                  .noteBookList!.length,
                              itemBuilder: (BuildContext context, int index) {
                                return GestureDetector(
                                  onTap: () {
                                    notebook.selectedIndex = index;
                                    Navigator.of(context)
                                        .pushNamed(NotebookPage.routeName);
                                  },
                                  child: Card(
                                    elevation: 4,
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Container(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      vertical: 5,
                                                      horizontal: 10),
                                              child: Text(
                                                notebook
                                                    .dataModelForNotebook
                                                    .data!
                                                    .noteBookList![index]
                                                    .subjectName
                                                    .toString(),
                                                style: headerTSBlack,
                                              ),
                                            ),
                                            Container(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 10),
                                              child: Text(
                                                notebook
                                                    .dataModelForNotebook
                                                    .data!
                                                    .noteBookList![index]
                                                    .date
                                                    .toString(),
                                                style: defaultHighLightedTS,
                                              ),
                                            ),
                                          ],
                                        ),
                                        // Container(
                                        //   height: 1,
                                        //   width: double.infinity,
                                        //   color: Theme.of(context)
                                        //       .colorScheme
                                        //       .primary
                                        //       .withOpacity(.3),
                                        // ),
                                        // const SizedBox(
                                        //   height: 5,
                                        // ),
                                        // SizedBox(height: 5,),
                                        Container(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 10),
                                          child: Text(
                                            notebook.dataModelForNotebook.data!
                                                .noteBookList![index].message
                                                .toString(),
                                            maxLines: 4,
                                            overflow: TextOverflow.ellipsis,
                                            style: defaultTS,
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        // Container(
                                        //   height: 1,
                                        //   width: double.infinity,
                                        //   color: Theme.of(context)
                                        //       .colorScheme
                                        //       .primary
                                        //       .withOpacity(.3),
                                        // ),
                                        // const SizedBox(
                                        //   height: 5,
                                        // ),
                                      ],
                                    ),
                                  ),
                                );
                              },
                            )
                    ],
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget showLoading() {
    return appData.showLoading(context);
  }
}
