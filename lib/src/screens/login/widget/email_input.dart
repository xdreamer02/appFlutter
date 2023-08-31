import 'package:flutter/material.dart';
import 'package:planck/constants/constants.dart';
import 'package:planck/generated/l10n.dart';
import 'package:planck/src/common/validator.dart';
import 'package:planck/src/screens/login/access_controller.dart';

class EmailInput extends StatelessWidget {
  const EmailInput(
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
        keyboardType: TextInputType.emailAddress,
        textCapitalization: TextCapitalization.none,
        decoration: InputDecoration(
          icon:
              const Icon(Icons.mark_email_read_outlined, color: kPrimaryColor),
          hintText: S.of(context).hEmail,
          border: InputBorder.none,
        ),
        initialValue: accessController.email,
        onSaved: (email) => accessController.email = email!,
        validator: (value) => validateEmail(context, value!),
      ),
    );
  }
}
