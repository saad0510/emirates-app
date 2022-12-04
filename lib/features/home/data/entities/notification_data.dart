import 'package:awesome_notifications/awesome_notifications.dart';

import '../../../flights/data/entities/ticket.dart';

class NotificationData {
  static const basicChannel = 'basic_channel';

  final int id;
  final String title;
  final String subtitle;
  final String description;
  final DateTime createdAt;
  final DateTime scheduledFor;

  const NotificationData({
    required this.id,
    required this.title,
    required this.subtitle,
    required this.description,
    required this.createdAt,
    required this.scheduledFor,
  });

  static int get uniqueID => DateTime.now().microsecond;

  factory NotificationData.fromRecNotification(ReceivedNotification recv) {
    return NotificationData(
      id: recv.id!,
      title: recv.title!,
      subtitle: recv.summary!,
      description: recv.body!,
      createdAt: recv.createdDate!,
      scheduledFor: recv.displayedDate!,
    );
  }

  factory NotificationData.fromTicket(Ticket ticket) {
    return NotificationData(
      id: uniqueID,
      title: "Flight about to take off",
      subtitle: "It's about time!",
      description: "Your flight for seat ${ticket.seatId} is leaving in 3 hours!",
      createdAt: DateTime.now(),
      scheduledFor: ticket.flight.departureTime.subtract(
        const Duration(hours: 3),
      ),
    );
  }
}
