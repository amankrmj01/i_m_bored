import 'package:get/get.dart';

import '../../../../presentation/anime/controllers/anime.controller.dart';

class AnimeControllerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AnimeController>(
      () => AnimeController(),
    );
  }
}
