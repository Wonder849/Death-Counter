import 'package:death_counter/services/auth_service.dart';
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

  final AuthService _authService = AuthService();

  final _userNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  bool isSignUp = true;

  bool isLoading = false;
  String? errorMessage;

  bool isHoveredText = false;

  String? checkTextControllersEmpty() {

    if(_userNameController.text.isEmpty) {
      return "Error: Enter UserName please";
    }
    else if (_emailController.text.isEmpty) {
      return "Error: Enter Email please";
    } else if (_passwordController.text.isEmpty) {
      return "Error: Enter password please";
    }
    
    return null;
  }

  Future<void> submitEmailAndPassword() async {

    if(checkTextControllersEmpty() != null ) {
      setState(() {
        errorMessage = checkTextControllersEmpty();
      });

      return;
    }

    setState(() {
      isLoading = true;
      errorMessage = null;
    });

    try {
      if(isSignUp) {
        await _authService.registerWithEmailAndPassword(
          email: _emailController.text.trim(),
          password: _passwordController.text.trim(), 
          displayName: _userNameController.text.trim()
        );
      } else {
        await _authService.signInWithEmailAndPassword(
          email: _emailController.text.trim(),
          password: _passwordController.text.trim(), 
        );
      }
    } catch (exc) {
      setState(() {
        errorMessage =  "Error: $exc";
      });
    } finally {
      if(mounted) {
        setState(() {
          isLoading = false;
        });
      }
    }
  }

  Future<void> submitGuest() async {
    setState(() {
      isLoading = true;
      errorMessage = null;
    });

    try {
      _authService.registerAsGuest();
    } catch (exc) {
      setState(() {
        errorMessage =  "Error: $exc";
      });
    } finally {
      if(mounted) {
        setState(() {
          isLoading = false;
        });
      }
    }
  }

  @override
  void dispose() {
    _userNameController.dispose();
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
              padding: EdgeInsetsGeometry.only(left: 100, right: 100, bottom: 30),
              child: Center(
                child: Container(
                   decoration: BoxDecoration(
                    borderRadius: BorderRadiusGeometry.circular(10),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center ,
                    spacing: 20,
                    children: [
                      Text(
                        isSignUp? "Sign Up" : "Sign In",
                        style: TextStyle(
                          fontSize: MySizes.authPageTitleTextSz
                        ),
                      ),
                      if(isSignUp) ...[
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          spacing: 5,
                          children: [
                            Text(
                              "UserName",
                              style: TextStyle(
                                fontSize: MySizes.authPageSubTitleTextSz
                              ),
                            ),
                            TextField(
                              controller: _userNameController,
                              cursorColor: MyColors.whiteColor,
                              decoration: InputDecoration(
                                isDense: true, 
                                contentPadding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 10.0),
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
                      ],
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
                              contentPadding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 10.0),
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
                              contentPadding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 10.0),
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
                      Text(
                        errorMessage ?? '',
                        style: TextStyle(
                          color: MyColors.errorColor,
                          fontSize: MySizes.authPageSubTitleTextSz / 1.4,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      Column(
                        spacing: 15,
                        children: [
                          MyActionButton(
                            width: MediaQuery.widthOf(context), 
                            height: 60, 
                            text: isLoading? "•••" : isSignUp? "Sign Up" : "Sign In",  
                            fontSize: MySizes.authPageSubTitleTextSz,
                            onPressed: isLoading? () {} : () { submitEmailAndPassword(); }
                          ),
                          RichText(
                            text: TextSpan(
                              style: TextStyle(
                                color: MyColors.whiteColor,
                                fontFamily: 'IBMPlexMono',
                                fontSize: MySizes.authPageSubTitleTextSz / 1.25,
                              ),
                              children: [
                                TextSpan(text: isSignUp? "Already have an account? " : "Don't have an account? "),
                                TextSpan(
                                  text: isSignUp? "Sign In" : "Sign Up",
                                  onEnter: (event) {
                                    setState(() {
                                      isHoveredText = true;
                                    });
                                  },
                                  onExit: (event) {
                                    setState(() {
                                      isHoveredText = false;
                                    });
                                  },
                                  style: TextStyle(
                                    color: isHoveredText
                                    ? const Color.fromARGB(210, 255, 255, 255)
                                    : const Color.fromARGB(255, 174, 174, 174), 
                                    fontWeight: FontWeight.bold,
                                    decoration: isHoveredText? TextDecoration.underline : TextDecoration.none
                                  ),
                                  recognizer: TapGestureRecognizer()
                                    ..onTap = () {
                                      setState(() {
                                        isSignUp = !isSignUp;
                                      });
                                    },
                                ),
                              ]
                            ),
                          ),
                          if(isSignUp) ...[
                            Text(
                              "OR",
                              style: TextStyle(
                                fontSize: MySizes.authPageTitleTextSz - 7
                              ),
                            ),
                            MyActionButton(
                              width: MediaQuery.widthOf(context), 
                              height: 60, 
                              text: isLoading? "•••" : "Continue as guest",  
                              fontSize: MySizes.authPageSubTitleTextSz,
                              onPressed: isLoading? () {} : () { submitGuest(); }
                            )
                          ]
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