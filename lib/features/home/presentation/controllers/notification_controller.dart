import 'package:awesome_notifications/awesome_notifications.dart';

import '../../../../app/theme/colors.dart';
import '../../../../core/utils/base_change_notifier.dart';
import '../../data/entities/notification_data.dart';

class NotificationController extends BaseChangeNotifier<bool> {
  final AwesomeNotifications notify;
  List<NotificationData> notifications = [];

  NotificationController({required this.notify}) : super(false); // not permitted by default

  Future<void> requestPermission() async {
    state = await notify.isNotificationAllowed();
    if (state) return;
    state = await notify.requestPermissionToSendNotifications();
  }

  @pragma("vm:entry-point")
  Future<void> scheduleNotification(NotificationData data) async {
    if (!state) return;

    await notify.createNotification(
      schedule: NotificationCalendar.fromDate(date: data.scheduledFor),
      content: NotificationContent(
        badge: 1,
        id: data.id,
        title: data.title,
        summary: data.subtitle,
        body: data.description,
        backgroundColor: AppColors.primary,
        notificationLayout: NotificationLayout.BigText,
        channelKey: NotificationData.basicChannel,
        category: NotificationCategory.Reminder,
      ),
    );
    await notify.incrementGlobalBadgeCounter();
  }

  @pragma("vm:entry-point")
  Future<void> onNotificationDisplayed(ReceivedNotification recv) async {
    if (!state) return;
    final notification = NotificationData.fromRecNotification(recv);
    notifications.add(notification);
    notifyListeners();
  }

  void clearAll() {
    if (!state) return;
    notifications.clear();
    notifyListeners();
  }

  // ignore on createion
  @pragma("vm:entry-point")
  static Future<void> ignoreAction(ReceivedAction recv) async {}
}
