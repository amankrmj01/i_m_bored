import 'package:get/get.dart';

import '../../../../presentation/websites/controllers/websites.controller.dart';

class WebsitesControllerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<WebsitesController>(
      () => WebsitesController(),
    );
  }
}
