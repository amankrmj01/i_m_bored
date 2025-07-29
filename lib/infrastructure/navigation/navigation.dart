import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../config.dart';
import '../../presentation/screens.dart';
import 'bindings/controllers/controllers_bindings.dart';
import 'routes.dart';

class EnvironmentsBadge extends StatelessWidget {
  final Widget child;

  const EnvironmentsBadge({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    var env = ConfigEnvironments.getEnvironments()['env'];
    return env != Environments.PRODUCTION
        ? Banner(
            location: BannerLocation.topStart,
            message: env!,
            color: env == Environments.QAS ? Colors.blue : Colors.purple,
            child: child,
          )
        : SizedBox(child: child);
  }
}

class Nav {
  static List<GetPage> routes = [
    GetPage(
      name: Routes.HOME,
      page: () => const AdaptScreen(),
      binding: HomeControllerBinding(),
    ),
    GetPage(
      name: Routes.ACTIVITIES,
      page: () => const ActivitiesScreen(),
      binding: ActivitiesControllerBinding(),
    ),
    GetPage(
      name: Routes.WEBSITES,
      page: () => const WebsitesScreen(),
      binding: WebsitesControllerBinding(),
    ),
    GetPage(
      name: Routes.FACTS,
      page: () => const FactsScreen(),
      binding: FactsControllerBinding(),
    ),
    GetPage(
      name: Routes.ANIME,
      page: () => const AnimeScreen(),
      binding: AnimeControllerBinding(),
    ),
  ];
}
