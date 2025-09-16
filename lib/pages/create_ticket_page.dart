import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:help_desk_app/services/ticket_services.dart';
import 'package:help_desk_app/models/ticket.dart';

class CreateTicketPage extends StatefulWidget {
const CreateTicketPage({Key? key}) : super(key: key);

@override
State<CreateTicketPage> createState() => _CreateTicketPageState();
}

class _CreateTicketPageState extends State<CreateTicketPage> {
final _formKey = GlobalKey<FormState>();
String _title = '';
String _desc = '';
TicketPriority _priority = TicketPriority.medium;

@override
Widget build(BuildContext context) {
final svc = Provider.of<TicketService>(context, listen: false);
return Scaffold(
appBar: AppBar(
title: const Text('Create Ticket', style: TextStyle(color: Colors.black)),
),
body: Padding(
padding: const EdgeInsets.all(16.0),
child: Form(
key: _formKey,
child: Column(
children: [
TextFormField(
decoration: const InputDecoration(labelText: 'Title'),
onSaved: (v) => _title = v?.trim() ?? '',
validator: (v) => (v == null || v.trim().isEmpty) ? 'Enter a title' : null,
),
const SizedBox(height: 12),
TextFormField(
decoration: const InputDecoration(labelText: 'Description', alignLabelWithHint: true),
onSaved: (v) => _desc = v?.trim() ?? '',
minLines: 3,
maxLines: 6,
validator: (v) => (v == null || v.trim().isEmpty) ? 'Enter a description' : null,
),
const SizedBox(height: 12),
DropdownButtonFormField<TicketPriority>(
value: _priority,
decoration: const InputDecoration(labelText: 'Priority'),
items: TicketPriority.values
.map((p) => DropdownMenuItem(value: p, child: Text(p.name.toUpperCase())))
.toList(),
onChanged: (v) => setState(() => _priority = v ?? TicketPriority.medium),
),
const Spacer(),
Row(
children: [
Expanded(
child: ElevatedButton(
child: const Padding(
padding: EdgeInsets.symmetric(vertical: 12),
child: Text('Create Ticket'),
),
onPressed: () {
if (_formKey.currentState?.validate() ?? false) {
_formKey.currentState?.save();
svc.createTicket(title: _title, description: _desc, priority: _priority);
Navigator.pop(context);
}
},
),
)
],
)
],
),
),
),
);
}
}