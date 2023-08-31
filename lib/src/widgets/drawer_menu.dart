import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:planck/constants/constants.dart';
import 'package:planck/constants/types_constant.dart';
import 'package:planck/generated/l10n.dart';
import 'package:planck/src/provider/preferences_provider.dart';
import 'package:planck/src/screens/about/about_screen.dart';
import 'package:planck/src/screens/addresses/addresses_screen.dart';
import 'package:planck/src/screens/admin/credit/credit_screen.dart';
import 'package:planck/src/screens/manager/company/company_screen.dart';
import 'package:planck/src/screens/manager/enrollment/enrollment_screen.dart';
import 'package:planck/src/screens/notification/notification_screen.dart';
import 'package:planck/src/screens/profile/profile_screen.dart';
import 'package:planck/src/widgets/avatar_image.dart';

class DraweMenu extends StatelessWidget {
  DraweMenu({super.key});

  final pref = PreferencesProvider();

  @override
  Widget build(BuildContext context) {
    return Drawer(
        child: Column(
      children: [
        Expanded(
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                DrawerHeader(
                  margin: EdgeInsets.zero,
                  padding: EdgeInsets.zero,
                  child: Header(pref),
                ),
                Visibility(
                  visible: pref.user.roles.contains(TypesRol.admin),
                  child: Container(
                    padding: const EdgeInsets.only(left: 15.0),
                    child: ListTile(
                        leading: const Icon(Icons.price_check_outlined,
                            color: kPrimaryColor),
                        title: Text(S.of(context).tTopUpBalance),
                        onTap: () {
                          Navigator.pop(context);
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => CreditScreen()));
                        }),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.only(left: 15.0),
                  child: ListTile(
                      leading: const Icon(Icons.notification_add_outlined,
                          color: kPrimaryColor),
                      title: Text(S.of(context).tNotifications),
                      onTap: () {
                        Navigator.pop(context);
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    const NotificacionPage()));
                      }),
                ),
                Container(
                  padding: const EdgeInsets.only(left: 15.0),
                  child: ListTile(
                      leading: const Icon(Icons.store_outlined,
                          color: kPrimaryColor),
                      title: Text(S.of(context).tStores),
                      onTap: () {
                        Navigator.pop(context);
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => CompanyScreen()));
                      }),
                ),
                Container(
                  padding: const EdgeInsets.only(left: 15.0),
                  child: ListTile(
                      leading: const Icon(Icons.pin_drop_outlined,
                          color: kPrimaryColor),
                      title: Text(S.of(context).tAddresses),
                      onTap: () {
                        Navigator.pop(context);
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => AddressesScreen()));
                      }),
                ),
              ],
            ),
          ),
        ),
        Footer(pref)
      ],
    ));
  }
}

class Header extends StatelessWidget {
  final PreferencesProvider pref;

  const Header(
    this.pref, {
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget content = Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        CircularPercentIndicator(
          radius: 33.0,
          lineWidth: 3.0,
          percent: 1.0,
          center: AvatarImage(
              width: 60,
              borderRadius: const BorderRadius.all(Radius.circular(100)),
              image: pref.user.image),
          progressColor: kPrimaryColor,
        ),
        const SizedBox(width: kDefaultPadding),
        Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
                child: Text(pref.user.fullName,
                    textScaleFactor: 1.4, overflow: TextOverflow.visible)),
            SizedBox(
                child: Text(pref.user.email,
                    textScaleFactor: 0.9,
                    softWrap: false,
                    overflow: TextOverflow.visible,
                    style: const TextStyle(color: kSecondaryColor))),
          ],
        )
      ],
    );
    return Stack(
      children: [
        content,
        Positioned.fill(
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              splashColor: Colors.blueAccent.withOpacity(0.6),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => ProfileScreen()));
              },
            ),
          ),
        ),
      ],
    );
  }
}

class Footer extends StatelessWidget {
  const Footer(
    this.pref, {
    Key? key,
  }) : super(key: key);

  final PreferencesProvider pref;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Visibility(
          visible:
              !pref.user.roles.contains(TypesRol.deliveryman) && !pref.isGuest,
          child: ListTile(
            leading: const Icon(Icons.app_registration_outlined,
                color: kPrimaryColor),
            title: Text(S.of(context).tRegisterStore),
            onTap: () {
              Navigator.pop(context);
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => EnrollmentScreen()));
            },
          ),
        ),
        ListTile(
          leading: const Icon(Icons.mode_of_travel, color: kPrimaryColor),
          title: Text(S.of(context).tAbout),
          onTap: () {
            Navigator.pop(context);
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => AboutScreen()));
          },
        ),
        const Divider(),
        const SizedBox(height: 1),
        const Text(
          'By using our service you agree to our Terms & Privacy Policy\nV: $kVersionn\nPowered by Planck',
          textScaleFactor: 0.72,
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 10),
      ],
    );
  }
}
