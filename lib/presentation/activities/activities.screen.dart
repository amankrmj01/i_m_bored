import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:i_m_bored/constants/random.activities.dart';
import 'package:i_m_bored/presentation/activities/widget/character.falling.effect.dart';
import 'package:i_m_bored/presentation/activities/widget/wind.falling.effect.dart';
import 'package:i_m_bored/utils/k.showGeneralDialog.dart';

import 'controllers/activities.controller.dart';

class ActivitiesScreen extends GetView<ActivitiesController> {
  const ActivitiesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Material(
      // key: controller.mainController.activitiesKey,
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
              'Activities',
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
            //     'Current Activity: ',
            //     style: TextStyle(fontSize: 24, color: Colors.black87),
            //   );
            // }),
            const SizedBox(height: 20),
            ElevatedButton(
              // onPressed: controller.getRandomActivity,
              onPressed: () {
                showBlurredGeneralDialog(
                  context: context,
                  builder: (context) {
                    return CharacterFallingEffect();
                  },
                );
              },
              child: const Text('Get Random Activity'),
            ),
          ],
        ),
      ),
    );
  }
}
