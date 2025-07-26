import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:restaurant/utils/constants/app_routes.dart';
import 'package:restaurant/view/screens/add_menu_item.dart';
import 'package:restaurant/view/screens/edit_menu_item.dart';
import 'package:restaurant/view/screens/history_calendar.dart';
import 'package:restaurant/view/screens/home.dart';
import 'package:restaurant/view/screens/menu.dart';
import 'package:restaurant/view/screens/panier.dart';
import 'package:restaurant/view/screens/panier_history.dart';
import 'package:restaurant/view/screens/panier_history_details.dart';

List<GetPage<dynamic>>? routes = [
  GetPage(name: AppRoutes.home, page: () => const Home()),
  GetPage(name: AppRoutes.panierHistory, page: () => const PanierHistory()),
  GetPage(name: AppRoutes.addMenuItem, page: () => const AddMenuItem()),
  GetPage(name: AppRoutes.editMenuItem, page: () => const EditMenuItem()),
  GetPage(name: AppRoutes.menu, page: () => const Menu()),
  GetPage(name: AppRoutes.panier, page: () => const Panier()),
  GetPage(name: AppRoutes.historyCalendar, page: () => const HistoryCalendar()),
  GetPage(
    name: AppRoutes.panierHistoryDetails,
    page: () => const PanierHistoryDetails(),
  ),
];
