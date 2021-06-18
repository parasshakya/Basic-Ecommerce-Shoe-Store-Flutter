import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:storeapp/screen/ProductPage.dart';
import 'package:storeapp/widgets/CustomActionBar.dart';
import 'package:storeapp/Services/FirebaseServices.dart';

class SavedTabScreen extends StatefulWidget {
  const SavedTabScreen({Key key}) : super(key: key);

  @override
  _SavedTabScreenState createState() => _SavedTabScreenState();
}

class _SavedTabScreenState extends State<SavedTabScreen> {
  FirebaseServices _firebaseServices = FirebaseServices();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          FutureBuilder<QuerySnapshot>(
              future: _firebaseServices.usersRef.doc(_firebaseServices.getUserID()).collection('Saved').get(),
              builder: (context, savedSnapshot){
                if(savedSnapshot.hasError){
                  return  Scaffold(
                    body: Center(
                      child: Text("Error: ${savedSnapshot.error}"),
                    ),
                  );
                }

                if(savedSnapshot.connectionState == ConnectionState.done){
                  return ListView(
                    padding: EdgeInsets.only(top: 110.0, bottom: 20.0),
                    children: savedSnapshot.data.docs.map((savedDocument) {
                      return GestureDetector(
                        onTap: (){
                          Navigator.push(context, MaterialPageRoute(
                            builder: (context) => ProductPage(productID: savedDocument.id,),
                          ));
                        },
                        child: FutureBuilder(
                          future: _firebaseServices.productsRef.doc(savedDocument.id).get(),
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
                                            "Size - ${savedDocument['size']}",
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
            hasBackArrow: false,
            title: "Saved Products",
          ),

        ],
      ),
    );
  }
}
