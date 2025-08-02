import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:i_m_bored/constants/images.string.dart';
import 'package:i_m_bored/presentation/home/controllers/home.controller.dart';
import 'package:i_m_bored/presentation/home/views/header_view.dart';
import 'package:i_m_bored/presentation/screens.dart';

import '../../widgets/parallax.effect.container.dart';

final dx = 0.0.obs;
final dy = 0.0.obs;

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
                  key: controller.mainController.activitiesKey,
                  backgroundImage: demonSlayerImage,
                  parallaxFactor: 0.4,
                  controller: controller.scrollController,
                  child: ActivitiesScreen(),
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
          // PointerPassthroughCircle(dx: dx, dy: dy),
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

// Extracted widget for pointer-following circle that is pointer and scroll passthrough, but still tracks mouse location
// class PointerPassthroughCircle extends StatelessWidget {
//   final RxDouble dx;
//   final RxDouble dy;
//   final double size;
//
//   const PointerPassthroughCircle({
//     super.key,
//     required this.dx,
//     required this.dy,
//     this.size = 100,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     return Positioned.fill(
//       child: MouseRegion(
//         opaque: false,
//         onHover: (PointerHoverEvent event) {
//           dx.value = event.position.dx;
//           dy.value = event.position.dy;
//         },
//         child: IgnorePointer(
//           ignoring: true,
//           child: Obx(
//             () => Positioned(
//               left: dx.value - size / 2,
//               top: dy.value - size / 2,
//               child: Container(
//                 width: size,
//                 height: size,
//                 decoration: BoxDecoration(
//                   color: Colors.red.withAlpha(150),
//                   shape: BoxShape.circle,
//                 ),
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
