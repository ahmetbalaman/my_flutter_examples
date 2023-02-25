import 'package:flutter/material.dart';

class TabBarViewWidget extends StatefulWidget {
  const TabBarViewWidget({super.key});

  @override
  State<TabBarViewWidget> createState() => _TabBarViewWidgetState();
}

class _TabBarViewWidgetState extends State<TabBarViewWidget>
    with TickerProviderStateMixin {
  late final TabController _tabControl;
  @override
  void initState() {
    super.initState();
    _tabControl = TabController(length: _MyTabViews.values.length, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: _MyTabViews.values.length,
      child: Scaffold(
        body: myTabView(),
        bottomNavigationBar: myBottomBar(),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            _tabControl.animateTo(1);
          },
          child: const Icon(Icons.real_estate_agent),
        ),
      ),
    );
  }

  BottomAppBar myBottomBar() {
    return BottomAppBar(
      notchMargin: 10,
      shape: const CircularNotchedRectangle(),
      child: TabBar(
          controller: _tabControl,
          labelColor: Colors.red,
          tabs: _MyTabViews.values
              .map((e) => Tab(
                    text: e.name.toUpperCase(),
                  ))
              .toList()),
    );
  }

  TabBarView myTabView() {
    return TabBarView(
        controller: _tabControl,
        children: _MyTabViews.values
            .map((e) => Center(child: Text(e.name.toUpperCase())))
            .toList());
  }
}

enum _MyTabViews { home, first, second, third }
