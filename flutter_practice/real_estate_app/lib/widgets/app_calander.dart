import 'package:cr_calendar/cr_calendar.dart';
import 'package:flutter/material.dart';

import '../ui.dart';

class AppCalander extends StatefulWidget {
  AppCalander({super.key});

  @override
  State<AppCalander> createState() => _AppCalanderState();
}

class _AppCalanderState extends State<AppCalander> {
  late CrCalendarController _controller;
  @override
  void initState() {
    _controller = CrCalendarController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 380,
      child: Container(
        padding: const EdgeInsets.all(5),
        decoration: BoxDecoration(
          color: Color.fromARGB(159, 255, 255, 255),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: AppColors.grey),
        ),
        child: Column(
          children: [
            AppText(text: "Month 2000", appTextVariant: AppTextVariant.medium),
            Expanded(
              child: CrCalendar(
                initialDate: DateTime.now(),
                controller: _controller,
                touchMode: TouchMode.rangeSelection,

                weekDaysBuilder: (WeekDay day) {
                  String label = '';
                  switch (day) {
                    case WeekDay.sunday:
                      label = 'SUN';
                      break;
                    case WeekDay.monday:
                      label = 'MON';
                      break;
                    case WeekDay.tuesday:
                      label = 'TUE';
                      break;
                    case WeekDay.wednesday:
                      label = 'WED';
                      break;
                    case WeekDay.thursday:
                      label = 'THU';
                      break;
                    case WeekDay.friday:
                      label = 'FRI';
                      break;
                    case WeekDay.saturday:
                      label = 'SAT';
                      break;
                  }

                  return Center(
                    child: Text(
                      label,
                      style: TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.bold,
                        color: Colors.black54,
                      ),
                    ),
                  );
                },
                dayItemBuilder: (DayItemProperties properties) {
                  int type = 0;

                  if (properties.isFirstInRange) {
                    type = 1;
                  } else if (properties.isLastInRange) {
                    type = 2;
                  } else if (properties.isInRange) {
                    type = 3;
                  }

                  switch (type) {
                    case 1:
                      return Container(
                        child: Stack(
                          children: [
                            Row(
                              children: [
                                SizedBox(width: 6),
                                Center(
                                  child: Container(
                                    height: 30,
                                    width: 38,
                                    decoration: BoxDecoration(
                                      color: AppColors.rangeDates,
                                      borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(30),
                                        bottomLeft: Radius.circular(30),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),

                            Center(
                              child: Container(
                                height: 25,
                                width: 25,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: AppColors.darkYellow,
                                ),
                              ),
                            ),
                            Center(
                              child: Text(properties.dayNumber.toString()),
                            ),
                          ],
                        ),
                      );
                    case 2:
                      return Stack(
                        children: [
                          Center(
                            child: Container(
                              height: 25,
                              width: 25,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: AppColors.darkYellow,
                              ),
                            ),
                          ),
                          Row(
                            children: [
                              Center(
                                child: Container(
                                  height: 30,
                                  width: 38,
                                  decoration: BoxDecoration(
                                    color: AppColors.rangeDates,
                                    borderRadius: BorderRadius.only(
                                      topRight: Radius.circular(30),
                                      bottomRight: Radius.circular(30),
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(width: 6),
                            ],
                          ),
                          Center(child: Text(properties.dayNumber.toString())),
                        ],
                      );
                    case 3:
                      return Container(
                        height: 30,
                        width: 10,
                        decoration: BoxDecoration(color: AppColors.rangeDates),
                        child: Center(
                          child: Text(properties.dayNumber.toString()),
                        ),
                      );

                    default:
                      return Container(
                        child: Center(
                          child: Text(
                            properties.dayNumber.toString(),
                            style: TextStyle(color: Colors.grey.shade400),
                          ),
                        ),
                      );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
