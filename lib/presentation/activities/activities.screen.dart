import 'package:flutter/material.dart';

import 'package:get/get.dart';

import 'controllers/activities.controller.dart';

class ActivitiesScreen extends GetView<ActivitiesController> {
  const ActivitiesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      borderRadius: BorderRadius.circular(20),
    );
  }
}
