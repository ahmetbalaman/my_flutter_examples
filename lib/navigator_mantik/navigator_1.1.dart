import 'package:flutter/material.dart';
import 'package:flutter_derslerim/navigator_mantik/navigator_2.dart';

class NavigatorPageOnePointOne extends StatefulWidget {
  const NavigatorPageOnePointOne({super.key});

  @override
  State<NavigatorPageOnePointOne> createState() =>
      _NavigatorPageOnePointOneState();
}

class _NavigatorPageOnePointOneState extends State<NavigatorPageOnePointOne>
    with NavigatorService {
  List<int> selectedItems = [];

  Color colorChoice = Colors.red;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("State One"),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemBuilder: (context, index) {
                return TextButton(
                  onPressed: () async {
                    final response = await advancedNavigator<bool>(
                        context, const NavigatorPageTwo());
                    if (response == true) {
                      selectedItems.add(index);
                      setState(() {});
                    } else {
                      selectedItems.remove(index);
                      setState(() {});
                    }
                  },
                  child: Placeholder(
                    strokeWidth: 20,
                    color: selectedItems.contains(index)
                        ? Colors.green
                        : Colors.red,
                    child: Text(selectedItems.contains(index)
                        ? "Yeyy Thanks"
                        : "Tap Me"),
                  ),
                );
              },
            ),
          ),
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
