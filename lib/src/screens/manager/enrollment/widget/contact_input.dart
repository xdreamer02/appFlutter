import 'package:flutter/material.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:planck/constants/constants.dart';
import 'package:planck/generated/l10n.dart';
import 'package:planck/src/screens/manager/enrollment/enrollment_controller.dart';

class ContactInput extends StatelessWidget {
  const ContactInput({Key? key, required this.enrollmentController})
      : super(key: key);
  final EnrollmentController enrollmentController;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding * 0.75),
      decoration: BoxDecoration(
        color: kPrimaryColor.withOpacity(0.05),
        borderRadius: BorderRadius.circular(20),
      ),
      child: IntlPhoneField(
        decoration: InputDecoration(labelText: S.of(context).hPhone),
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
        onSaved: (phone) => enrollmentController.enrollment.contact =
            phone!.completeNumber.toString().trim(),
      ),
    );
  }
}
