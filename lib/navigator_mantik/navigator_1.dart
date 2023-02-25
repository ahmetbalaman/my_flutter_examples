import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_derslerim/navigator_mantik/navigator_1.1.dart';
import 'package:flutter_derslerim/navigator_mantik/navigator_2.dart';

class NavigatorPageOne extends StatefulWidget {
  const NavigatorPageOne({super.key});

  @override
  State<NavigatorPageOne> createState() => _NavigatorPageOneState();
}

class _NavigatorPageOneState extends State<NavigatorPageOne>
    with NavigatorService {
  Color colorChoice = Colors.red;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          TextButton(
              onPressed: () {
                normalNavigator(context, const NavigatorPageOnePointOne());
              },
              child: const FittedBox(
                  child: Text(
                "Better Version is here!",
                style: TextStyle(color: Colors.black),
              )))
        ],
        centerTitle: false,
        title: const Text("State One"),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemBuilder: (context, index) {
                return Placeholder(
                  color: colorChoice,
                );
              },
            ),
          ),
          ElevatedButton(
              onPressed: () async {
                //a normal navigator widget
                //normalNavigator(context, NavigatorPageOne());

                final response = await advancedNavigator<bool>(
                    context, const NavigatorPageTwo());
                if (response == true) {
                  log("you god damn right");
                  colorChoice = Colors.green;
                  setState(() {});
                } else {
                  log("You God Damn Wrong");
                  setState(() {
                    colorChoice = Colors.red;
                  });
                }
              },
              child: const Text("Tap me"))
        ],
      ),
    );
  }
}

mixin NavigatorService {
  void normalNavigator(BuildContext context, Widget widget) {
    Navigator.of(context).push(MaterialPageRoute(
      builder: (context) {
        return widget;
      },
    ));
  }

  Future<T?> advancedNavigator<T>(BuildContext context, Widget widget) {
    return Navigator.of(context).push<T>(MaterialPageRoute(
        builder: (context) {
          return widget;
        },
        fullscreenDialog: true,
        settings: const RouteSettings()));
  }
}
