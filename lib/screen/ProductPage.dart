import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:storeapp/Services/FirebaseServices.dart';
import 'package:storeapp/constants.dart';
import 'package:storeapp/widgets/CustomActionBar.dart';
import 'package:storeapp/widgets/ImageSwipe.dart';
import 'package:storeapp/widgets/ProductSize.dart';

class ProductPage extends StatefulWidget {
  final String productID;
  ProductPage({this.productID});

  @override
  _ProductPageState createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {


  FirebaseServices _firebaseServices = FirebaseServices();

  Future _addToCart(){
    return _firebaseServices.usersRef.doc(_firebaseServices.getUserID()).collection('Cart').doc(widget.productID).set({
      'size' : _selectedProductSize,
    });
  }

  Future _addToSaved(){
    return _firebaseServices.usersRef.doc(_firebaseServices.getUserID()).collection('Saved').doc(widget.productID).set({
      'size': _selectedProductSize,
    });
  }
  int _selectedProductSize;

  final SnackBar _snackBar = SnackBar(content: Text('Product added to cart'),);


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          FutureBuilder(
            future: _firebaseServices.productsRef.doc(widget.productID).get(),
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return Scaffold(
                  body: Center(
                    child: Text("Error: ${snapshot.error}"),
                  ),
                );
              }
              if(snapshot.connectionState == ConnectionState.done){
                Map<String, dynamic> documentData = snapshot.data.data();
                List imageList = documentData['images'];
                List productSizes = documentData['size'];
                _selectedProductSize = productSizes[0];
                return ListView(
                  padding: EdgeInsets.zero,
                  children: [
                    ImageSwipe(
                      imageList: imageList,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal : 15.0, vertical: 5.0),
                      child: Text(documentData['name'] ?? 'Product Name',
                      style: Constants.boldHeading,),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 5.0),
                      child: Text('Rs. ${documentData['price'].toString()}' ?? 'Price',
                        style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 18.0,
                        color: Theme.of(context).accentColor,
                      ),),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 5.0),
                      child: Text(documentData['desc'] ?? 'Description',
                        style: TextStyle(
                            fontSize: 16.0,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 20.0),
                      child: Text('Select Size', style: Constants.regularDarkText,),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 15.0, top: 10.0),
                      child: ProductSize(
                        productSizes: productSizes,
                        onSelected: (value){
                          _selectedProductSize = value;
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 30.0),
                      child: Row(
                        children: [
                          GestureDetector(
                            onTap: () async{
                              await _addToSaved();
                              Scaffold.of(context).showSnackBar(SnackBar(content: Text('Product saved'),));
                              },
                            child: Container(
                              width: 40.0,
                              height: 40.0,
                              padding: EdgeInsets.all(5.0),
                              child: Image(
                                  image: AssetImage("assets/images/tab_saved.png"),
                              ),
                              decoration: BoxDecoration(
                                color: Color(0xFFDCDCDC),
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                            ),
                          ),
                          Expanded(
                            child: GestureDetector(
                              onTap: () async {
                             await   _addToCart();
                             Scaffold.of(context).showSnackBar(_snackBar);
                              },
                              child: Container(
                                alignment: Alignment.center,
                                padding: EdgeInsets.all(10.0),
                                margin: EdgeInsets.only(left: 10.0),
                                child: Text("Add to Cart", style: TextStyle(
                                  color: Colors.white,
                                ),),
                                decoration: BoxDecoration(
                                  color: Colors.black,
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    )

                  ],
                );
              }
              return Scaffold(
                body: Center(
                  child: CircularProgressIndicator(),
                ),
              );

            }  ),
          CustomActionBar(
            hasBackArrow: true,
            hasTitle: false,
            hasLinearGradientBackground: false,
          )
        ],
      ),
    );

}
}
