import 'package:flutter/material.dart';

import 'package:get/get.dart';

import 'controllers/websites.controller.dart';

class WebsitesScreen extends GetView<WebsitesController> {
  const WebsitesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Material(
      // key: controller.mainController.websitesKey,
      color: Colors.transparent,
      child: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        margin: const EdgeInsets.all(24),
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: Colors.yellow.withAlpha((255 * 0.2).toInt()),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: Colors.white38),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              'Websites',
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
            //     'Current website: ',
            //     style: TextStyle(fontSize: 24, color: Colors.black87),
            //   );
            // }),
            const SizedBox(height: 20),
            ElevatedButton(
              // onPressed: controller.getRandomActivity,
              onPressed: () {},
              child: const Text('Get Random Websites'),
            ),
          ],
        ),
      ),
    );
  }
}
