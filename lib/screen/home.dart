
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:storeapp/tab_screens/HomeTabScreen.dart';
import 'package:storeapp/tab_screens/SavedTabScreen.dart';
import 'package:storeapp/tab_screens/SearchTabScreen.dart';
import 'package:storeapp/widgets/BottomTabs.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
PageController _tabsPageController;
int _selectedTab = 0;

@override
  void initState() {
    // TODO: implement initState
    super.initState();
    _tabsPageController = PageController();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _tabsPageController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: PageView(
                controller: _tabsPageController,
                onPageChanged: (num)
                {
                  setState(() {
                    _selectedTab = num;
                  });
                },
                children: [
                   HomeTabScreen(),
                  SearchTabScreen(),
                  SavedTabScreen(),
                ],
              ),
            ),
            BottomTab(
              selectedTab: _selectedTab,
              tabPressed: (num){
               _tabsPageController.animateToPage(num, duration: Duration(milliseconds: 200), curve: Curves.easeInOutCubic);
              },

            ),

          ],
        ),
      ),
    );
  }
}
