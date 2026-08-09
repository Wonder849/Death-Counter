import 'package:death_counter/styles/colors.dart';
import 'package:death_counter/styles/sizes.dart';
import 'package:death_counter/utils/buttons.dart';
import 'package:death_counter/utils/title_bar.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({super.key});

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {

  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  bool isSignUp = true;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.mainDarkColor,
      body: Column(
        children: [
          CustomTitleBar(),
          Expanded(
            child: Padding(
              padding: EdgeInsetsGeometry.only(left: 100, right: 100, bottom: 40),
              child: Center(
                child: Container(
                   decoration: BoxDecoration(
                    borderRadius: BorderRadiusGeometry.circular(10),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center ,
                    spacing: 30,
                    children: [
                      Text(
                        isSignUp? "Sign Up" : "Sign In",
                        style: TextStyle(
                          fontSize: MySizes.authPageTitleTextSz
                        ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        spacing: 5,
                        children: [
                          Text(
                            "Email",
                            style: TextStyle(
                              fontSize: MySizes.authPageSubTitleTextSz
                            ),
                          ),
                          TextField(
                            controller: _emailController,
                            cursorColor: MyColors.whiteColor,
                            decoration: InputDecoration(
                              isDense: true, 
                              contentPadding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 10.0),
                              filled: true,
                              fillColor : MyColors.modalTextFieldColor,
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.transparent),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.transparent),
                                borderRadius: BorderRadius.circular(10),
                              )
                            ),
                          ),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        spacing: 5,
                        children: [
                          Text(
                            "Password",
                            style: TextStyle(
                              fontSize: MySizes.authPageSubTitleTextSz
                            ),
                          ),
                          TextField(
                            controller: _passwordController,
                            cursorColor: MyColors.whiteColor,
                            decoration: InputDecoration(
                              isDense: true, 
                              contentPadding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 10.0),
                              filled: true,
                              fillColor : MyColors.modalTextFieldColor,
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.transparent),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.transparent),
                                borderRadius: BorderRadius.circular(10),
                              )
                            ),
                          ),
                        ],
                      ),
                      Column(
                        spacing: 10,
                        children: [
                          MyActionButton(
                            width: MediaQuery.widthOf(context), 
                            height: 60, 
                            text: isSignUp? "Sign Up" : "Sign In",  
                            fontSize: MySizes.authPageSubTitleTextSz,
                            onPressed: () {}
                          ),
                          RichText(
                        text: TextSpan(
                          style: TextStyle(
                            color: MyColors.whiteColor,
                            fontFamily: 'IBMPlexMono',
                            fontSize: MySizes.authPageSubTitleTextSz/1.4,
                          ),
                          children: [
                            TextSpan(text: isSignUp? "Already have an account? " : "Don't have an account? "),
                            TextSpan(
                              text: isSignUp? "Sign In" : "Sign Up",
                              style: TextStyle(color: MyColors.whiteColor, fontWeight: FontWeight.bold),
                              recognizer: TapGestureRecognizer()
                                ..onTap = () {
                                  setState(() {
                                    isSignUp = !isSignUp;
                                  });
                                },
                            ),
                          ]
                        ),
                      )
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            )
          )
        ],
      )
    );
  }
}