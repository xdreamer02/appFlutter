import 'package:flutter/material.dart';
import 'package:planck/constants/constants.dart';
import 'package:planck/generated/l10n.dart';
import 'package:planck/src/screens/manager/enrollment/enrollment_controller.dart';

class AddressInput extends StatelessWidget {
  const AddressInput({
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
        maxLines: 4,
        minLines: 1,
        keyboardType: TextInputType.streetAddress,
        textCapitalization: TextCapitalization.sentences,
        decoration: InputDecoration(
          icon: const Icon(Icons.maps_home_work_outlined, color: kPrimaryColor),
          hintText: S.of(context).hAddress,
          border: InputBorder.none,
        ),
        initialValue: enrollmentController.enrollment.address,
        onSaved: (address) =>
            enrollmentController.enrollment.address = address!.trim(),
        validator: (value) {
          if (value!.trim().length < 10) {
            return S.of(context).eValidatoCharacters(10);
          }
          return null;
        },
      ),
    );
  }
}
