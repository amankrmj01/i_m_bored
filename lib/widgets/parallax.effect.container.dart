import 'package:flutter/material.dart';

class ParallaxEffect extends StatefulWidget {
  final Widget child;
  final String backgroundImage;
  final double parallaxFactor;
  final ScrollController controller;

  const ParallaxEffect({
    super.key,
    required this.child,
    required this.parallaxFactor,
    required this.backgroundImage,
    required this.controller,
  });

  @override
  State<ParallaxEffect> createState() => _ParallaxEffectState();
}

class _ParallaxEffectState extends State<ParallaxEffect> {
  final GlobalKey _containerKey = GlobalKey();
  double _parallax = 0;

  @override
  void initState() {
    super.initState();
    widget.controller.addListener(_onScroll);
    WidgetsBinding.instance.addPostFrameCallback((_) => _onScroll());
  }

  @override
  void didUpdateWidget(covariant ParallaxEffect oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.controller != widget.controller) {
      oldWidget.controller.removeListener(_onScroll);
      widget.controller.addListener(_onScroll);
      _onScroll();
    }
  }

  @override
  void dispose() {
    widget.controller.removeListener(_onScroll);
    super.dispose();
  }

  void _onScroll() {
    if (!mounted) return;
    final RenderBox? box =
        _containerKey.currentContext?.findRenderObject() as RenderBox?;
    if (box != null) {
      final position = box.localToGlobal(Offset.zero);
      final screenHeight = MediaQuery.of(context).size.height;
      final double containerTop = position.dy;
      double newParallax = 0;
      if (containerTop < screenHeight && containerTop + box.size.height > 0) {
        newParallax = (screenHeight - containerTop) * widget.parallaxFactor;
      }
      if (_parallax != newParallax) {
        setState(() {
          _parallax = newParallax;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final double containerHeight = MediaQuery.of(context).size.height;
    final double maxParallax = containerHeight * widget.parallaxFactor;
    final double imageHeight = containerHeight + (maxParallax.abs() * 2);
    return SizedBox(
      key: _containerKey,
      height: containerHeight,
      width: double.infinity,
      child: Stack(
        fit: StackFit.expand,
        children: [
          Positioned(
            top: -_parallax,
            left: 0,
            right: 0,
            child: Image.asset(
              widget.backgroundImage,
              fit: BoxFit.cover,
              height: imageHeight,
            ),
          ),
          widget.child,
        ],
      ),
    );
  }
}
