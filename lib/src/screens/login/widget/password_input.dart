import 'package:flutter/material.dart';
import 'package:planck/constants/constants.dart';
import 'package:planck/generated/l10n.dart';
import 'package:planck/src/screens/login/access_controller.dart';

class PasswordInput extends StatelessWidget {
  const PasswordInput(
    this.accessController, {
    Key? key,
  }) : super(key: key);
  final AccessController accessController;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding * 0.75),
      margin: const EdgeInsets.symmetric(horizontal: kDefaultPadding * 0.5),
      decoration: BoxDecoration(
        color: kPrimaryColor.withOpacity(0.05),
        borderRadius: BorderRadius.circular(20),
      ),
      child: TextFormField(
        obscureText: true,
        keyboardType: TextInputType.emailAddress,
        textCapitalization: TextCapitalization.none,
        decoration: InputDecoration(
          icon: const Icon(Icons.password_outlined, color: kPrimaryColor),
          hintText: S.of(context).hPassword,
          border: InputBorder.none,
        ),
        initialValue: accessController.password,
        onSaved: (password) => accessController.password = password!,
        validator: (value) {
          if (value!.trim().length < 6) {
            return S.of(context).eValidatoCharacters(6);
          }
          return null;
        },
      ),
    );
  }
}
