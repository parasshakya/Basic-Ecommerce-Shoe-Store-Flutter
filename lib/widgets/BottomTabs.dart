import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BottomTab extends StatefulWidget {

  final int selectedTab;
   Function (int) tabPressed;
  BottomTab({this.selectedTab,this.tabPressed});

  @override
  _BottomTabState createState() => _BottomTabState();
}

class _BottomTabState extends State<BottomTab> {
  int _selectedTab ;

  @override
  Widget build(BuildContext context) {

    _selectedTab = widget.selectedTab ?? 0;

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            spreadRadius: 1.0,
            blurRadius: 30.0,
          )
        ],
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(12.0),
          topRight: Radius.circular(12.0),
        )
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          BottomTabButton(
            imagePath: 'assets/images/tab_home.png',
            isSelected: _selectedTab == 0 ? true : false,
            onPressed: () {
              setState(() {
                widget.tabPressed(0);
              });
            },
          ),
          BottomTabButton(
            imagePath: 'assets/images/tab_search.png',
            isSelected: _selectedTab == 1 ? true : false,
            onPressed: () {
              setState(() {
                widget.tabPressed(1);
              });
            },
          ),
          BottomTabButton(
            imagePath: 'assets/images/tab_saved.png',
            isSelected: _selectedTab == 2 ? true : false,
            onPressed: () {
              setState(() {
                widget.tabPressed(2);
              });
            },
          ),
          BottomTabButton(
            imagePath: 'assets/images/tab_logout.png',
            isSelected:  _selectedTab == 3 ? true : false,
            onPressed: () {
              FirebaseAuth.instance.signOut();
            },
          ),
        ],
      ),
    );
  }
}

class BottomTabButton extends StatelessWidget {

  final String imagePath;
  final bool isSelected;
  final Function onPressed;
  BottomTabButton({this.imagePath,this.isSelected, this.onPressed});

  @override
  Widget build(BuildContext context) {

    bool _isSelected = isSelected ?? false;

    return GestureDetector(
      onTap: onPressed,
      child: Container(
        decoration: BoxDecoration(
          border: Border(
            top: BorderSide(
              color: _isSelected ? Theme.of(context).accentColor : Colors.transparent,
              width: 2.0,
            )
          )
        ),
        padding: EdgeInsets.symmetric(vertical: 23.0, horizontal: 25.0),
        child: Image(
          image: AssetImage(
           imagePath ?? 'assets/images/tab_home.png'
          ),
          width: 24.0,
          height: 26.0,
          color: _isSelected ? Theme.of(context).accentColor : Colors.black,

        ),
      ),
    );
  }
}

