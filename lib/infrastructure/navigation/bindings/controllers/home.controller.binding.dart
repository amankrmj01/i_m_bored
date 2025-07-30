import 'package:get/get.dart';

import '../../../../presentation/activities/controllers/activities.controller.dart';
import '../../../../presentation/anime/controllers/anime.controller.dart';
import '../../../../presentation/facts/controllers/facts.controller.dart';
import '../../../../presentation/home/controllers/home.controller.dart';
import '../../../../presentation/websites/controllers/websites.controller.dart';

class HomeControllerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HomeController>(() => HomeController());
    Get.lazyPut<AnimeController>(() => AnimeController());
    Get.lazyPut<ActivitiesController>(() => ActivitiesController());
    Get.lazyPut<WebsitesController>(() => WebsitesController());
    Get.lazyPut<FactsController>(() => FactsController());
  }
}
