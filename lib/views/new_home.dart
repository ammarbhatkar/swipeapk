// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:swype/views/app_drawer.dart';

class NewHomeView extends StatefulWidget {
  const NewHomeView({super.key});

  @override
  State<NewHomeView> createState() => _NewHomeViewState();
}

class _NewHomeViewState extends State<NewHomeView> {
  @override
  Widget build(BuildContext context) {
    // ignore: prefer_const_constructors
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.background,
        // automaticallyImplyLeading: false,
        iconTheme: IconThemeData(color: Theme.of(context).colorScheme.outline),
        leadingWidth: 0,

        // elevation: 0,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 15),
            child: Icon(
              Icons.report,
              color: Theme.of(context).colorScheme.outline,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 8),
            child: Icon(
              Icons.notifications_active,
              color: Theme.of(context).colorScheme.outline,
            ),
          ),
        ],
      ),
      drawer: MyDrawer(),
      body: Padding(
        padding: const EdgeInsets.only(left: 8, right: 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(
                  "Tue, ",
                  style: GoogleFonts.openSans(
                    fontSize: 18,
                    color: Theme.of(context).colorScheme.scrim,
                  ),
                ),
                Text(
                  "7 Feb",
                  style: GoogleFonts.openSans(
                    fontSize: 18,
                    color: Theme.of(context).colorScheme.scrim,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
