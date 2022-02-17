import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

import '../../../../../functions/globar_variables.dart';
import '../../../../../provider/dashboard.dart';
import '../../../../../provider/invoice.dart';
import '../../../payment_receipts.dart';

class GetPastPayment extends StatelessWidget {
  const GetPastPayment({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [

        Container(
          padding: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
          color: black,
          width: double.infinity,
          child: Container(
            width: 60,
            child: Text('Past payments 💳', style: headerTSWhite),
          ),
        ),
        const SizedBox(
          height: 7,
        ),
        Consumer<DashboardProvider>(
            builder: (context, provider, childProperty) {
              return provider.dataModelForPastPayment.data!.length == 0
                  ? Container(
                padding: EdgeInsets.only(top: 5),
                width: MediaQuery.of(context).size.width,
                alignment: Alignment.center,
                child: Text(
                  'No Payment Data Found!',
                  style: defaultTS,
                ),
              )
                  : Column(
                children: [
                  ListView.builder(
                    physics: BouncingScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: provider
                        .dataModelForPastPayment.data!.length >
                        3
                        ? 3
                        : provider.dataModelForPastPayment.data!.length,
                    itemBuilder: (context, index) {
                      return Container(
                        padding: EdgeInsets.symmetric(horizontal: 10),
                        child: GestureDetector(
                          onTap: () {
                            InvoiceProvider invoiceProvider =
                            Provider.of<InvoiceProvider>(context,
                                listen: false);
                            invoiceProvider.collection_id = provider
                                .dataModelForPastPayment.data![index].id
                                .toString();
                            invoiceProvider.getInvoice(context);
                          },
                          child: Card(
                            // color: white,
                            elevation: 4,
                            child: ListTile(
                              trailing: Icon(FontAwesomeIcons.download,
                                  color: red),
                              title: Column(
                                mainAxisAlignment:
                                MainAxisAlignment.start,
                                crossAxisAlignment:
                                CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Text(
                                        'Bill No: ',
                                        style: defaultTS.copyWith(
                                            fontWeight:
                                            FontWeight.w400),
                                      ),
                                      Text(
                                        '${provider.dataModelForPastPayment.data![index].receiptNo}',
                                        style: defaultHighLightedTS,
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                        'Total: ',
                                        style: defaultTS.copyWith(
                                            fontWeight:
                                            FontWeight.w400),
                                      ),
                                      Text(
                                        '${provider.dataModelForPastPayment.data![index].totalPaidAmount!.substring(0, provider.dataModelForPastPayment.data![index].totalPaidAmount!.length - 3)}Tk',
                                        style: defaultHighLightedTS,
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              subtitle: Column(
                                crossAxisAlignment:
                                CrossAxisAlignment.start,
                                children: [
                                  // Text(
                                  //     'Amount: ${provider.dataModelForPastPayment.data![index].totalPaidAmount}'),
                                  Text(
                                      'Payed on: ${provider.dataModelForPastPayment.data![index].date}',
                                      style: subtitleTS),
                                ],
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                  SizedBox(
                    height: 6,
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context)
                          .pushNamed(PaymentReceiptPage.routeName);
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 2),
                      decoration: BoxDecoration(
                        // color: Colors.
                          borderRadius: const BorderRadius.all(
                              Radius.circular(8))),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(FontAwesomeIcons.ellipsisH)
                        ],
                      ),
                      // padding:
                      //     EdgeInsets.symmetric(horizontal: 10, vertical: 3),
                    ),
                  )
                ],
              );
            }),
        const SizedBox(
          height: 10,
        )
      ],
    );
  }
}
