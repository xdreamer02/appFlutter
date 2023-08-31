import 'package:flutter/material.dart';
import 'package:planck/generated/l10n.dart';
import 'package:planck/src/provider/db_provider.dart';
import 'package:planck/src/provider/preferences_provider.dart';
import 'package:planck/src/screens/address/address_controller.dart';
import 'package:planck/src/screens/address/widget/address_dialog.dart';
import 'package:planck/src/screens/main/tab1_controller.dart';
import 'package:planck/src/screens/main/tab_main_screen.dart';
import 'package:planck/src/widgets/primary_button.dart';
import 'package:provider/provider.dart';

class FooterButton extends StatelessWidget {
  const FooterButton({
    Key? key,
    required this.prefs,
    required this.addressController,
  }) : super(key: key);

  final AddressController addressController;
  final PreferencesProvider prefs;

  @override
  Widget build(BuildContext context) {
    return Positioned.fill(
      child: Align(
        alignment: Alignment.bottomCenter,
        child: PrimaryButton(
          text: S.of(context).bEstablishLocation,
          onPressed: () async {
            if (prefs.isAuth) {
              showDialog(
                context: context,
                barrierDismissible: false,
                builder: (context) => AddressDialog(addressController),
              );
            } else {
              //When the client is not authenticated, it is only saved on a local basis.
              final navigator = Navigator.of(context);
              final tab1Controller =
                  Provider.of<Tab1Controller>(context, listen: false);
              if (await DBProvider.db.loadAddress() == null) {
                await addressController.saveAdrressDb();
                navigator.pushAndRemoveUntil(
                    MaterialPageRoute(
                        builder: (context) => const TabMainScreen()),
                    (Route<dynamic> route) {
                  return false;
                });
              } else {
                await addressController.saveAdrressDb();
                navigator.popUntil((route) => route.isFirst);
                tab1Controller.load();
              }
            }
          },
        ),
      ),
    );
  }
}
