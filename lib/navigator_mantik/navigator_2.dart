import 'package:flutter/material.dart';

class NavigatorPageTwo extends StatefulWidget {
  const NavigatorPageTwo({super.key});

  @override
  State<NavigatorPageTwo> createState() => _NavigatorPageTwoState();
}

class _NavigatorPageTwoState extends State<NavigatorPageTwo> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Page Two"),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: ElevatedButton(
              child: const Text("Tap Me Back"),
              onPressed: () {
                Navigator.of(context).pop(true);
              },
            ),
          )
        ],
      ),
    );
  }
}
