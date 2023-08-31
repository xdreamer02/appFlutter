import 'package:planck/constants/status_constant.dart';
import 'package:planck/generated/l10n.dart';

String statusOrderLabel(int status) {
  switch (status) {
    case StatusOrder.started:
      return S.current.lStatusOrderStarted;
    case StatusOrder.assigned:
      return S.current.lStatusOrderAssigned;
    case StatusOrder.taken:
      return S.current.lStatusOrderTaken;
    case StatusOrder.delivered:
      return S.current.lStatusOrderDelivered;
    case StatusOrder.cancelled:
      return S.current.lStatusOrderCancelled;
    case StatusOrder.qualified:
      return S.current.lStatusOrderQualified;
    default:
      return 'Unknown';
  }
}
