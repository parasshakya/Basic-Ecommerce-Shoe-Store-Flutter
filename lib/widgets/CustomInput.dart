import 'package:flutter/material.dart';

import '../constants.dart';

class CustomInput extends StatelessWidget {

  final String hintText;
  final Function(String) onChanged;
  final Function(String) onSubmitted;
  final FocusNode focusNode;
  final TextInputAction textInputAction;
  final bool isPasswordField ;

  CustomInput({this.hintText,this.focusNode,this.onChanged,this.onSubmitted,this.textInputAction,this.isPasswordField});

  @override
  Widget build(BuildContext context) {
    bool _isPasswordField = isPasswordField ?? false;
    return Container(
      margin: EdgeInsets.symmetric(
        horizontal: 24.0,
        vertical: 12.0,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12.0),
        color: Color(0xFFF2F2F2),
      ),
      child: TextField(
        obscureText: _isPasswordField ? true : false,
        textInputAction: textInputAction,
        focusNode: focusNode,
        onChanged: onChanged,
        onSubmitted: onSubmitted,
        decoration: InputDecoration(
          border: InputBorder.none,
          hintText: hintText ?? 'TextField',
            contentPadding: EdgeInsets.symmetric(
                horizontal: 24.0,
        vertical: 18.0),
        ),
        style: Constants.regularDarkText,
      ),
    );
  }
}
