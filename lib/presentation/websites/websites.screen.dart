import 'package:flutter/material.dart';

import 'package:get/get.dart';

import 'controllers/websites.controller.dart';

class WebsitesScreen extends GetView<WebsitesController> {
  const WebsitesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      borderRadius: BorderRadius.circular(20),
    );
  }
}
