import 'package:flutter/material.dart';
import 'package:flutter_derslerim/life_cycle/color_life_cycle/scaffold_color.dart';

class ColorViewPage extends StatefulWidget {
  const ColorViewPage({super.key});

  @override
  State<ColorViewPage> createState() => _ColorViewPageState();
}

class _ColorViewPageState extends State<ColorViewPage> {
  Color? secilenRenk;
  @override
  void initState() {
    secilenRenk = Colors.black;
    super.initState();
  }

  void changeColor(Color renk) {
    secilenRenk = renk;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () {
                secilenRenk = Colors.pink;
                setState(() {});
              },
              icon: const Icon(Icons.cancel))
        ],
      ),
      body: Column(
        children: [
          Expanded(
              child: ColorPage(
            renk: secilenRenk,
          )),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
          onTap: (value) {
            if (value == Renkler.red.index) {
              changeColor(Colors.red);
            } else if (value == Renkler.blue.index) {
              changeColor(Colors.blue);
            } else if (value == Renkler.yellow.index) {
              changeColor(Colors.yellow);
            }
          },
          items: [
            BottomNavigationBarItem(
                icon: colorContainer(Colors.red), label: "Red"),
            BottomNavigationBarItem(
                icon: colorContainer(Colors.blue), label: "Blue"),
            BottomNavigationBarItem(
                icon: colorContainer(Colors.yellow), label: "Yellow"),
          ]),
    );
  }

  Container colorContainer(Color renk) => Container(
        color: renk,
        width: 10,
        height: 10,
      );
}

enum Renkler { red, blue, yellow }
