import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:school_360_app/functions/globar_variables.dart';
import 'package:school_360_app/provider/appData.dart';
import 'package:school_360_app/provider/dashboard.dart';
import 'package:school_360_app/provider/invoice.dart';
import 'package:school_360_app/provider/qrcode_data.dart';
import 'package:school_360_app/view/school_hub/tabs/dashboard/widgets/getAnnouncement.dart';
import 'package:school_360_app/view/school_hub/tabs/dashboard/widgets/getAttendanceSummary.dart';
import 'package:school_360_app/view/school_hub/tabs/dashboard/widgets/getPastPayments.dart';
import 'package:school_360_app/view/school_hub/tabs/dashboard/widgets/getWelcomeMessage.dart';

import '../../payment_receipts.dart';

class DashboardTab extends StatefulWidget {
  const DashboardTab({Key? key})
      : super(
          key: key,
        );

  @override
  _DashboardTabState createState() => _DashboardTabState();
}

class _DashboardTabState extends State<DashboardTab> {
  late TextStyle headerTextStyleBlack;
  late TextStyle headerTextStyleWhite;
  late TextStyle normalTextStyle;
  late TextStyle normalHighLightTextStyle;
  late AppData appData;
  bool showLoadingStatus = true;
  late QRCodeDataProvider qrCodeData;
  late DashboardProvider dashboardProvider;

  Future<void> getData() async {
    print(DateFormat('yyyy').format(DateTime.now()).toString());
    qrCodeData = Provider.of<QRCodeDataProvider>(context, listen: false);
    appData = Provider.of<AppData>(context, listen: false);
    headerTextStyleBlack = appData.headerTextStyleBlack;
    headerTextStyleWhite = appData.headerTextStyleWhite;
    normalTextStyle = appData.normalTextStyle;
    normalHighLightTextStyle = appData.normalHighLightTextStyle;

    dashboardProvider = Provider.of<DashboardProvider>(context, listen: false);
    dashboardProvider.pageNoForPayment = 0;
    await dashboardProvider.getPastPaymentList(context);
    await dashboardProvider.getNotice(context);
    await dashboardProvider.getDashboardAttendance(context);
    setState(() {
      showLoadingStatus = false;
    });
  }

  @override
  void initState() {
    super.initState();
    showLoadingStatus = true;
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<DashboardProvider>(
        builder: (context, provider, childProperty) {
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
            child: showLoadingStatus ? showLoading() : showDashboard(context),
          ),
          provider.showAlertBox
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
    return Consumer<DashboardProvider>(
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
                  if (provider.alertBoxButtonAction == "Retry") {
                    showLoadingStatus = true;
                    getData();
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

  SizedBox showDashboard(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      // color: Colors.red,
      // padding: EdgeInsets.symmetric(horizontal: 15),
      child: LiquidPullToRefresh(
        onRefresh: getData,
        height: 100,
        color: black,
        animSpeedFactor: 2,
        showChildOpacityTransition: false,
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              GetWelcomeMessage(),
              GetAttendanceSummary(),
              GetAnnouncement(),
              GetPastPayment()
            ],
          ),
        ),
      ),
    );
  }

  Widget showLoading() {
    return appData.showLoading(context);
  }
}
