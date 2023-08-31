import 'package:flutter/material.dart';
import 'package:planck/constants/constants.dart';
import 'package:planck/generated/l10n.dart';
import 'package:planck/src/screens/login/access_controller.dart';

class NameInput extends StatelessWidget {
  const NameInput(
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
        keyboardType: TextInputType.name,
        textCapitalization: TextCapitalization.words,
        decoration: InputDecoration(
          icon: const Icon(Icons.nest_cam_wired_stand_outlined,
              color: kPrimaryColor),
          hintText: S.of(context).hFullName,
          border: InputBorder.none,
        ),
        initialValue: accessController.fullName,
        onSaved: (hFullName) => accessController.fullName = hFullName!,
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
