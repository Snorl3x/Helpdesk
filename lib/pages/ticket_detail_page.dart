import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:help_desk_app/services/ticket_services.dart';
import 'package:help_desk_app/models/ticket.dart';
import 'package:intl/intl.dart';

class TicketDetailPage extends StatelessWidget {
static const routeName = '/ticket';
final String ticketId;
const TicketDetailPage({required this.ticketId, Key? key}) : super(key: key);

@override
Widget build(BuildContext context) {
  final svc = Provider.of<TicketService>(context);
  final ticket = svc.getTicketById(ticketId);

  if (ticket == null) {
    return Scaffold(
      appBar: AppBar(title: const Text('Ticket')),
      body: const Center(child: Text('Ticket not found')),
    );
  }

  return Scaffold(
    appBar: AppBar(
      title: const Text('Ticket Detail', style: TextStyle(color: Colors.black)),
      actions: [
        IconButton(
          icon: const Icon(Icons.delete),
          onPressed: () {
            svc.deleteTicket(ticket.id);
            Navigator.pop(context);
          },
        ),
      ],
    ),
    body: Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(ticket.title, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          Row(
            children: [
              Chip(label: Text(ticket.priority.name.toUpperCase())),
              const SizedBox(width: 8),
              Text(DateFormat.yMMMd().add_jm().format(ticket.createdAt)),
              if (ticket.assignedTo != null) ...[
                const SizedBox(width: 12),
                Text('Assigned to ${ticket.assignedTo!}'),
              ],
            ],
          ),
          const SizedBox(height: 12),
          Text(ticket.description),
          const Spacer(),
          Row(
            children: [
              ElevatedButton(
                onPressed: () {
                  svc.updateTicketStatus(ticket.id, TicketStatus.inProgress);
                  Navigator.pop(context);
                },
                child: const Text('Mark In Progress'),
              ),
              const SizedBox(width: 12),
              ElevatedButton(
                onPressed: () {
                  svc.updateTicketStatus(ticket.id, TicketStatus.resolved);
                  Navigator.pop(context);
                },
                child: const Text('Resolve'),
              ),
            ],
          ),
        ],
      ),
    ),
  );
}
}