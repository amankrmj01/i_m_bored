import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../../infrastructure/navigation/bindings/controllers/main.controller.dart';

class HomeController extends GetxController {
  final isMobile = false.obs;
  final isTablet = false.obs;
  final isDesktop = false.obs;

  final MainController mainController = Get.find<MainController>();
  final ScrollController scrollController = ScrollController();

  @override
  void onInit() {
    super.onInit();
    isMobile.value = mainController.isMobile.value;
    isTablet.value = mainController.isTablet.value;
    isDesktop.value = mainController.isDesktop.value;
    ever(mainController.isMobile, (value) {
      isMobile.value = value;
    });
    ever(mainController.isTablet, (value) {
      isTablet.value = value;
    });
    ever(mainController.isDesktop, (value) {
      isDesktop.value = value;
    });
  }

  @override
  void onClose() {
    super.onClose();
    isMobile.close();
    isTablet.close();
    isDesktop.close();
  }
}
