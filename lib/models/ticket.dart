import 'package:flutter/foundation.dart';

enum TicketPriority { low, medium, high }
enum TicketStatus { open, inProgress, resolved, closed }

class Ticket {
final String id;
String title;
String description;
DateTime createdAt;
TicketPriority priority;
TicketStatus status;
String? assignedTo;

Ticket({
required this.id,
required this.title,
required this.description,
required this.createdAt,
this.priority = TicketPriority.medium,
this.status = TicketStatus.open,
this.assignedTo,
});
}