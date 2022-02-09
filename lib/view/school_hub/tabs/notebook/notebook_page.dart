import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:school_360_app/provider/appData.dart';
import 'package:school_360_app/provider/notebook.dart';

import '../../../../functions/globar_variables.dart';

class NotebookPage extends StatefulWidget {
  static const routeName = '/school_hub/notebook_tabs/notebook_page';
  NotebookPage({Key? key}) : super(key: key);

  @override
  State<NotebookPage> createState() => _NotebookPageState();
}

class _NotebookPageState extends State<NotebookPage> {
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
          '📚 Notes',
          style: headerTSWhite,
        ),
      ),
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
              return Column(
                children: [
                  const SizedBox(
                    height: 10,
                  ),
                  Container(
                    padding: const EdgeInsets.only(left: 15, right: 15, top: 5),
                    child: SingleChildScrollView(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            notebook
                                .dataModelForNotebook
                                .data!
                                .noteBookList![notebook.selectedIndex]
                                .subjectName
                                .toString(),
                            style: headerTSBlack,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text('Date:', style: defaultTS),
                              Text(
                                ' ${notebook.dataModelForNotebook.data!.noteBookList![notebook.selectedIndex].date.toString()}',
                                style: defaultHighLightedTS,
                              ),
                            ],
                          ),
                          notebook
                                      .dataModelForNotebook
                                      .data!
                                      .noteBookList![notebook.selectedIndex]
                                      .fileLocation ==
                                  null
                              ? Container()
                              : Column(
                                  children: [
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        //TODO: Implement download feature on NoteBook detail page
                                        print('Start download');
                                      },
                                      child: Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.end,
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          Text(
                                            'Downloadable file:',
                                            style: defaultHighLightedTS,
                                          ),
                                          Icon(
                                            Icons.download,
                                            color: red,
                                            size: 16,
                                          )
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                          const SizedBox(
                            height: 15,
                          ),
                          Container(
                            height: 1,
                            width: double.infinity,
                            color: black,
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          Text(
                            notebook.dataModelForNotebook.data!
                                .noteBookList![notebook.selectedIndex].message
                                .toString(),
                            style: defaultTS,
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          Container(
                            height: 1,
                            width: double.infinity,
                            color: black,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
        ],
      ),
    );
  }
}
