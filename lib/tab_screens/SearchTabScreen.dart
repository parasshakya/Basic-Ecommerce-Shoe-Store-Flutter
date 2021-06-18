import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:storeapp/Services/FirebaseServices.dart';
import 'package:storeapp/constants.dart';
import 'package:storeapp/widgets/CustomInput.dart';
import 'package:storeapp/widgets/CustomProductCard.dart';

class SearchTabScreen extends StatefulWidget {

  @override
  _SearchTabScreenState createState() => _SearchTabScreenState();
}

class _SearchTabScreenState extends State<SearchTabScreen> {
  FirebaseServices _firebaseServices = FirebaseServices();

  String _searchString = '';

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Container(
          child: Stack(
            children: [
              if(_searchString != '')
              FutureBuilder<QuerySnapshot>(
                  future: _firebaseServices.productsRef.orderBy('searchString').startAt([_searchString]).endAt(['$_searchString\uf8ff']).get(),
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
                        padding: EdgeInsets.only(top: 100.0, bottom: 20.0),
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
              Padding(
                padding: const EdgeInsets.only(top: 10.0),
                child: CustomInput(
                  hintText: "Search here",
                  onSubmitted: (value){
                    setState(() {
                      _searchString = value.toLowerCase();
                    });
                  },
                ),
              ),
              if(_searchString == '')
              Padding(
                padding: const EdgeInsets.only(top: 10.0),
                child: Center(child: Text('Search Results', style: Constants.regularHeading,)),
              ),


            ],
          )
        ),
      ),
    );
  }
}
