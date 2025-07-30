import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../../infrastructure/navigation/bindings/controllers/main.controller.dart';

class HomeController extends GetxController {
  final isMobile = false.obs;
  final isTablet = false.obs;
  final isDesktop = false.obs;

  final MainController mainController = Get.find<MainController>();
  final ScrollController scrollController = ScrollController();

  Timer? _snapDebounce;

  @override
  void onInit() {
    super.onInit();
    isMobile.value = mainController.isMobile.value;
    isTablet.value = mainController.isTablet.value;
    isDesktop.value = mainController.isDesktop.value;
    ever(mainController.isMobile, (value) {
      isMobile.value = value;
    });
    ever(mainController.isTablet, (value) {
      isTablet.value = value;
    });
    ever(mainController.isDesktop, (value) {
      isDesktop.value = value;
    });
    scrollController.addListener(_onScroll);
  }

  void _onScroll() {
    _snapDebounce?.cancel();
    _snapDebounce = Timer(const Duration(milliseconds: 800), _snapToSection);
  }

  void _snapToSection() {
    final double screenHeight = Get.context?.size?.height ?? 0;
    if (screenHeight == 0) return;
    final double offset = scrollController.offset;
    final sectionKeys = [
      mainController.animeKey,
      mainController.activitiesKey,
      mainController.websitesKey,
      mainController.factsKey,
    ];

    int currentSection = 0;
    for (int i = 0; i < sectionKeys.length; i++) {
      final key = sectionKeys[i];
      final ctx = key.currentContext;
      if (ctx != null) {
        final box = ctx.findRenderObject() as RenderBox?;
        if (box != null) {
          final pos = box.localToGlobal(Offset.zero);
          final top = pos.dy;
          final bottom = top + box.size.height;
          // Section is fully visible if top >= 0 and bottom <= screenHeight
          if (top >= 0 && bottom <= screenHeight) {
            currentSection = i;
            break;
          }
        }
      }
    }

    // If no section is fully visible, find the closest one
    double minDist = double.infinity;
    for (int i = 0; i < sectionKeys.length; i++) {
      final key = sectionKeys[i];
      final ctx = key.currentContext;
      if (ctx != null) {
        final box = ctx.findRenderObject() as RenderBox?;
        if (box != null) {
          final pos = box.localToGlobal(Offset.zero);
          final dist = pos.dy.abs();
          if (dist < minDist) {
            minDist = dist;
            currentSection = i;
          }
        }
      }
    }

    final key = sectionKeys[currentSection];
    final ctx = key.currentContext;
    if (ctx == null) return;
    final box = ctx.findRenderObject() as RenderBox?;
    if (box == null) return;
    final pos = box.localToGlobal(Offset.zero);
    final top = pos.dy;
    final bottom = top + box.size.height;

    // If section is mostly visible, snap to it
    if (top > -screenHeight * 0.5 && bottom < screenHeight * 1.5) {
      scrollController.animateTo(
        scrollController.offset + top,
        duration: const Duration(milliseconds: 400),
        curve: Curves.ease,
      );
      return;
    }

    // If scrolled more than 50% in +ve direction, snap to next section
    if (top < -screenHeight * 0.5 && currentSection < sectionKeys.length - 1) {
      final nextKey = sectionKeys[currentSection + 1];
      final nextCtx = nextKey.currentContext;
      if (nextCtx != null) {
        final nextBox = nextCtx.findRenderObject() as RenderBox?;
        if (nextBox != null) {
          final nextPos = nextBox.localToGlobal(Offset.zero);
          scrollController.animateTo(
            scrollController.offset + nextPos.dy,
            duration: const Duration(milliseconds: 400),
            curve: Curves.ease,
          );
        }
      }
      return;
    }

    // If scrolled more than 50% in -ve direction, snap to previous section
    if (top > screenHeight * 0.5 && currentSection > 0) {
      final prevKey = sectionKeys[currentSection - 1];
      final prevCtx = prevKey.currentContext;
      if (prevCtx != null) {
        final prevBox = prevCtx.findRenderObject() as RenderBox?;
        if (prevBox != null) {
          final prevPos = prevBox.localToGlobal(Offset.zero);
          scrollController.animateTo(
            scrollController.offset + prevPos.dy,
            duration: const Duration(milliseconds: 400),
            curve: Curves.ease,
          );
        }
      }
      return;
    }
  }

  @override
  void onClose() {
    scrollController.removeListener(_onScroll);
    super.onClose();
    isMobile.close();
    isTablet.close();
    isDesktop.close();
  }
}
