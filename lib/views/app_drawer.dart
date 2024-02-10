// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:swype/pages/components/new_text.dart';

class MyDrawer extends StatelessWidget {
  final String email;
  const MyDrawer({super.key, required this.email});

  // void logout() {
  //   //get auth service
  //   final _auth = AuthService();
  //   _auth.signout();
  // }
  String getInitials(String email) {
    List<String> names = email.split("@")[0].split(".");
    String initials = "";
    int numWords = 2;

    if (names.length < 2) {
      numWords = names.length;
    }

    for (var i = 0; i < numWords; i++) {
      initials += '${names[i][0].toUpperCase()}';
    }
    return initials;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Drawer(
        backgroundColor: Color.fromARGB(255, 10, 50, 83),
        elevation: 0,

        // backgroundColor: Theme.of(context).colorScheme.background,
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.only(left: 15, right: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 80,
                ),
                Container(
                  height: 80,
                  width: 80,
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.white,
                      width: 2,
                    ),
                    shape: BoxShape.circle,
                  ),
                  child: Container(
                    height: 80,
                    width: 80,
                    decoration: BoxDecoration(
                      color: Color.fromARGB(255, 33, 96, 147),
                      shape: BoxShape.circle,
                    ),
                    child: Center(
                      child: AppUText(
                        text: getInitials(email),
                        color: Colors.white,
                        fontSize: 30,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                AppUText(
                  text: email,
                  color: Theme.of(context).colorScheme.tertiary,
                ),
                SizedBox(
                  height: 20,
                ),
                Divider(
                  color: Color.fromARGB(255, 33, 96, 147),
                  thickness: 1,
                  endIndent: 10,
                ),
                ListTile(
                  dense: true,
                  contentPadding: EdgeInsets.zero,
                  title: AppUText(
                    text: "My  Activities",
                    color: Theme.of(context).colorScheme.tertiary,
                  ),
                  leading: Icon(
                    Icons.task,
                    color: Color.fromARGB(255, 33, 96, 147),
                  ),
                ),
                Spacer(),
                InkWell(
                  onTap: () {
                    print("log out tapped");
                  },
                  child: ListTile(
                    dense: true,
                    contentPadding: EdgeInsets.zero,
                    title: AppUText(
                      text: "Logout",
                      color: Theme.of(context).colorScheme.tertiary,
                    ),
                    leading: Icon(
                      Icons.logout,
                      color: Color.fromARGB(255, 33, 96, 147),
                    ),
                    // onTap: logout,
                  ),
                ),
                SizedBox(
                  height: 20,
                )
              ],
            ),
          ),
        ),

        //logout list tile
      ),
    );
  }
}
