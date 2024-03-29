import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:school_360_app/functions/globar_variables.dart';
import 'package:school_360_app/model/student_id_validator.dart';
import 'package:school_360_app/provider/appData.dart';
import 'package:school_360_app/provider/notice.dart';
import 'package:school_360_app/provider/qrcode_data.dart';
import 'package:school_360_app/view/home_screen.dart';
import 'package:school_360_app/view/school_hub/payment_receipts.dart';
import 'package:school_360_app/view/school_hub/tabs/attendance/attendance_tab.dart';
import 'package:school_360_app/view/school_hub/tabs/dashboard/dashboard_tab.dart';
import 'package:school_360_app/view/school_hub/tabs/notebook/notebook_tab.dart';
import 'package:school_360_app/view/school_hub/tabs/notice/Notice_screen.dart';
import 'package:school_360_app/view/school_hub/tabs/payment/payment_tab.dart';
import 'package:school_360_app/view/school_hub/tabs/result/result_tab.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../provider/dashboard.dart';

class SchoolHub extends StatefulWidget {
  static const routeName = '/school-hub';
  const SchoolHub({Key? key}) : super(key: key);

  @override
  State<SchoolHub> createState() => _SchoolHubState();
}

class _SchoolHubState extends State<SchoolHub> {
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
  int pageNo = 0;

  void getData() {
    appData = Provider.of<AppData>(context, listen: false);
    appData.selectedTab = 0;
    qrCodeData = Provider.of<QRCodeDataProvider>(context, listen: false);
    debugCounterMenuHome = 0;
    pageController = PageController(initialPage: appData.selectedTab);
    headerTextStyleBlack = appData.headerTextStyleBlack;
    debugCounterHubAppbar = 0;
    headerTextStyleWhite = appData.headerTextStyleWhite;
    normalTextStyle = appData.normalTextStyle;
    debugCounterMenuButton = 0;
    normalHighLightTextStyle = appData.normalHighLightTextStyle;
    getNumberForNoticeBadge();
  }

  // void show

  int numberOfNotifications = 0;
  late QRCodeDataProvider qrCodeData;
  @override
  void initState() {
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return mainPage(context);
  }

