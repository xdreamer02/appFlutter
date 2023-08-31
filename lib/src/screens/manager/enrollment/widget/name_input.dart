import 'package:flutter/material.dart';
import 'package:planck/constants/constants.dart';
import 'package:planck/generated/l10n.dart';
import 'package:planck/src/screens/manager/enrollment/enrollment_controller.dart';

class NameInput extends StatelessWidget {
  const NameInput({
    Key? key,
    required this.enrollmentController,
  }) : super(key: key);

  final EnrollmentController enrollmentController;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding * 0.75),
      decoration: BoxDecoration(
        color: kPrimaryColor.withOpacity(0.05),
        borderRadius: BorderRadius.circular(20),
      ),
      child: TextFormField(
        keyboardType: TextInputType.name,
        textCapitalization: TextCapitalization.sentences,
        decoration: InputDecoration(
          icon: const Icon(Icons.store_outlined, color: kPrimaryColor),
          hintText: S.of(context).hFullName,
          border: InputBorder.none,
        ),
        initialValue: enrollmentController.enrollment.name,
        onSaved: (name) => enrollmentController.enrollment.name = name!.trim(),
        validator: (value) {
          if (value!.trim().length < 5) {
            return S.of(context).eValidatoCharacters(5);
          }
          return null;
        },
      ),
    );
  }
}
