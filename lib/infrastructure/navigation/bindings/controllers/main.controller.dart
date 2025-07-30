import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class MainController extends GetxController {
  final isMobile = false.obs;
  final isTablet = false.obs;
  final isDesktop = false.obs;

  final activitiesKey = GlobalKey();
  final animeKey = GlobalKey();
  final websitesKey = GlobalKey();
  final factsKey = GlobalKey();
}
