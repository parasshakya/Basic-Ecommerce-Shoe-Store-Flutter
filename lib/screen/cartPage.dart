import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:storeapp/Services/FirebaseServices.dart';
import 'package:storeapp/widgets/CustomActionBar.dart';

import '../constants.dart';
import 'ProductPage.dart';

class CartPage extends StatefulWidget {
  const CartPage({Key key}) : super(key: key);

  @override
  _CartPageState createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {

  FirebaseServices _firebaseServices = FirebaseServices();

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: Stack(
        children: [
          FutureBuilder<QuerySnapshot>(
              future: _firebaseServices.usersRef.doc(_firebaseServices.getUserID()).collection('Cart').get(),
              builder: (context, cartSnapshot){
                if(cartSnapshot.hasError){
                  return  Scaffold(
                    body: Center(
                      child: Text("Error: ${cartSnapshot.error}"),
                    ),
                  );
                }

                if(cartSnapshot.connectionState == ConnectionState.done){
                  return ListView(
                    padding: EdgeInsets.only(top: 110.0, bottom: 20.0),
                    children: cartSnapshot.data.docs.map((cartDocument) {
                      return GestureDetector(
                        onTap: (){
                          Navigator.push(context, MaterialPageRoute(
                            builder: (context) => ProductPage(productID: cartDocument.id,),
                          ));
                        },
                        child: FutureBuilder(
                          future: _firebaseServices.productsRef.doc(cartDocument.id).get(),
                          builder: (context, productIDSnapshot)
                          {
                            if(productIDSnapshot.hasError){
                              return Scaffold(
                                body: Center(
                                  child: Text('${productIDSnapshot.error}'),
                                ),
                              );
                            }
                            if(productIDSnapshot.connectionState == ConnectionState.done){
                              Map _productFieldMap = productIDSnapshot.data.data();
                              return Padding(
                                padding: const EdgeInsets.symmetric(
                                  vertical: 16.0,
                                  horizontal: 24.0,
                                ),
                                child: Row(
                                  mainAxisAlignment:
                                  MainAxisAlignment.start,
                                  children: [
                                    Container(
                                      width: 90,
                                      height: 90,
                                      child: ClipRRect(
                                        borderRadius:
                                        BorderRadius.circular(8.0),
                                        child: Image.network(
                                          "${_productFieldMap['images'][0]}",
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                    Container(
                                      padding: EdgeInsets.only(
                                        left: 16.0,
                                      ),
                                      child: Column(
                                        mainAxisAlignment:
                                        MainAxisAlignment.start,
                                        crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            "${_productFieldMap['name']}",
                                            style: TextStyle(
                                                fontSize: 18.0,
                                                color: Colors.black,
                                                fontWeight:
                                                FontWeight.w600),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets
                                                .symmetric(
                                              vertical: 4.0,
                                            ),
                                            child: Text(
                                              "\$${_productFieldMap['price']}",
                                              style: TextStyle(
                                                  fontSize: 16.0,
                                                  color: Theme.of(context)
                                                      .accentColor,
                                                  fontWeight:
                                                  FontWeight.w600),
                                            ),
                                          ),
                                          Text(
                                            "Size - ${cartDocument['size']}",
                                            style: TextStyle(
                                                fontSize: 16.0,
                                                color: Colors.black,
                                                fontWeight:
                                                FontWeight.w600),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              );

                            }
                            return Container(
                              child: Center(
                                child: CircularProgressIndicator(),
                              ),
                            );
                          },
                        ),
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
            hasBackArrow: true,
            title: 'Cart',
          ),
        ],
      ),

    );
  }
}
