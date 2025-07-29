import 'package:get/get.dart';

import '../../../../presentation/facts/controllers/facts.controller.dart';

class FactsControllerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<FactsController>(
      () => FactsController(),
    );
  }
}
