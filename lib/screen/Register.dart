import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:storeapp/widgets/CustomInput.dart';
import 'package:storeapp/widgets/customButton.dart';

import '../constants.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key key}) : super(key: key);

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  
  //create a new user account
  Future <String> _createAccount() async{
    try{
      await FirebaseAuth.instance.createUserWithEmailAndPassword(email: _registerEmail, password: _registerPassword);
      return null;
    } on FirebaseAuthException catch(e){
      if(e.code == 'weak-password'){
        return 'The password provided is too weak';
      }else if(e.code == 'email-already-in-use'){
        return 'The account already exists for that email';
      }
      return e.message;
    }catch(e){
      return e.toString();
    }
  }
  
  void _submitForm() async {
    setState(() {
      _isloading = true;
    });
      String _createAccountFeedback = await _createAccount();
      if(_createAccountFeedback != null){
        _alertDialogBuilder(_createAccountFeedback);
      }
      setState(() {
        _isloading = false;
      });
      Navigator.pop(context);
  }3
  Future <void> _alertDialogBuilder(String error) async{
    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context){
        return AlertDialog(
          title: Text("Error"),
          content: Container(
            child: Text(error),
          ),
          actions: [
            TextButton(
              child: Text("Close"),
              onPressed: (){
                Navigator.pop(context);
              },
            )
          ],
        );
      }
    );
  }

  //for loading indicator inside button
  bool _isloading = false;

  //for input fields (Email and password)
  String _registerEmail = '';
  String _registerPassword = '';

  //Focus node for input fields
  FocusNode _passwordFocusNode;

  @override
  void initState() {
    _passwordFocusNode = FocusNode();
    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    _passwordFocusNode.dispose();
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return  GestureDetector(
      onTap: () {
        FocusScopeNode currentFocus = FocusScope.of(context);
        if (!currentFocus.hasPrimaryFocus) {
          currentFocus.unfocus();
        }
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: SafeArea(
          child: Container(
            width: double.infinity,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 24.0),
                  child: Text('Create A New Account',
                    textAlign: TextAlign.center,
                    style: Constants.boldHeading,),
                ),
                Column(
                  children: [
                    CustomInput(
                      hintText: "Email",
                      onChanged: (value)
                      {
                        _registerEmail = value;
                      },
                      onSubmitted: (value){
                        _passwordFocusNode.requestFocus();
                      },
                      textInputAction: TextInputAction.next,
                    ),
                    CustomInput(
                      hintText: "Password",
                      onChanged: (value){
                        _registerPassword = value;
                      },
                      focusNode: _passwordFocusNode,
                      isPasswordField: true,
                      onSubmitted: (value){
                        _submitForm();
                      },
                    ),
                    CustomButton(
                      isLoading: _isloading,
                      text: 'Create new account',
                      onPressed: ()  {
                           _submitForm();

                      },
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(
                      bottom: 16.0
                  ),
                  child: CustomButton(
                    text: "Back to Login",
                    outlineBtn: true,
                    onPressed: (){
                      print("Going back to login Page");
                      Navigator.pop(context);
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
