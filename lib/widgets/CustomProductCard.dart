
import 'package:flutter/material.dart';
import 'package:storeapp/screen/ProductPage.dart';

import '../constants.dart';
class CustomProductCard extends StatelessWidget {

  final String name;
  final int price;
  final String images;
  final String productID;

  CustomProductCard({this.name,this.images,this.price,this.productID});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        Navigator.push(context, MaterialPageRoute(
          builder: (context) => ProductPage(productID: productID,),
        ));
      },
      child: Container(
        height: 350,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20.0),
        ),
        margin: EdgeInsets.only(top: 15.0, right: 24.0, left: 24.0, bottom: 15.0),
        child: Stack(
          children: [
            Container(
              height: 350.0,
              width: 350.0,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12.0),
                child: Image.network(images,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
                child: Row(
                  mainAxisAlignment : MainAxisAlignment.spaceBetween,
                  children: [
                    Text(name ?? 'Product Name', style: Constants.regularHeading,),
                    Text('Rs. ${price.toString()}' ?? 'Price', style: TextStyle(
                      color: Theme.of(context).accentColor,
                      fontSize: 18.0,
                      fontWeight: FontWeight.w600,
                    ),),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
