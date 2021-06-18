import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:storeapp/Services/FirebaseServices.dart';
import 'package:storeapp/constants.dart';
import 'package:storeapp/screen/ProductPage.dart';
import 'package:storeapp/widgets/CustomActionBar.dart';
import 'package:storeapp/widgets/CustomProductCard.dart';

class HomeTabScreen extends StatelessWidget {

  FirebaseServices _firebaseServices = FirebaseServices();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          FutureBuilder<QuerySnapshot>(
            future: _firebaseServices.productsRef.get(),
              builder: (context, snapshot){
              if(snapshot.hasError){
               return  Scaffold(
                  body: Center(
                    child: Text("Error: ${snapshot.error}"),
                  ),
                );
              }

              if(snapshot.connectionState == ConnectionState.done){
                return ListView(
                  padding: EdgeInsets.only(top: 110.0, bottom: 20.0),
                  children: snapshot.data.docs.map((document) {
                    return CustomProductCard(
                      name: document['name'],
                      price: document['price'],
                      images: document['images'][0],
                      productID: document.id,
                    );
                  }  ).toList(),
                );
              }

              return Container(
                child: Center(
                  child: CircularProgressIndicator(),
                ),
              );
              }),
          CustomActionBar(
            hasBackArrow: false,
            title: "Home",
          ),

        ],
      ),
    );
  }
}
