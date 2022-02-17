import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:school_360_app/provider/appData.dart';
import 'package:school_360_app/provider/dashboard.dart';
import 'package:school_360_app/provider/invoice.dart';

import '../../functions/globar_variables.dart';

class PaymentReceiptPage extends StatefulWidget {
  static const routeName = '/payment_receipts';
  const PaymentReceiptPage({Key? key}) : super(key: key);

  @override
  State<PaymentReceiptPage> createState() => _PaymentReceiptPageState();
}

class _PaymentReceiptPageState extends State<PaymentReceiptPage> {
  late TextStyle headerTextStyleBlack;
  late TextStyle headerTextStyleWhite;
  late TextStyle normalTextStyle;
  late TextStyle normalHighLightTextStyle;
  late AppData appData;
  late DashboardProvider dashboardProvider;
  bool isLoading = false;
  Future<void> getData() async {
    appData = Provider.of<AppData>(context, listen: false);
    headerTextStyleBlack = appData.headerTextStyleBlack;
    headerTextStyleWhite = appData.headerTextStyleWhite;
    normalTextStyle = appData.normalTextStyle;
    normalHighLightTextStyle = appData.normalHighLightTextStyle;
    dashboardProvider = Provider.of<DashboardProvider>(context, listen: false);
    dashboardProvider.pageNoForPayment = 0;
    await dashboardProvider.getPastPaymentList(context);
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
        centerTitle: true,
        title: Text(
          'Invoices',
          style: headerTSWhite,
        ),
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
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Stack(
          children: [
            SizedBox(
              height: double.infinity,
              width: double.infinity,
              child: GridPaper(
                color: red.withOpacity(0.05),
                divisions: 10,
                interval: 800,
                subdivisions: 8,
              ),
            ),
            Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              child: Column(
                children: [
                  isLoading
                      ? LinearProgressIndicator(
                          color: red,
                        )
                      : Container(),
                  Expanded(
                    child: SingleChildScrollView(
                      physics: BouncingScrollPhysics(),
                      child: Column(
                        children: [
                          Consumer<DashboardProvider>(
                              builder: (context, provider, childProperty) {
                            return provider
                                    .dataModelForPastPayment.data!.isEmpty
                                ? Container(
                                    width: MediaQuery.of(context).size.width,
                                    padding: EdgeInsets.symmetric(vertical: 10),
                                    alignment: Alignment.center,
                                    child: Text(
                                      'No Payment Data Found!',
                                      style: defaultTS,
                                    ),
                                  )
                                : SingleChildScrollView(
                                    physics: const BouncingScrollPhysics(),
                                    child: Column(
                                      children: [
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        ListView.builder(
                                          physics:
                                              NeverScrollableScrollPhysics(),
                                          shrinkWrap: true,
                                          itemCount: provider
                                              .dataModelForPastPayment
                                              .data!
                                              .length,
                                          itemBuilder: (context, index) {
                                            return Container(
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: 10, vertical: 2),
                                              child: GestureDetector(
                                                onTap: () async {
                                                  setState(() {
                                                    isLoading = true;
                                                  });
                                                  // Navigator.of(context)
                                                  //     .pushNamed(
                                                  //         OpenWebView.routeName,
                                                  //         arguments: {
                                                  //       'Url': provider
                                                  //           .dataModelForPastPayment
                                                  //           .data![index]
                                                  //           .url
                                                  //     });

                                                  InvoiceProvider
                                                      invoiceProvider = Provider
                                                          .of<InvoiceProvider>(
                                                              context,
                                                              listen: false);
                                                  invoiceProvider
                                                          .collection_id =
                                                      provider
                                                          .dataModelForPastPayment
                                                          .data![index]
                                                          .id
                                                          .toString();
                                                  invoiceProvider
                                                      .getInvoice(context);
                                                  await Future.delayed(
                                                      Duration(seconds: 1));
                                                  setState(() {
                                                    isLoading = false;
                                                  });
                                                },
                                                child: Card(
                                                  elevation: 4,
                                                  child: ListTile(
                                                    trailing: Icon(
                                                      FontAwesomeIcons.download,
                                                      color: red,
                                                    ),
                                                    leading: CircleAvatar(
                                                      backgroundColor: black,
                                                      // Color(
                                                      //     (math.Random().nextDouble() * 0xFFFFFF)
                                                      //         .toInt())
                                                      //     .withOpacity(1.0),
                                                      child: Text(
                                                        (index + 1).toString(),
                                                        style: headerTSWhite,
                                                      ),
                                                      radius: 23,
                                                    ),
                                                    title: Column(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .start,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Row(
                                                          children: [
                                                            Text('Bill No: ',
                                                                style:
                                                                    defaultTS),
                                                            Text(
                                                              '${provider.dataModelForPastPayment.data![index].receiptNo}',
                                                              style:
                                                                  defaultHighLightedTS,
                                                            ),
                                                          ],
                                                        ),
                                                        Row(
                                                          children: [
                                                            Text('Total: ',
                                                                style:
                                                                    defaultTS),
                                                            Text(
                                                              '${provider.dataModelForPastPayment.data![index].totalPaidAmount!.substring(0, provider.dataModelForPastPayment.data![index].totalPaidAmount!.length - 3)}',
                                                              style:
                                                                  defaultHighLightedTS,
                                                            ),
                                                            Text('Tk.',
                                                                style:
                                                                    defaultTS),
                                                          ],
                                                        ),
                                                      ],
                                                    ),
                                                    subtitle: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Text(
                                                          'Payed on: ${provider.dataModelForPastPayment.data![index].date}',
                                                          style: subtitleTS,
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            );
                                          },
                                        ),
                                        SizedBox(
                                          height: 15,
                                        )
                                      ],
                                    ),
                                  );
                          }),
                        ],
                      ),
                    ),
                  ),
                  bottomNavigationBar(context)
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget bottomNavigationBar(BuildContext context) {
    return Container(
      height: 35,
      color: Theme.of(context).colorScheme.background,
      child: Consumer<DashboardProvider>(
        builder: (context, provider, childProperty) {
          return Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Consumer<DashboardProvider>(
                builder: (context, provider, child) {
                  return Flexible(
                    flex: 1,
                    child: GestureDetector(
                      onTap: () {
                        if (!provider.showAlertBox) {
                          if (provider.pageNoForPayment > 0) {
                            provider.showLoading = true;
                            provider.decrementPage();
                            provider.getPastPaymentList(context);
                          }
                        }
                      },
                      child: Container(
                        color: Colors.transparent,
                        height: double.infinity,
                        width: double.infinity,
                        child: Icon(
                          FontAwesomeIcons.chevronLeft,
                          color: provider.showAlertBox
                              ? Colors.grey
                              : provider.pageNoForPayment == 0
                                  ? Colors.grey.withOpacity(1)
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
                  child: Consumer<DashboardProvider>(
                    builder: (context, notice, child) {
                      return Text('page: ${notice.pageNoForPayment + 1}',
                          style: notice.showAlertBox
                              ? defaultTS.copyWith(
                                  color: Colors.grey.withOpacity(.2))
                              : defaultTS);
                    },
                  ),
                ),
              ),
              Flexible(
                flex: 1,
                child: GestureDetector(
                  onTap: () {
                    if (!provider.showAlertBox) {
                      if (provider.dataModelForPastPayment.data!.isNotEmpty) {
                        provider.showLoading = true;
                        provider.incrementPage();
                        provider.getPastPaymentList(context);
                      }
                    }
                  },
                  child: Container(
                    color: Colors.transparent,
                    height: double.infinity,
                    width: double.infinity,
                    child: Icon(
                      FontAwesomeIcons.chevronRight,
                      color: provider.showAlertBox
                          ? Colors.grey.withOpacity(.2)
                          : black,
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
}
