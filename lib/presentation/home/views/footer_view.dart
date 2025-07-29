import 'package:flutter/material.dart';

import 'package:get/get.dart';

class FooterView extends GetView {
  const FooterView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('FooterView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'FooterView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
