import 'package:flutter/material.dart';
import 'package:planck/generated/l10n.dart';
import 'package:planck/src/models/notification_model.dart';
import 'package:planck/src/screens/notification/widget/list_notifications.dart';

class NotificacionPage extends StatefulWidget {
  const NotificacionPage({Key? key}) : super(key: key);

  @override
  createState() => _NotificacionPageState();
}

class _NotificacionPageState extends State<NotificacionPage> {
  final List<NotificationModel> notifications = [];

  @override
  void initState() {
    notifications.add(NotificationModel(
      detail: 'Agrega módulos EXTRA a tu APP de delivery | UBER',
      hint:
          'Uber Taxi |  Categorías productos | Buscador inteligente | Notifica pedidos a riders específicos | ...',
      image:
          'https://firebasestorage.googleapis.com/v0/b/curiosity-0001.appspot.com/o/nt%2Fplus.jpeg?alt=media',
      url: 'https://udemy.planck.biz/lili-plus',
    ));

    notifications.add(NotificationModel(
      detail: 'Acepta PAGOS con CRIPTOMONEDAS',
      hint:
          'Solana Pay | Frontend en Flutter | Backend en NodeJS | Firebase Firestore |  Firebase Functions | Multi Plataforma |',
      image:
          'https://firebasestorage.googleapis.com/v0/b/curiosity-0001.appspot.com/o/nt%2Fpay.jpeg?alt=media',
      url: 'https://udemy.planck.biz/pay',
    ));

    notifications.add(NotificationModel(
      detail: 'VueJS y Smart Contract',
      hint:
          'Tu DApp con Vue 3 en la blockchain de Solana | GANA PROPINAS en el token SOL | Vue Router | Vuex | Rust | Anchor | Web3',
      image:
          'https://firebasestorage.googleapis.com/v0/b/curiosity-0001.appspot.com/o/nt%2Fjuno.jpeg?alt=media',
      url: 'https://udemy.planck.biz/vuejs-smart',
    ));

    notifications.add(NotificationModel(
      detail: 'ChatBot WhatsApp',
      hint:
          'Frontend en Flutter | Backend en NodeJS | Base de datos en MySQL | RESTfull |  Archivos | Socket |  EJS',
      image:
          'https://firebasestorage.googleapis.com/v0/b/curiosity-0001.appspot.com/o/nt%2Fcheck.jpeg?alt=media',
      url: 'https://udemy.planck.biz/whatsapp',
    ));

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:
          AppBar(centerTitle: true, title: Text(S.of(context).tNotifications)),
      body: Center(
        child: Column(
          children: <Widget>[
            const SizedBox(height: 10.0),
            Expanded(child: ListNotifications(notifications)),
          ],
        ),
      ),
    );
  }
}
