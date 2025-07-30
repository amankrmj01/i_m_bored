import 'package:flutter/material.dart';

import 'package:get/get.dart';

import 'controllers/anime.controller.dart';

class AnimeScreen extends GetView<AnimeController> {
  const AnimeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Material(
      // key: controller.mainController.animeKey,
      color: Colors.transparent,
      child: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        margin: const EdgeInsets.all(24),
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: Colors.yellow.withAlpha((255 * 0.5).toInt()),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: Colors.white38),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              'Anime',
              style: TextStyle(
                fontSize: 36,
                fontFamily: 'Fredoka',
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),
            // Obx(() {
            //   return Text(
            //     // 'Current Activity: ${controller.currentActivity.value}',
            //     'Current Anime: ',
            //     style: TextStyle(fontSize: 24, color: Colors.black87),
            //   );
            // }),
            const SizedBox(height: 20),
            ElevatedButton(
              // onPressed: controller.getRandomActivity,
              onPressed: () {},
              child: const Text('Get Random Anime'),
            ),
          ],
        ),
      ),
    );
  }
}
