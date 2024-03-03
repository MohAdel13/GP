import 'package:flutter/material.dart';

class HistoryScreen extends StatefulWidget
{
  @override
  _HistoryScreen createState() => _HistoryScreen();
}

// Create the MyHomePage widget for the main screen
class _HistoryScreen extends State<HistoryScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children:[ ListTile(
          leading: Icon(Icons.man),
          title: Text("Test"),
          subtitle: Text("subtitle"),
          trailing: Icon(Icons.person),
          ),
        ]
      ),
    );
  }
}