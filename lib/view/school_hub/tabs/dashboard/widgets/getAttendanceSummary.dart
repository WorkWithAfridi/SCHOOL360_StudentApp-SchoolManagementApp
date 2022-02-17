import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:school_360_app/view/school_hub/tabs/dashboard/widgets/animation/coverLottieAnimation.dart';

import '../../../../../functions/globar_variables.dart';
import '../../../../../provider/dashboard.dart';
import '../../notebook/widgets/animation/coverLottieAnimation.dart';

class GetAttendanceSummary extends StatelessWidget {
  const GetAttendanceSummary({Key? key}) : super(key: key);

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
            color: black,
            child: Text('Attendance Summary 👋', style: headerTSWhite),
          ),
        ),
        const SizedBox(
          height: 8,
        ),
        SizedBox(
          height: MediaQuery.of(context).size.width * .6,
          child: Stack(
            children: [
              const Positioned(
                left: 0,
                top: 0,
                child: CoverLottieAnimationForDashBoard(),
              ),
              Positioned(
                right: 0,
                top: 0,
                child: Container(
                  // color: Colors.pink,
                  width: MediaQuery.of(context).size.width * .45,
                  padding: const EdgeInsets.only(right: 15),
                  child: Stack(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 7),
                        child: Card(
                          elevation: 4,
                          child: Consumer<DashboardProvider>(
                              builder: (context, provider, childProperty) {
                            return Container(
                              // padding: EdgeInsets.symmetric(horizontal: 15),
                              height: MediaQuery.of(context).size.width * .54,
                              decoration: BoxDecoration(
                                // color: Theme.of(context).colorScheme.background,
                                color: Colors.white.withOpacity(.5),
                                border: Border.all(
                                    color: Theme.of(context)
                                        .colorScheme
                                        .primary
                                        .withOpacity(.5),
                                    width: 4),
                                borderRadius: BorderRadius.circular(4),
                              ),
                              alignment: Alignment.center,
                              child: Container(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 5),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    const SizedBox(
                                      height: 13,
                                    ),
                                    RichText(
                                      textAlign: TextAlign.start,
                                      text: TextSpan(
                                        style:
                                            DefaultTextStyle.of(context).style,
                                        children: <TextSpan>[
                                          TextSpan(
                                            text: 'Total Classes: ',
                                            style: defaultTS,
                                          ),
                                          TextSpan(
                                              text: provider
                                                  .dataModelForDashboardAttendance
                                                  .data!
                                                  .totalWorkingDays
                                                  .toString(),
                                              style: defaultHighLightedTS),
                                        ],
                                      ),
                                    ),
                                    RichText(
                                      textAlign: TextAlign.start,
                                      text: TextSpan(
                                        style:
                                            DefaultTextStyle.of(context).style,
                                        children: <TextSpan>[
                                          TextSpan(
                                              text: 'Presents: ',
                                              style: defaultTS),
                                          TextSpan(
                                              text: provider
                                                  .dataModelForDashboardAttendance
                                                  .data!
                                                  .totalPresentDays
                                                  .toString(),
                                              style: defaultHighLightedTS),
                                        ],
                                      ),
                                    ),
                                    RichText(
                                      textAlign: TextAlign.start,
                                      text: TextSpan(
                                        style:
                                            DefaultTextStyle.of(context).style,
                                        children: <TextSpan>[
                                          TextSpan(
                                              text: 'Absents: ',
                                              style: defaultTS),
                                          TextSpan(
                                              text: provider
                                                  .dataModelForDashboardAttendance
                                                  .data!
                                                  .totalAbsentDays
                                                  .toString(),
                                              style: defaultHighLightedTS),
                                        ],
                                      ),
                                    ),
                                    RichText(
                                      textAlign: TextAlign.start,
                                      text: TextSpan(
                                        style:
                                            DefaultTextStyle.of(context).style,
                                        children: <TextSpan>[
                                          TextSpan(
                                              text: 'On Leave: ',
                                              style: defaultTS),
                                          TextSpan(
                                              text: provider
                                                  .dataModelForDashboardAttendance
                                                  .data!
                                                  .totalLeaveDays
                                                  .toString(),
                                              style: defaultHighLightedTS),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          }),
                        ),
                      ),
                      Positioned.fill(
                        child: Align(
                          alignment: Alignment.topCenter,
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                vertical: 3, horizontal: 10),
                            decoration: BoxDecoration(
                              color: const Color(0xff212121),
                              borderRadius: BorderRadius.circular(4),
                            ),
                            child: Text(
                              'Report',
                              style: defaultHighLightedTS,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ],
    );
  }
}
