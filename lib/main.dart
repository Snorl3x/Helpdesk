import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:help_desk_app/services/ticket_services.dart';
import 'package:help_desk_app/pages/home_page.dart';
import 'package:help_desk_app/pages/create_ticket_page.dart';
import 'package:help_desk_app/pages/ticket_detail_page.dart';
import 'package:help_desk_app/pages/settings_page.dart';

void main() {
runApp(const HelpDeskApp());
}

class HelpDeskApp extends StatelessWidget {
const HelpDeskApp({Key? key}) : super(key: key);

@override
Widget build(BuildContext context) {
return MultiProvider(
providers: [
ChangeNotifierProvider(create: (_) => TicketService()),
],
child: MaterialApp(
debugShowCheckedModeBanner: false,
title: 'Help Desk',
theme: ThemeData(
primarySwatch: Colors.indigo,
appBarTheme: const AppBarTheme(
elevation: 0,
backgroundColor: Colors.white,
foregroundColor: Colors.black,
centerTitle: true,
),
),
initialRoute: '/',
routes: {
'/': (context) => const HomePage(),
'/create': (context) => const CreateTicketPage(),
'/settings': (context) => const SettingsPage(),
},
onGenerateRoute: (settings) {
if (settings.name == TicketDetailPage.routeName) {
final args = settings.arguments as Map<String, dynamic>;
final id = args['id'] as String;
return MaterialPageRoute(
builder: (_) => TicketDetailPage(ticketId: id),
);
}
return null;
},
),
);
}
}