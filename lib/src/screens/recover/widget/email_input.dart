import 'package:flutter/material.dart';
import 'package:planck/constants/constants.dart';
import 'package:planck/generated/l10n.dart';
import 'package:planck/src/common/validator.dart';
import 'package:planck/src/screens/recover/recover_controller.dart';

class EmailInput extends StatelessWidget {
  const EmailInput(
    this.recoverController, {
    Key? key,
  }) : super(key: key);
  final RecoverController recoverController;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding * 0.75),
        margin: const EdgeInsets.symmetric(horizontal: kDefaultPadding * 0.5),
        decoration: BoxDecoration(
          color: kPrimaryColor.withOpacity(0.05),
          borderRadius: BorderRadius.circular(20),
        ),
        child: TextFormField(
          keyboardType: TextInputType.emailAddress,
          textCapitalization: TextCapitalization.none,
          decoration: InputDecoration(
            icon: const Icon(Icons.mail_lock_outlined, color: kPrimaryColor),
            hintText: S.of(context).hEmail,
            border: InputBorder.none,
          ),
          onSaved: (email) => recoverController.email = email!,
          validator: (value) => validateEmail(context, value!),
        ),
      ),
    );
  }
}
