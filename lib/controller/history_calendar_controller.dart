import 'package:get/get.dart';
import 'package:restaurant/model/panier_model.dart';
import 'package:restaurant/utils/constants/status_request.dart';
import 'package:restaurant/utils/local%20db/db_helper.dart';
import 'package:table_calendar/table_calendar.dart';

abstract class HistoryCalendarController extends GetxController {
  getAllPaniers();
  calcTotals();
}

class HistoryCalendarControllerImp extends HistoryCalendarController {
  List<Panier> panierItems = [];
  List<Panier> selectedDayPaniers = [];
  StatusRequest statusRequest = StatusRequest.none;
  DateTime focusedDay = DateTime.now();
  DateTime selectedDay = DateTime.now();
  CalendarFormat calendarFormat = CalendarFormat.month;
  double totalDayCost = 0.0;
  double totalDayRevenue = 0.0;
  double totalDayBenefit = 0.0;

  @override
  void onInit() async {
    await getAllPaniers();
    filterPaniersByDay(selectedDay);
    super.onInit();
  }

  @override
  getAllPaniers() async {
    try {
      statusRequest = StatusRequest.loading;
      update();
      panierItems = await DbHelper.instance.getAllPaniers();
      filterPaniersByDay(selectedDay);
      if (panierItems.isEmpty) {
        statusRequest = StatusRequest.failure;
      } else {
        statusRequest = StatusRequest.success;
      }
    } catch (e) {
      statusRequest = StatusRequest.failure;
      print("Error fetching menu items: $e");
    }
    update();
  }

  void filterPaniersByDay(DateTime day) {
    selectedDayPaniers =
        panierItems.where((p) {
          final created = p.createdAt;
          return created.year == day.year &&
              created.month == day.month &&
              created.day == day.day;
        }).toList();
    calcTotals();
  }

  void onDaySelected(DateTime selected, DateTime focused) {
    selectedDay = selected;
    focusedDay = focused;
    filterPaniersByDay(selectedDay);
    update();
  }

  @override
  calcTotals() {
    totalDayRevenue = selectedDayPaniers.fold(
      0.0,
      (sum, panier) => sum + panier.totalPrice,
    );
    totalDayCost = selectedDayPaniers.fold(
      0.0,
      (sum, panier) => sum + panier.totalCost,
    );
    totalDayBenefit = totalDayRevenue - totalDayCost;
    update();
  }
}
