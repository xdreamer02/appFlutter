import 'package:flutter/material.dart';
import 'package:planck/constants/constants.dart';
import 'package:planck/generated/l10n.dart';
import 'package:planck/src/screens/manager/product/product_controller.dart';

class DescriptionInput extends StatelessWidget {
  const DescriptionInput({
    Key? key,
    required this.productController,
  }) : super(key: key);

  final ProductController productController;

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
          icon: const Icon(Icons.description_outlined, color: kPrimaryColor),
          hintText: S.of(context).hProductDescription,
          border: InputBorder.none,
        ),
        initialValue: productController.companyProduct.description,
        onSaved: (description) =>
            productController.companyProduct.description = description!,
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
