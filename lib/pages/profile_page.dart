import 'package:death_counter/services/auth_service.dart';
import 'package:death_counter/styles/colors.dart';
import 'package:death_counter/utils/buttons.dart';
import 'package:death_counter/utils/title_bar.dart';
import 'package:flutter/material.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {

  
  final AuthService _authService = AuthService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.mainDarkColor,      
      body: Column(
        children: [
          CustomTitleBar(),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Center(
                  child: Text("This page is currently in developing", style: TextStyle(fontSize: 40),),
                ),
                Center(
                  child: MyActionButton( text: "SIGN OUT",onPressed: () {
                    _authService.signOut();
                    Navigator.pop(context);
                  })
                ),
                Center(
                  child: MyIconButton(icon: Icons.chevron_left, onPressed: (){Navigator.pop(context);}),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}