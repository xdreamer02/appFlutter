import 'package:flutter/material.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:planck/constants/constants.dart';
import 'package:planck/generated/l10n.dart';
import 'package:planck/src/screens/login/access_controller.dart';

class PhoneInput extends StatelessWidget {
  const PhoneInput(
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
      child: IntlPhoneField(
        decoration: InputDecoration(labelText: S.of(context).hPhone),
        initialCountryCode: kCountryCode,
        initialValue: accessController.phone,
        invalidNumberMessage: S.of(context).eValidatoPhone,
        disableLengthCheck: true,
        validator: (value) {
          if (value!.completeNumber.trim().length < 10 ||
              value.completeNumber.trim().length > 19) {
            return S.of(context).eValidatoPhone;
          }
          return null;
        },
        onSaved: (phone) =>
            accessController.phone = phone!.completeNumber.toString(),
      ),
    );
  }
}
