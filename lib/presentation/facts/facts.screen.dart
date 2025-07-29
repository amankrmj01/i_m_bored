import 'package:flutter/material.dart';

import 'package:get/get.dart';

import 'controllers/facts.controller.dart';

class FactsScreen extends GetView<FactsController> {
  const FactsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      borderRadius: BorderRadius.circular(20),
    );
  }
}
