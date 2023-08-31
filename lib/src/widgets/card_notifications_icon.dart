import 'package:badges/badges.dart' as badges;
import 'package:flutter/material.dart';
import 'package:planck/src/widgets/icon_status_order.dart';

class CardNotificationsIcon extends StatelessWidget {
  const CardNotificationsIcon({
    Key? key,
    required this.notifications,
    required this.status,
  }) : super(key: key);

  final int notifications;
  final int status;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 10,
      right: 10,
      child: notifications <= 0
          ? IconStatusOrder(status)
          : badges.Badge(
              position: badges.BadgePosition.topEnd(top: -15, end: -5),
              badgeContent: Text(
                notifications.toString(),
                style: const TextStyle(color: Colors.white),
              ),
              child: IconStatusOrder(status),
            ),
    );
  }
}
