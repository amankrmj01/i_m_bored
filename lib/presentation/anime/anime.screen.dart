import 'package:flutter/material.dart';

import 'package:get/get.dart';

import 'controllers/anime.controller.dart';

class AnimeScreen extends GetView<AnimeController> {
  const AnimeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.black.withAlpha((255 * 0.5).toInt()),
      // borderRadius: BorderRadius.circular(20),
      child: Container(
        margin: EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: Colors.black.withAlpha((255 * 0.5).toInt()),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: Colors.white38),
        ),
      ),
    );
  }
}
