import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../app/sizes.dart';
import '../../../../core/extensions/context_ext.dart';
import '../../../../core/extensions/text_ext.dart';
import '../../data/entities/notification_data.dart';

class NotificationTile extends StatelessWidget {
  const NotificationTile({super.key, required this.notification});

  final NotificationData notification;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: AppPaddings.smallXY,
      leading: Icon(
        Icons.info,
        color: context.contrastColor,
        size: 44.sp,
      ),
      horizontalTitleGap: 30.sp,
      title: Text(
        '${notification.title}\n${notification.subtitle}',
        style: context.textTheme.subtitle2!.medium,
      ),
      subtitle: Text(
        notification.description,
        style: context.textTheme.bodyText2!.light,
      ),
    );
  }
}
