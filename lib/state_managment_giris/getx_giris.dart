import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:get/get.dart';

class GetxGiris extends StatelessWidget {
  GetxGiris({super.key});
  var count = 0.obs;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          ElevatedButton(
              onPressed: () {
                Get.to(YeniSayfa());
              },
              child: Text("Git")),
          Obx(() => Text(count.toString())),
          ElevatedButton(onPressed: () => count++, child: Text("Arttır")),
          Text("Merhaba".tr),
        ],
      ),
    );
  }
}

class YeniSayfa extends StatelessWidget {
  const YeniSayfa({super.key});

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
