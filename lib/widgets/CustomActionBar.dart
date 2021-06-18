import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:storeapp/Services/FirebaseServices.dart';
import 'package:storeapp/constants.dart';
import 'package:storeapp/screen/cartPage.dart';

class CustomActionBar extends StatelessWidget {

  final String title;
  final bool hasBackArrow;
  final bool hasTitle;
  final bool hasLinearGradientBackground;

  FirebaseServices _firebaseServices = FirebaseServices();

  CustomActionBar({this.title,this.hasBackArrow,this.hasTitle,this.hasLinearGradientBackground});

  @override
  Widget build(BuildContext context) {

    bool _hasBackArrow = hasBackArrow ?? false;
    bool _hasTitle = hasTitle ?? true;
    bool _hasLinearGradientBackGround = hasLinearGradientBackground ?? true;

    return Container(
      decoration: BoxDecoration(
        gradient: _hasLinearGradientBackGround ? LinearGradient(
          colors: [
            Colors.white,
            Colors.white.withOpacity(0.0),
          ],
              begin: Alignment(0,0.5),
              end: Alignment(0,0.7),
        ) : null
      ),
      padding: EdgeInsets.only(
        top: 56.0,
        right: 24.0,
        left: 24.0,
        bottom: 30.0,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          if(_hasBackArrow)
            GestureDetector(
              onTap: (){
                Navigator.pop(context);
              },
              child: Container(
                width: 42.0,
                height: 42.0,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8.0),
                  color: Colors.black,
                ),
                alignment: Alignment.center,
                child: Image(
                  image: AssetImage(
                    'assets/images/back_arrow.png'
                  ),
                  color: Colors.white,
                  width: 18.0,
                  height: 18.0,
                ),
              ),
            ),

          if(_hasTitle)
          Text(title ?? 'Action Bar',
          style: Constants.boldHeading,),
          GestureDetector(
            onTap: (){
              Navigator.push(context, MaterialPageRoute(
                builder: (context) => CartPage(),
              ));
            },
            child: Container(
              height: 42.0,
              width: 42.0,
              decoration: BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.circular(12.0),
              ),
              alignment: Alignment.center,
              child: StreamBuilder(
                stream: _firebaseServices.usersRef.doc(_firebaseServices.getUserID()).collection('Cart').snapshots(),
                builder: (context,snapshot){
                  int _totalItems;
                  if(snapshot.connectionState == ConnectionState.active)
                  _totalItems = snapshot.data.docs.length;
                  return Text('$_totalItems' ?? "0",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                      fontSize: 16.0,
                    ),);
                },
              )
            ),
          ),
        ],
      ),
    );
  }
}
