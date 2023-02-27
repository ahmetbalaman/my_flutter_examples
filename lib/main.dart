import 'package:flutter/material.dart';
import 'package:flutter_derslerim/navigator_mantik/navigator_1.dart';
import 'package:flutter_derslerim/page_controller/page_controller.dart';
import 'package:flutter_derslerim/starting_services/service_learn_get.dart';
import 'package:flutter_derslerim/starting_services/service_learn_post.dart';
import 'package:flutter_derslerim/tab_bars/tab_view.dart';

import 'life_cycle/color_life_cycle/color_life_cylc_choose.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: ServiceLearnView(),
    );
  }
}
