import 'package:flutter/material.dart';

class TestingFunctions extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 4,
      itemBuilder: (context, index) {
        return ListTile(
          title: Text('Option ${index + 1}'),
          onTap: () {
            switch (index) {
              case 0:
                // Open page for option 1
                break;
              case 1:
                // Open page for option 2
                break;
              case 2:
                // Open page for option 3
                break;
              case 3:
                // Open page for option 4
                break;
            }
          },
        );
      },
    );
  }
}
