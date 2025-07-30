import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:i_m_bored/constants/images.string.dart';
import 'package:i_m_bored/presentation/home/controllers/home.controller.dart';
import 'package:i_m_bored/presentation/home/views/header_view.dart';
import 'package:i_m_bored/presentation/screens.dart';

import '../../widgets/parallax.effect.container.dart';

class HomeDesktopScreen extends GetView<HomeController> {
  const HomeDesktopScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          SingleChildScrollView(
            controller: controller.scrollController,
            child: Column(
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.4,
                  child: ParallaxEffect(
                    backgroundImage: erenYeagerImage,
                    controller: controller.scrollController,
                    parallaxFactor: 0.4,
                    child: HeaderView(),
                  ),
                ),

                ParallaxEffect(
                  backgroundImage: demonSlayerImage,
                  parallaxFactor: 0.4,
                  controller: controller.scrollController,
                  child: CustomContainerContent(title: 'Header'),
                ),
                ParallaxEffect(
                  key: controller.mainController.animeKey,
                  backgroundImage: demonSlayerImage,
                  parallaxFactor: 0.4,
                  controller: controller.scrollController,
                  child: AnimeScreen(),
                ),
                ParallaxEffect(
                  key: controller.mainController.activitiesKey,
                  backgroundImage: demonSlayerImage,
                  parallaxFactor: 0.4,
                  controller: controller.scrollController,
                  child: ActivitiesScreen(),
                ),
                ParallaxEffect(
                  key: controller.mainController.websitesKey,
                  backgroundImage: demonSlayerImage,
                  parallaxFactor: 0.4,
                  controller: controller.scrollController,
                  child: WebsitesScreen(),
                ),
                ParallaxEffect(
                  key: controller.mainController.factsKey,
                  backgroundImage: demonSlayerImage,
                  parallaxFactor: 0.4,
                  controller: controller.scrollController,
                  child: FactsScreen(),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class CustomContainerContent extends StatelessWidget {
  final String title;

  const CustomContainerContent({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    final double containerHeight = MediaQuery.of(context).size.height;
    return Container(
      height: containerHeight,
      color: Colors.black.withAlpha((0.5 * 255).toInt()),
      child: Center(
        child: Text(title, style: TextStyle(color: Colors.white, fontSize: 24)),
      ),
    );
  }
}