  Scaffold menuPage(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(0),
        child: AppBar(
          backgroundColor: black,
          elevation: 0,
          title: Text(
            'SCHOOL360',
            style: GoogleFonts.getFont(
              'Ubuntu',
              textStyle: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w800,
                color: Theme.of(context).colorScheme.primary,
              ),
            ),
          ),
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
          SizedBox(
            width: MediaQuery.of(context).size.width,
            child: Container(
              // color: Theme.of(context).colorScheme.secondary,
              // color: Colors.black,
              padding: const EdgeInsets.only(bottom: 15),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 6,
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.of(context).pop();
                    },
                    child: Container(
                      width: double.infinity,
                      alignment: Alignment.centerLeft,
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      height: 45,
                      child: Icon(
                        Icons.arrow_back,
                        color: black,
                        size: 25,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: CircleAvatar(
                      child: Lottie.asset(
                          'lib/assets/lottieAnimation/personLottieAnimation.json',
                          repeat: false,
                          fit: BoxFit.fill),
                      radius: MediaQuery.of(context).size.width * .1,
                      backgroundColor: Colors.transparent,
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  SizedBox(
                    height: 6,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: Text(
                      qrCodeData.studentName,
                      style: userNameTS,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: Divider(
                      color: black,
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.of(context).pop();
                      Navigator.of(context)
                          .pushNamed(PaymentReceiptPage.routeName);
                    },
                    child: Container(
                      height: 45,
                      alignment: Alignment.center,
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Icon(
                            FontAwesomeIcons.receipt,
                            color: black,
                            size: 22,
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          Text(
                            'Invoices',
                            style: defaultTS,
                          )
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // InkWell(
                          //   onTap: () {},
                          //   child: Container(
                          //     padding:
                          //         const EdgeInsets.symmetric(horizontal: 15),
                          //     height: 45,
                          //     child: Row(
                          //       children: [
                          //         Icon(
                          //           FontAwesomeIcons.slidersH,
                          //           color: black,
                          //           size: 22,
                          //         ),
                          //         const SizedBox(
                          //           width: 5,
                          //         ),
                          //         Text('Settings', style: defaultTS)
                          //       ],
                          //     ),
                          //   ),
                          // ),
                          InkWell(
                            onTap: () async {
                              isMenuOpen = false;

                              final prefs =
                                  await SharedPreferences.getInstance();
                              await prefs.remove('schoolId');
                              await prefs.remove('studentId');
                              await prefs.remove('studentName');
                              Navigator.pushNamedAndRemoveUntil(context,
                                  Homepage.routeName, (route) => false);
                            },
                            child: Container(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 15),
                              height: 45,
                              child: Row(
                                children: [
                                  Icon(
                                    FontAwesomeIcons.signOutAlt,
                                    color: black,
                                    size: 22,
                                  ),
                                  const SizedBox(
                                    width: 5,
                                  ),
                                  Text('Sign Out', style: defaultTS)
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  GlobalKey<ScaffoldState> scaffolKey = GlobalKey<ScaffoldState>();
  int debugCounter = 0;

  DefaultTabController mainPage(BuildContext context) {
    qrCodeData = Provider.of<QRCodeDataProvider>(context, listen: false);
    return DefaultTabController(
      length: 5,
      child: Scaffold(
        key: scaffolKey,
        drawer: Drawer(
          elevation: 4,
          child: menuPage(context),
        ),
        appBar: AppBar(
          backgroundColor: black,
          elevation: 6,
          title: GestureDetector(
            onTap: () {
              debugCounter++;
              if (debugCounter == 23) {
                appData = Provider.of<AppData>(context, listen: false);
                appData.showAppData(context);
              }
            },
            child: Text(
              pageNo == 0
                  ? '🎒 Home'
                  : pageNo == 1
                      ? '📓 Notebook'
                      : pageNo == 2
                          ? '👋 Attendance'
                          : pageNo == 3
                              ? '🅰️ Result'
                              : pageNo == 4
                                  ? '💳 Payment'
                                  : 'School 360',
              style: headerTSWhite,
            ),
          ),
          centerTitle: true,
          leading: IconButton(
            onPressed: () {
              scaffolKey.currentState?.openDrawer();
            },
            icon: Icon(
              FontAwesomeIcons.bars,
              color: white,
            ),
          ),
          actions: [Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              getBadgedBellButton(context),
              SizedBox(width: 5,)
            ],
          )],
        ),
        backgroundColor: white,
        body: SizedBox(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Column(
            children: [
              // Container(
              //   height: 50,
              //   color: Theme.of(context).colorScheme.primary,
              //   alignment: Alignment.centerLeft,
              //   child: Stack(
              //     children: [
              //       SizedBox(
              //         height: double.infinity,
              //         width: double.infinity,
              //         child: GridPaper(
              //           color: Colors.black.withOpacity(0.1),
              //           divisions: 10,
              //           interval: 800,
              //           subdivisions: 8,
              //         ),
              //       ),
              //       Column(
              //         mainAxisAlignment: MainAxisAlignment.center,
              //         children: [
              //           Row(
              //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //             children: [
              //               Padding(
              //                 padding: const EdgeInsets.only(left: 0),
              //                 child: Row(
              //                   mainAxisAlignment: MainAxisAlignment.start,
              //                   children: [
              //                     IconButton(
              //                       onPressed: () {
              //                         debugCounterMenuButton++;
              //                         toggleMenu();
              //                       },
              //                       icon: Icon(
              //                         isMenuOpen
              //                             ? FontAwesomeIcons.chevronLeft
              //                             : FontAwesomeIcons.bars,
              //                         size: 20,
              //                         color: Theme.of(context)
              //                             .colorScheme
              //                             .background,
              //                       ),
              //                     ),
              //                     Text('SCHOOL360',
              //                         style: headerTextStyleWhite),
              //                   ],
              //                 ),
              //               ),
              //               GestureDetector(
              //                 onTap: () {
              //                   if (debugCounterMenuButton > 2 &&
              //                       debugCounterMenuHome > 3 &&
              //                       debugCounterHubAppbar > 6) {
              //                     appData.showAppData(context);
              //                   } else {
              //                     if (debugCounterMenuButton > 2 &&
              //                         debugCounterMenuHome > 3) {
              //                       debugCounterHubAppbar++;
              //                     }
              //                   }
              //                 },
              //                 child: const Padding(
              //                   padding: EdgeInsets.only(right: 20.0),
              //                   child: Icon(
              //                     FontAwesomeIcons.hatCowboy,
              //                     color: Colors.transparent,
              //                   ),
              //                 ),
              //               )
              //             ],
              //           ),
              //         ],
              //       ),
              //     ],
              //   ),
              // ),
              Consumer<AppData>(builder: (context, provider, childProperty) {
                return Expanded(
                  child: PageView(
                    scrollDirection: Axis.horizontal,
                    controller: provider.pageController,
                    onPageChanged: (index) {
                      setState(() {
                        pageNo = index;
                      });
                      provider.selectedTab = index;
                    },
                    children: const [
                      DashboardTab(),
                      NotebookTab(),
                      AttendanceTab(),
                      ResultTab(),
                      PaymentTab(),
                    ],
                  ),
                );
              }),
              // Container(
              //   height: 50,
              //   // padding: EdgeInsets.symmetric(horizontal: 15),
              //   alignment: Alignment.center,
              //   child: customBottomNavBarRow(context),
              // ),
            ],
          ),
        ),
        bottomNavigationBar: BottomNavigationBar(
          showSelectedLabels: false,
          showUnselectedLabels: false,
          elevation: 2,
          currentIndex: pageNo,
          onTap: (int index) {
            if (index == 0) {
              setState(() {
                pageNo = 0;
              });
              appData.navigateToPage(0);
            }
            if (index == 1) {
              setState(() {
                pageNo = 1;
              });
              appData.navigateToPage(1);
            }
            if (index == 2) {
              setState(() {
                pageNo = 2;
              });
              appData.navigateToPage(2);
            }
            if (index == 3) {
              setState(() {
                pageNo = 3;
              });
              appData.navigateToPage(3);
            }
            if (index == 4) {
              setState(() {
                pageNo = 4;
              });
              appData.navigateToPage(4);
            }
          },
          selectedItemColor: red,
          unselectedItemColor: black,
          type: BottomNavigationBarType.fixed,
          items: [
            BottomNavigationBarItem(
                icon: Icon(FontAwesomeIcons.home),
                label: ' ',
                backgroundColor: white),
            BottomNavigationBarItem(
                icon: Icon(
                  FontAwesomeIcons.book,
                ),
                label: '',
                backgroundColor: white),
            BottomNavigationBarItem(
                icon: Icon(
                  FontAwesomeIcons.clipboardCheck,
                ),
                label: '',
                backgroundColor: white),
            BottomNavigationBarItem(
                icon: Icon(
                  FontAwesomeIcons.starHalfAlt,
                ),
                label: '',
                backgroundColor: white),
            BottomNavigationBarItem(
                icon: Icon(FontAwesomeIcons.solidCreditCard),
                label: '',
                backgroundColor: white),
          ],
        ),
      ),
    );
  }

  void getNumberForNoticeBadge() async {
    String today = DateFormat('yyyy-MM-dd').format(DateTime.now());
    NoticeProvider provider =
        Provider.of<NoticeProvider>(context, listen: false);
    provider.pageNo = 0;
    provider.getNotice(context);
    await Future.delayed(Duration(seconds: 2));
    for (int i = 0; i < provider.dataModelForNotice.data!.length; i++) {
      //TODO: Undo the comment, in final version.
      // if (provider.dataModelForNotice.data![i].date.toString() == today)
      numberOfNotifications++;
    }
    setState(() {});
  }

  Widget getBadgedBellButton(BuildContext context) {
    return Consumer<DashboardProvider>(
        builder: (context, provider, childProperty) {
      return IconButton(
        onPressed: () {
          Navigator.of(context).pushNamed(NoticeScreen.routeName);
        },
        icon: !(numberOfNotifications == 0)
            ? Badge(
                elevation: 4,
                showBadge: true,
                animationType: BadgeAnimationType.slide,
                badgeContent: Text(
                  numberOfNotifications.toString(),
                  style: defaultHighLightedTS.copyWith(color: white),
                ),
                badgeColor: red,
                padding: EdgeInsets.all(05),
                child: Icon(
                  FontAwesomeIcons.bell,
                  color: white,
                ),
              )
            : Icon(
                FontAwesomeIcons.bell,
                color: white,
              ),
      );
    });
  }

  Widget customBottomNavBarRow(BuildContext context) {
    return SizedBox(
      height: double.infinity,
      width: MediaQuery.of(context).size.width,
      child: Consumer<AppData>(builder: (context, provider, childProperty) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Flexible(
              flex: 1,
              child: Container(
                height: double.infinity,
                width: double.infinity,
                color: Colors.white,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Flexible(
                      flex: 20,
                      child: IconButton(
                        onPressed: () {
                          try {
                            setState(() {
                              pageNo = 0;
                            });
                            provider.navigateToPage(0);
                          } catch (e) {}
                        },
                        icon: Icon(
                          FontAwesomeIcons.home,
                          color: appData.selectedTab == 0
                              ? Theme.of(context).colorScheme.secondary
                              : Theme.of(context).colorScheme.primary,
                          size: appData.selectedTab == 0 ? 30 : 20,
                        ),
                      ),
                    ),
                    Flexible(
                      flex: 1,
                      child: Container(
                        height: double.infinity,
                        width: double.infinity,
                        color: appData.selectedTab == 0
                            ? Theme.of(context).colorScheme.secondary
                            : Colors.transparent,
                      ),
                    )
                  ],
                ),
              ),
            ),
            Flexible(
              flex: 1,
              child: Container(
                height: double.infinity,
                width: double.infinity,
                color: Colors.white,
                child: Column(
                  children: [
                    Flexible(
                      flex: 20,
                      child: IconButton(
                        onPressed: () {
                          try {
                            setState(() {
                              pageNo = 1;
                            });
                            provider.navigateToPage(1);
                          } catch (e) {}
                        },
                        icon: Icon(
                          FontAwesomeIcons.book,
                          color: appData.selectedTab == 1
                              ? Theme.of(context).colorScheme.secondary
                              : Theme.of(context).colorScheme.primary,
                          size: appData.selectedTab == 1 ? 30 : 20,
                        ),
                      ),
                    ),
                    Flexible(
                      flex: 1,
                      child: Container(
                        height: double.infinity,
                        width: double.infinity,
                        color: appData.selectedTab == 1
                            ? Theme.of(context).colorScheme.secondary
                            : Colors.transparent,
                      ),
                    )
                  ],
                ),
              ),
            ),
            Flexible(
              flex: 1,
              child: Container(
                height: double.infinity,
                width: double.infinity,
                color: Colors.white,
                child: Column(
                  children: [
                    Flexible(
                      flex: 20,
                      child: IconButton(
                        onPressed: () {
                          try {
                            setState(() {
                              pageNo = 2;
                            });
                            provider.navigateToPage(2);
                          } catch (e) {}
                        },
                        icon: Icon(
                          FontAwesomeIcons.clipboardCheck,
                          color: appData.selectedTab == 2
                              ? Theme.of(context).colorScheme.secondary
                              : Theme.of(context).colorScheme.primary,
                          size: appData.selectedTab == 2 ? 30 : 20,
                        ),
                      ),
                    ),
                    Flexible(
                      flex: 1,
                      child: Container(
                        height: double.infinity,
                        width: double.infinity,
                        color: appData.selectedTab == 2
                            ? Theme.of(context).colorScheme.secondary
                            : Colors.transparent,
                      ),
                    )
                  ],
                ),
              ),
            ),
            Flexible(
              flex: 1,
              child: Container(
                height: double.infinity,
                width: double.infinity,
                color: Colors.white,
                child: Column(
                  children: [
                    Flexible(
                      flex: 20,
                      child: IconButton(
                        onPressed: () {
                          try {
                            setState(() {
                              pageNo = 3;
                            });
                            provider.navigateToPage(3);
                          } catch (e) {}
                        },
                        icon: Icon(
                          FontAwesomeIcons.starHalfAlt,
                          color: appData.selectedTab == 3
                              ? Theme.of(context).colorScheme.secondary
                              : Theme.of(context).colorScheme.primary,
                          size: appData.selectedTab == 3 ? 30 : 20,
                        ),
                      ),
                    ),
                    Flexible(
                      flex: 1,
                      child: Container(
                        height: double.infinity,
                        width: double.infinity,
                        color: appData.selectedTab == 3
                            ? Theme.of(context).colorScheme.secondary
                            : Colors.transparent,
                      ),
                    )
                  ],
                ),
              ),
            ),
            Flexible(
              flex: 1,
              child: Container(
                height: double.infinity,
                width: double.infinity,
                color: Colors.white,
                child: Column(
                  children: [
                    Flexible(
                      flex: 20,
                      child: IconButton(
                        onPressed: () {
                          try {
                            setState(() {
                              pageNo = 4;
                            });
                            provider.navigateToPage(4);
                          } catch (e) {}
                        },
                        icon: Icon(
                          FontAwesomeIcons.solidCreditCard,
                          color: appData.selectedTab == 4
                              ? Theme.of(context).colorScheme.secondary
                              : Theme.of(context).colorScheme.primary,
                          size: appData.selectedTab == 4 ? 30 : 20,
                        ),
                      ),
                    ),
                    Flexible(
                      flex: 1,
                      child: Container(
                        height: double.infinity,
                        width: double.infinity,
                        color: appData.selectedTab == 4
                            ? Theme.of(context).colorScheme.secondary
                            : Colors.transparent,
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        );
      }),
    );
  }

  int debugCounterMenuHome = 0;
  int debugCounterHubAppbar = 0;
  int debugCounterMenuButton = 0;
}
