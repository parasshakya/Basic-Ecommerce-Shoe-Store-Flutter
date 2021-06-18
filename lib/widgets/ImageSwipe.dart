import 'package:flutter/material.dart';

class ImageSwipe extends StatefulWidget {

  final List imageList;

  ImageSwipe({this.imageList});

  @override
  _ImageSwipeState createState() => _ImageSwipeState();
}

class _ImageSwipeState extends State<ImageSwipe> {

  int _selectedPage = 0;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(bottom: 20.0),
      height: 400.0,
      child: Stack(
        children: [
          PageView(
            onPageChanged: (num){
              setState(() {
                _selectedPage = num;
              });
            },
            children: [
              for(var i = 0; i < widget.imageList.length; i++)
              Image.network(
                widget.imageList[i],
                fit: BoxFit.cover,
              ),
            ],
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                for(var i = 0; i < widget.imageList.length; i++)
                  AnimatedContainer(
                    duration: Duration(
                      milliseconds: 200,
                    ),
                    curve: Curves.easeInOutCubic,
                    height: 10.0,
                    width: _selectedPage == i ? 35.0 : 12.0,
                    margin: EdgeInsets.symmetric(horizontal: 5.0, vertical: 15.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12.0),
                      color: Colors.white,
                    ),
                  )
              ],
            ),
          )
        ],
      ),
    );
  }
}
