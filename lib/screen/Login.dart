import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:storeapp/constants.dart';
import 'package:storeapp/screen/Register.dart';
import 'package:storeapp/widgets/CustomInput.dart';
import 'package:storeapp/widgets/customButton.dart';

class LoginPage extends StatefulWidget {

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  Future <String> _signInAccount() async{
    try{
      await FirebaseAuth.instance.signInWithEmailAndPassword(email: _signInEmail, password: _signInPassword);
      return null;
    } on FirebaseAuthException catch(e){
      return e.message;
    }catch(e){
      return e.toString();
    }
  }

  void _submitForm() async {
    setState(() {
      _isLoading = true;
    });
    String _signInAccountFeedback = await _signInAccount();
    if(_signInAccountFeedback != null){
      _alertDialogBuilder(_signInAccountFeedback);
    }
    setState(() {
      _isLoading = false;
    });
  }
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

  String _signInEmail;
  String _signInPassword;
  bool _isLoading = false;
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
    return GestureDetector(
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
                  child: Text('Welcome,\n Login to continue',
                  textAlign: TextAlign.center,
                  style: Constants.boldHeading,),
                ),
                Column(
                  children: [
                    CustomInput(
                      hintText: "Email",
                      onChanged: (value)
                      {
                        _signInEmail = value;
                      },
                      onSubmitted: (value){
                        _passwordFocusNode.requestFocus();
                      },
                      textInputAction: TextInputAction.next,

                    ),
                    CustomInput(
                      hintText: "Password",
                      onChanged: (value){
                        _signInPassword = value;
                      },
                      focusNode: _passwordFocusNode,
                      isPasswordField: true,
                      onSubmitted: (value){
                        _submitForm();
                      },
                    ),
                    CustomButton(
                      text: 'Login',
                      isLoading: _isLoading,
                      onPressed: (){
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
                    text: "Create New Account",
                    outlineBtn: true,
                    onPressed: (){
                     Navigator.push(context,MaterialPageRoute(
                       builder: (context) => RegisterPage(),
                     ));
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
