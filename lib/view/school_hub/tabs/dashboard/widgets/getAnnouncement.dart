import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

import '../../../../../functions/download_file.dart';
import '../../../../../functions/globar_variables.dart';
import '../../../../../provider/appData.dart';
import '../../../../../provider/dashboard.dart';
import '../../notice/Notice_screen.dart';

class GetAnnouncement extends StatelessWidget {
  const GetAnnouncement({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
          color: black,
          width: double.infinity,
          child: Container(
            width: 60,
            child: Text('Announcements 🔔', style: headerTSWhite),
          ),
        ),
        const SizedBox(
          height: 7,
        ),
        Padding(
          padding: const EdgeInsets.only(right: 20.0, left: 10),
          child: Consumer<DashboardProvider>(
            builder: (context, provider, childProperty) {
              return provider.dataModelForNotice.isSuccess == true
                  ? Column(
                      children: [
                        ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: 3,
                          itemBuilder: (context, index) {
                            return GestureDetector(
                              onTap: () {
                                var qrCodeData;
                                String url =
                                    "https://school360.app/${qrCodeData.schoolId}/homes/download/notice~${provider.dataModelForNotice.data![index].url}";
                                Download download = Download();
                                download.downloadAndOpenFile(
                                    url,
                                    provider.dataModelForNotice.data![index].url
                                        .toString());
                              },
                              child: Column(
                                children: [
                                  Container(
                                    width: MediaQuery.of(context).size.width,
                                    padding:
                                        const EdgeInsets.symmetric(vertical: 3),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                          width: 30,
                                          alignment: Alignment.topCenter,
                                          child: Text(
                                            '${(index + 1).toString()}.',
                                            style: defaultTS,
                                          ),
                                        ),
                                        Expanded(
                                          child: Container(
                                              alignment: Alignment.topLeft,
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                      provider
                                                          .dataModelForNotice
                                                          .data![index]
                                                          .title
                                                          .toString(),
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      maxLines: 1,
                                                      style: defaultTS),
                                                  Text(
                                                    "Uploaded on: ${provider.dataModelForNotice.data![index].date.toString()}",
                                                    style: subtitleTS,
                                                  )
                                                ],
                                              )),
                                        ),
                                        Container(
                                          // width: 80,
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 10),
                                          child: Center(
                                            child: Icon(
                                              Icons.download,
                                              color: red,
                                              size: 17,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 4,
                                  ),
                                  Container(
                                    padding: EdgeInsets.only(left: 25),
                                    child: Container(
                                      height: 1,
                                      width: double.infinity,
                                      color: black,
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 4,
                                  ),
                                ],
                              ),
                            );
                          },
                        )
                      ],
                    )
                  : Center(
                    child: Text(
                      'No Announcement Data Found!',
                      style: defaultTS.copyWith(color: black.withOpacity(.5)),
                    ),
                  );
            },
          ),
        ),
        SizedBox(
          height: 5,
        ),
        Consumer<DashboardProvider>(
          builder: (context, provider, childproperty) {
            return provider.dataModelForNotice.isSuccess == true
                ? Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 2),
              alignment: Alignment.centerLeft,
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(
                  Radius.circular(8),
                ),
              ),
              child: Consumer<AppData>(
                builder: (context, provider, childProperty) {
                  return GestureDetector(
                    onTap: () {
                      Navigator.of(context).pushNamed(NoticeScreen.routeName);
                    },
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [Icon(FontAwesomeIcons.ellipsisH)],
                    ),
                  );
                },
              ),
              // padding:
              //     EdgeInsets.symmetric(horizontal: 10, vertical: 3),
            ): Container();
          }
        ),
        SizedBox(
          height: 5,
        ),
      ],
    );
  }
}
