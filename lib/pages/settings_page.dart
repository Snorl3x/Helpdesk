import 'package:flutter/material.dart';

class SettingsPage extends StatelessWidget {
const SettingsPage({Key? key}) : super(key: key);
@override
Widget build(BuildContext context) {
return Scaffold(
appBar: AppBar(title: const Text('Settings', style: TextStyle(color: Colors.black))),
body: ListView(
children: [
ListTile(
leading: const Icon(Icons.person),
title: const Text('Profile'),
subtitle: const Text('Admin'),
onTap: () {},
),
ListTile(
leading: const Icon(Icons.notifications),
title: const Text('Notifications'),
onTap: () {},
),
ListTile(
leading: const Icon(Icons.logout),
title: const Text('Logout'),
onTap: () {},
),
],
),
);
}
}
