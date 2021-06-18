import 'package:flutter/material.dart';

class ProductSize extends StatefulWidget {
 final List productSizes;
 final Function(int) onSelected;
 ProductSize({this.productSizes,this.onSelected});

  @override
  _ProductSizeState createState() => _ProductSizeState();
}

class _ProductSizeState extends State<ProductSize> {
  int _selected = 0;
  @override
  Widget build(BuildContext context) {
    return  Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        for(var i = 0; i < widget.productSizes.length; i++)
          GestureDetector(
            onTap: (){
              widget.onSelected(widget.productSizes[i]);
              setState(() {
                _selected = i;
              });
            },
            child: Container(
              width: 42.0,
              height: 42.0,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: _selected == i ? Theme.of(context).accentColor : Color(0xFFDCDCDC),
                borderRadius: BorderRadius.circular(12.0),
              ),
              margin: EdgeInsets.symmetric(horizontal: 4.0),
              child: Text( '${widget.productSizes[i]}',
                style: TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.w600,
                  color: _selected == i ? Colors.white : Colors.black,
                ),
              ),
            ),
          )
      ],
    );
  }
}
