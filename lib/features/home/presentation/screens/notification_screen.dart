import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../core/extensions/context_ext.dart';
import '../../../flights/presentation/widgets/state_icons.dart';
import '../../data/entities/notification_data.dart';
import '../controllers/notification_controller.dart';
import '../widgets/notification_tile.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  @override
  Widget build(BuildContext context) {
    final notifications = context.watch<NotificationController>().notifications;

    return Scaffold(
      appBar: AppBar(
        title: InkWell(
          onDoubleTap: dummyNotification,
          child: const Text('Notifications'),
        ),
        actions: [
          IconButton(
            onPressed: () => context
                .read<NotificationController>() //
                .clearAll(),
            icon: const Icon(Icons.delete),
          )
        ],
      ),
      body: notifications.isEmpty
          ? const Center(
              heightFactor: 2,
              child: NotFoundIcon(
                message: 'No notifications to show',
              ),
            )
          : ListView.builder(
              itemCount: notifications.length,
              itemBuilder: (_, i) {
                final item = notifications[i];

                return Dismissible(
                  key: ValueKey(item.id),
                  background: Container(
                    color: context.backgroundColor,
                  ),
                  onDismissed: (direction) {
                    notifications.removeAt(i);
                    setState(() {});

                    ScaffoldMessenger.of(context).hideCurrentSnackBar();
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        backgroundColor: context.backgroundColor,
                        behavior: SnackBarBehavior.floating,
                        content: Text(
                          "Notification ${item.title}",
                          style: context.textTheme.bodyText2,
                        ),
                        action: SnackBarAction(
                          label: 'Undo',
                          textColor: context.primaryColor,
                          onPressed: () {
                            notifications.insert(i, item);
                            setState(() {});
                          },
                        ),
                      ),
                    );
                  },
                  child: NotificationTile(notification: item),
                );
              },
            ),
    );
  }

  void dummyNotification() {
    context
        .read<NotificationController>() //
        .scheduleNotification(
          NotificationData(
            id: NotificationData.uniqueID,
            title: 'Dummy Notification',
            subtitle: 'Nothing to show',
            description: 'This is how your notifications will look like',
            createdAt: DateTime.now(),
            scheduledFor: DateTime.now().add(const Duration(seconds: 1)),
          ),
        );
  }
}
