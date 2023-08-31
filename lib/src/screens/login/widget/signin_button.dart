import 'package:flutter/material.dart';
import 'package:planck/constants/types_constant.dart';
import 'package:planck/generated/l10n.dart';
import 'package:planck/src/models/user_model.dart';
import 'package:planck/src/screens/deliveryman/petitions/petitions_screen.dart';
import 'package:planck/src/screens/login/access_controller.dart';
import 'package:planck/src/screens/main/tab_main_screen.dart';
import 'package:planck/src/screens/manager/requests/requests_screen.dart';
import 'package:planck/src/screens/recover/recover_screen.dart';
import 'package:planck/src/widgets/primary_button.dart';

class SigninButton extends StatelessWidget {
  const SigninButton(
    this.accessController, {
    Key? key,
    required GlobalKey<FormState> formKey,
  })  : _formKey = formKey,
        super(key: key);
  final AccessController accessController;
  final GlobalKey<FormState> _formKey;

  @override
  Widget build(BuildContext context) {
    return PrimaryButton(
      text: S.of(context).bSignin,
      onPressed: () async {
        FocusScope.of(context).requestFocus(FocusNode());
        _formKey.currentState!.save();
        if (!_formKey.currentState!.validate()) return;

        final navigator = Navigator.of(context);
        final scaffoldMessenger = ScaffoldMessenger.of(context);
        final s = S.of(context);

        UserModel? userLogin = await accessController.signin();
        if (userLogin != null) {
          MaterialPageRoute route;
          if (userLogin.roles.contains(TypesRol.deliveryman)) {
            route = MaterialPageRoute(
                builder: (context) => const PetitionsScreen());
          } else if (userLogin.roles.contains(TypesRol.manager)) {
            route =
                MaterialPageRoute(builder: (context) => const RequestsScreen());
          } else {
            route =
                MaterialPageRoute(builder: (context) => const TabMainScreen());
          }
          navigator.pushAndRemoveUntil(route, (Route<dynamic> route) {
            return false;
          });
        } else {
          scaffoldMessenger.showSnackBar(SnackBar(
            duration: const Duration(milliseconds: 4500),
            content: Text(s.mIncorrectLogin),
            action: SnackBarAction(
              label: s.bRecoverAccount,
              textColor: Colors.red,
              onPressed: () => Navigator.push(context,
                  MaterialPageRoute(builder: (context) => RecoverScreen())),
            ),
          ));
        }
      },
    );
  }
}
