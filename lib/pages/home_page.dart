import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:help_desk_app/services/ticket_services.dart';
import 'package:help_desk_app/models/ticket.dart';
import 'package:intl/intl.dart';
import 'package:help_desk_app/pages/ticket_detail_page.dart';

class HomePage extends StatefulWidget {
 const HomePage({Key? key}) : super(key: key);
 @override
 State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
 String _search = '';

 @override
 Widget build(BuildContext context) {
 final service = Provider.of<TicketService>(context);
 final tickets = service.tickets.where((t) {
 final q = _search.toLowerCase();
 return t.title.toLowerCase().contains(q) || t.description.toLowerCase().contains(q);
 }).toList();

 return Scaffold(
 appBar: AppBar(
 title: const Text('Help Desk', style: TextStyle(color: Colors.black)),
 actions: [
 IconButton(
 icon: const Icon(Icons.settings),
 onPressed: () => Navigator.pushNamed(context, '/settings'),
 ),
 ],
 ),
 floatingActionButton: FloatingActionButton(
 onPressed: () => Navigator.pushNamed(context, '/create'),
 child: const Icon(Icons.add),
 ),
 body: SafeArea(
 child: Column(
 children: [
 _buildSearchBar(),
 Expanded(
 child: tickets.isEmpty
 ? const Center(child: Text('No tickets — create one!'))
 : ListView.builder(
 padding: const EdgeInsets.all(12),
 itemCount: tickets.length,
 itemBuilder: (context, idx) {
 final t = tickets[idx];
 return _TicketCard(ticket: t);
 },
 ),
 ),
 ],
 ),
 ),
 );
 }

 Widget _buildSearchBar() {
 return Padding(
 padding: const EdgeInsets.fromLTRB(12, 12, 12, 6),
 child: TextField(
 decoration: InputDecoration(
 hintText: 'Search tickets',
 prefixIcon: const Icon(Icons.search),
 border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
 ),
 onChanged: (v) => setState(() => _search = v),
 ),
 );
 }
}

class _TicketCard extends StatelessWidget {
 final Ticket ticket;
 const _TicketCard({required this.ticket, Key? key}) : super(key: key);

 Color _priorityColor(TicketPriority p) {
 switch (p) {
 case TicketPriority.low:
 return Colors.green.shade700;
 case TicketPriority.medium:
 return Colors.orange.shade700;
 case TicketPriority.high:
 return Colors.red.shade700;
 }
 }

 @override
 Widget build(BuildContext context) {
 final created = DateFormat.yMMMd().add_jm().format(ticket.createdAt);
 return Card(
 margin: const EdgeInsets.symmetric(vertical: 8),
 child: ListTile(
 onTap: () {
 Navigator.pushNamed(
 context,
 TicketDetailPage.routeName,
 arguments: {'id': ticket.id},
 );
 },
 title: Text(ticket.title, style: const TextStyle(fontWeight: FontWeight.w600)),
 subtitle: Text(ticket.description, maxLines: 2, overflow: TextOverflow.ellipsis),
 trailing: Column(
 crossAxisAlignment: CrossAxisAlignment.end,
 mainAxisAlignment: MainAxisAlignment.center,
 children: [
 Text(created, style: const TextStyle(fontSize: 11)),
 const SizedBox(height: 6),
 Container(
 padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
 decoration: BoxDecoration(
 color: _priorityColor(ticket.priority).withOpacity(0.12),
 borderRadius: BorderRadius.circular(12),
 ),
 child: Text(
 ticket.priority.name.toUpperCase(),
 style: TextStyle(
 fontSize: 11,
 color: _priorityColor(ticket.priority),
 fontWeight: FontWeight.bold,
 ),
 ),
 )
 ],
 ),
 ),
 );
 }
}