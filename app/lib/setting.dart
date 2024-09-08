import 'package:flutter/material.dart';

class SettingsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Settings'),
      ),
      body: ListView(
        children: <Widget>[
          ListTile(
            title: Text('Theme'),
            trailing: Icon(Icons.arrow_forward_ios),
            onTap: () {
              // Navigate to theme settings
            },
          ),
          ListTile(
            title: Text('Change Location'),
            trailing: Icon(Icons.arrow_forward_ios),
            onTap: () {
              // Navigate to location settings
            },
          ),
          ListTile(
            title: Text('Logout'),
            trailing: Icon(Icons.exit_to_app),
            onTap: () {
              // Handle logout
            },
          ),
        ],
      ),
    );
  }
}