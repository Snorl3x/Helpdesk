import 'package:flutter/foundation.dart';
import 'package:uuid/uuid.dart';
import 'package:help_desk_app/models/ticket.dart';

class TicketService with ChangeNotifier {
final _uuid = const Uuid();

final List<Ticket> _tickets = [
Ticket(
id: Uuid().v4(),
title: 'Cannot connect to Wi-Fi',
description: 'Office Wi-Fi not connecting on the ground floor. Error: auth failed.',
createdAt: DateTime.now().subtract(const Duration(hours: 5)),
priority: TicketPriority.high,
),
Ticket(
id: Uuid().v4(),
title: 'Printer paper jam',
description: 'Paper jam at printer near reception. Need assistance.',
createdAt: DateTime.now().subtract(const Duration(days: 1)),
priority: TicketPriority.low,
),
];

List<Ticket> get tickets => List.unmodifiable(_tickets);

Ticket? getTicketById(String id) =>
_tickets.firstWhere((t) => t.id == id, orElse: () => throw Exception('Not found'));

void createTicket({
required String title,
required String description,
TicketPriority priority = TicketPriority.medium,
}) {
final t = Ticket(
id: _uuid.v4(),
title: title,
description: description,
createdAt: DateTime.now(),
priority: priority,
);
_tickets.insert(0, t);
notifyListeners();
}

void updateTicketStatus(String id, TicketStatus status) {
final t = _tickets.indexWhere((x) => x.id == id);
if (t >= 0) {
_tickets[t].status = status;
notifyListeners();
}
}

void assignTo(String id, String assignee) {
final t = _tickets.indexWhere((x) => x.id == id);
if (t >= 0) {
_tickets[t].assignedTo = assignee;
notifyListeners();
}
}

void deleteTicket(String id) {
_tickets.removeWhere((x) => x.id == id);
notifyListeners();
}
}