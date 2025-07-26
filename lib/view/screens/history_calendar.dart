import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:restaurant/controller/history_calendar_controller.dart';
import 'package:restaurant/utils/constants/app_color.dart';
import 'package:restaurant/utils/constants/app_routes.dart';
import 'package:restaurant/utils/functions/format_double.dart';
import 'package:restaurant/view/widgets/history%20calendar/history_calendar_item.dart';
import 'package:table_calendar/table_calendar.dart';

class HistoryCalendar extends StatelessWidget {
  const HistoryCalendar({super.key});

  @override
  Widget build(BuildContext context) {
    HistoryCalendarControllerImp controller = Get.put(
      HistoryCalendarControllerImp(),
    );
    return GetBuilder<HistoryCalendarControllerImp>(
      builder:
          (controller) => Scaffold(
            appBar: AppBar(title: const Text('Panier History Calendar')),
            body: Column(
              children: [
                TableCalendar(
                  locale: Get.locale?.languageCode ?? 'en',
                  weekendDays: const [DateTime.friday, DateTime.saturday],
                  focusedDay: controller.focusedDay,
                  firstDay: DateTime(2000),
                  lastDay: DateTime(2100),
                  selectedDayPredicate: (day) {
                    return isSameDay(controller.selectedDay, day);
                  },
                  onFormatChanged: (format) {
                    controller.calendarFormat = format;
                    controller.update();
                  },
                  calendarFormat: controller.calendarFormat,
                  calendarStyle: CalendarStyle(
                    markerDecoration: const BoxDecoration(
                      color: Color(0xFFF58700),
                      shape: BoxShape.circle,
                    ),
                    todayDecoration: BoxDecoration(
                      color: AppColor.primaryColorDark,
                      shape: BoxShape.circle,
                    ),
                    selectedDecoration: BoxDecoration(
                      color:
                          Get.isDarkMode
                              ? const Color(0xFF522D00)
                              : const Color.fromARGB(255, 213, 195, 168),
                      shape: BoxShape.circle,
                    ),
                  ),
                  onDaySelected: (selectedDay, focusedDay) {
                    controller.onDaySelected(selectedDay, focusedDay);
                  },
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 8.0,
                    horizontal: 10,
                  ),
                  child: SizedBox(
                    height: 50,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          children: [
                            Text(
                              "Sales",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            Text("${controller.selectedDayPaniers.length}"),
                          ],
                        ),
                        Column(
                          children: [
                            Text(
                              "Costs",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            Text(
                              formatDouble(controller.totalDayCost),
                              style: TextStyle(color: Colors.red),
                            ),
                          ],
                        ),
                        Column(
                          children: [
                            Text(
                              "Revenue",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            Text(
                              formatDouble(controller.totalDayRevenue),
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: AppColor.primaryColor,
                              ),
                            ),
                          ],
                        ),
                        Column(
                          children: [
                            Text(
                              "Benefit",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            Text(
                              formatDouble(controller.totalDayBenefit),
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.green,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: controller.selectedDayPaniers.length,
                    itemBuilder: (context, index) {
                      final panier = controller.selectedDayPaniers[index];
                      return InkWell(
                        onTap: () {
                          Get.toNamed(
                            AppRoutes.panierHistoryDetails,
                            arguments: {'panier': panier, "source": "calendar"},
                          );
                        },
                        child: HistoryCalendarItem(
                          createdAt: panier.createdAt,
                          itemTotalCost: panier.totalCost,
                          itemTotalPrice: panier.totalPrice,
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
    );
  }
}
