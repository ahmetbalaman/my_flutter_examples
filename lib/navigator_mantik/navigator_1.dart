import 'package:flutter/material.dart';
import 'package:flutter_derslerim/navigator_mantik/navigator_2.dart';

class NavigatorPageOne extends StatefulWidget {
  const NavigatorPageOne({super.key});

  @override
  State<NavigatorPageOne> createState() => _NavigatorPageOneState();
}

class _NavigatorPageOneState extends State<NavigatorPageOne>
    with NavigatorService {
  List<String> veriable = ["one", "two", "three"];
  Color colorChoice = Colors.red;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("State One"),
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

                final response =
                    await advancedNavigator<bool>(context, NavigatorPageTwo());
                if (response == true) {
                  print("you god damn right");
                  colorChoice = Colors.green;
                  setState(() {});
                } else {
                  print("You God Damn Wrong");
                  setState(() {
                    colorChoice = Colors.red;
                  });
                }
              },
              child: Text("Tap me"))
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
        settings: RouteSettings()));
  }
}
