// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({super.key});

  // void logout() {
  //   //get auth service
  //   final _auth = AuthService();
  //   _auth.signout();
  // }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Colors.amber,
      // backgroundColor: Theme.of(context).colorScheme.background,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            children: [
              //logo
              DrawerHeader(
                child: Center(
                  child: Icon(
                    Icons.message,
                    size: 60,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
              ),

              //HOme list tile
              Padding(
                padding: EdgeInsets.only(
                  left: 25,
                ),
                child: ListTile(
                  title: Text("H o m e"),
                  leading: Icon(
                    Icons.home,
                  ),
                  onTap: () {
                    // POP THE DRAWER
                    Navigator.pop(context);
                  },
                ),
              ),
              //settings list tile
              Padding(
                padding: EdgeInsets.only(
                  left: 25,
                ),
                child: ListTile(
                  title: Text("S E T T I N G S"),
                  leading: Icon(
                    Icons.settings,
                  ),
                  onTap: () {
                    //pop the drawer
                    Navigator.pop(context);
                    //navigate to settings screen
                    // Navigator.push(
                    //     context,
                    //     MaterialPageRoute(
                    //         builder: (context) => SettingsScreen()));
                  },
                ),
              ),
            ],
          ),
          //logout list tile

          Padding(
            padding: EdgeInsets.only(
              left: 25,
              bottom: 25,
            ),
            child: ListTile(
              title: Text("L O G O U T"),
              leading: Icon(
                Icons.logout,
              ),
              // onTap: logout,
            ),
          )
        ],
      ),
    );
  }
}
