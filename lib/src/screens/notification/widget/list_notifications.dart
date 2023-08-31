import 'package:flutter/material.dart';
import 'package:planck/src/common/launch.dart';
import 'package:planck/src/models/notification_model.dart';
import 'package:planck/src/screens/notification/widget/info_notifications.dart';
import 'package:planck/src/widgets/avatar_image.dart';

class ListNotifications extends StatelessWidget {
  final List<NotificationModel> notifications;

  const ListNotifications(this.notifications, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: notifications.length,
      itemBuilder: (context, index) => _Notification(notifications[index]),
    );
  }
}

class _Notification extends StatelessWidget {
  final NotificationModel notification;
  final double height = 150;

  const _Notification(this.notification);

  @override
  Widget build(BuildContext context) {
    final card = SizedBox(
      height: height,
      child: Card(
        elevation: 2.0,
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
        child: Row(
          children: <Widget>[
            AvatarImage(image: notification.image),
            InfoNotifications(height: height, notification: notification),
          ],
        ),
      ),
    );
    return Stack(
      children: <Widget>[
        card,
        Positioned.fill(
          child: Material(
            color: Colors.transparent,
            child: InkWell(
                splashColor: Colors.blueAccent.withOpacity(0.6),
                onTap: () {
                  goToUrl(notification.url);
                }),
          ),
        ),
      ],
    );
  }
}
