import 'package:flutter/material.dart';

class PageControllerWidget extends StatefulWidget {
  const PageControllerWidget({super.key});

  @override
  State<PageControllerWidget> createState() => _PageControllerWidgetState();
}

class _PageControllerWidgetState extends State<PageControllerWidget> {
  int indeks = 0;
  PageController controller = PageController();
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("$indeks.Sayfadasınız."),
      ),
      body: PageView(
          onPageChanged: (value) {
            indeks = value;
            setState(() {});
          },
          controller: controller,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Center(
                  child: Text(
                    "Merhaba",
                    style: Theme.of(context).textTheme.headline2,
                  ),
                )
              ],
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Center(
                  child: Text(
                    "Nasılsınız",
                    style: Theme.of(context).textTheme.headline2,
                  ),
                )
              ],
            )
          ]),
      bottomNavigationBar: BottomNavigationBar(
          onTap: (value) {
            switch (value) {
              case 0:
                if (controller.page != 0) {
                  controller.previousPage(
                      duration: Duration(milliseconds: 100),
                      curve: Curves.easeIn);
                }
                break;
              case 1:
                if (controller.page != 1) {
                  controller.nextPage(
                      duration: Duration(milliseconds: 100),
                      curve: Curves.easeIn);
                }
                break;
            }
          },
          currentIndex: indeks,
          items: const [
            BottomNavigationBarItem(
                icon: Icon(Icons.dangerous), label: "Merhaba"),
            BottomNavigationBarItem(
                icon: Icon(Icons.check), label: "Nasılsınız"),
          ]),
    );
  }
}
