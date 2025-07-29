import 'package:get/get.dart';

import '../../../../presentation/activities/controllers/activities.controller.dart';

class ActivitiesControllerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ActivitiesController>(
      () => ActivitiesController(),
    );
  }
}
