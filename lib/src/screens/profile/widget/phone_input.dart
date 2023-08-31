import 'package:flutter/material.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:planck/constants/constants.dart';
import 'package:planck/generated/l10n.dart';
import 'package:planck/src/screens/profile/profile_controller.dart';

class PhoneInput extends StatelessWidget {
  const PhoneInput(
    this.profileController, {
    Key? key,
  }) : super(key: key);
  final ProfileController profileController;

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
        decoration: InputDecoration(
          labelText: S.of(context).hPhone,
          helperText:
              S.of(context).hYourPhoneNumber(profileController.olpPhone),
        ),
        initialCountryCode: kCountryCode,
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
            profileController.phone = phone!.completeNumber.toString(),
      ),
    );
  }
}
