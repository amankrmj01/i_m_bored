import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:i_m_bored/infrastructure/navigation/bindings/controllers/main.controller.dart';

import 'controllers/home.controller.dart';
import 'home.desktop.screen.dart';
import 'home.mobile.screen.dart';
import 'home.tablet.screen.dart';

class AdaptScreen extends GetView<HomeController> {
  const AdaptScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final MainController mainController = Get.find<MainController>();
    final width = MediaQuery.of(context).size.width;
    if (width >= 1200) {
      mainController.isDesktop.value = true;
      return const HomeDesktopScreen();
    } else if (width >= 800) {
      mainController.isTablet.value = true;
      return const HomeTabletScreen();
    } else {
      mainController.isMobile.value = true;
      return const HomeMobileScreen();
    }
  }
}
