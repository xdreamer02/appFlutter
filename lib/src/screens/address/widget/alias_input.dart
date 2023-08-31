import 'package:flutter/material.dart';
import 'package:planck/constants/constants.dart';
import 'package:planck/generated/l10n.dart';
import 'package:planck/src/screens/address/address_controller.dart';

class AliasInput extends StatelessWidget {
  const AliasInput({
    Key? key,
    required this.addressController,
  }) : super(key: key);

  final AddressController addressController;

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
          icon: const Icon(Icons.place_outlined, color: kPrimaryColor),
          hintText: S.of(context).hAlias,
          border: InputBorder.none,
        ),
        initialValue: addressController.address.alias,
        onSaved: (alias) => addressController.address.alias = alias!,
        validator: (value) {
          if (value!.trim().length < 2) {
            return S.of(context).eValidatoCharacters(2);
          }
          return null;
        },
      ),
    );
  }
}
