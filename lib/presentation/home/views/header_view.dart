import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:i_m_bored/presentation/home/controllers/home.controller.dart';

import '../../../widgets/text.with.border.dart';

class HeaderView extends GetView<HomeController> {
  const HeaderView({super.key});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.black.withAlpha((255 * 0.5).toInt()),
      child: Container(
        margin: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: Colors.blue.withAlpha((255 * 0.5).toInt()),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: Colors.white38),
        ),
        child: Center(
          child: TextWithBorder(
            text: 'i\'m bored',
            fontSize: 84,
            fontFamily: 'Fredoka',
            borderColor: Colors.black,
            strokeWidth: 10,
            fillColor: Colors.white,
          ),
        ),
      ),
    );
  }
}
