import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:school_360_app/functions/globar_variables.dart';
import 'package:school_360_app/model/student_id_validator.dart';
import 'package:school_360_app/provider/appData.dart';
import 'package:school_360_app/view/school_hub/tabs/notice/notice_tab.dart';

class NoticeScreen extends StatefulWidget {
  static const routeName = '/school-hub/notice_screen';
  const NoticeScreen({Key? key}) : super(key: key);

  @override
  _NoticeScreenState createState() => _NoticeScreenState();
}

class _NoticeScreenState extends State<NoticeScreen> {
  late PageController pageController;
  late var borderRadius = 15.0;
  String schoolId = "";
  String studentId = "";
  late TextStyle headerTextStyleBlack;
  late TextStyle headerTextStyleWhite;
  late TextStyle normalTextStyle;
  late TextStyle normalHighLightTextStyle;
  late AppData appData;
  late StudentIdValidator studentIdValidator;
  bool isMenuOpen = false;

  void getData() {
    appData = Provider.of<AppData>(context, listen: false);
    pageController = PageController(initialPage: appData.selectedTab);
    headerTextStyleBlack = appData.headerTextStyleBlack;
    headerTextStyleWhite = appData.headerTextStyleWhite;
    normalTextStyle = appData.normalTextStyle;
    normalHighLightTextStyle = appData.normalHighLightTextStyle;
  }

  @override
  void initState() {
    getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: black,
        // backgroundColor: Theme.of(context).colorScheme.background,
        elevation: 6,
        title: Text(
          'Announcements',
          style: headerTSWhite,
        ),
        centerTitle: true,
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
      ),
      body: NoticeTab(),
      backgroundColor: white,
    );
  }
}
