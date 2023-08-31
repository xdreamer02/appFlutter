import 'package:flutter/material.dart';
import 'package:planck/constants/constants.dart';
import 'package:planck/generated/l10n.dart';
import 'package:planck/src/common/validator.dart';
import 'package:planck/src/screens/manager/product/product_controller.dart';

class PriceInput extends StatelessWidget {
  const PriceInput({
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
        keyboardType: TextInputType.number,
        textCapitalization: TextCapitalization.sentences,
        decoration: InputDecoration(
          icon: const Icon(Icons.price_check_outlined, color: kPrimaryColor),
          hintText: S.of(context).lPrice,
          border: InputBorder.none,
        ),
        initialValue: productController.companyProduct.price
            .toStringAsFixed(kCoinDecimals),
        onSaved: (price) {
          price = price!.trim();
          price = price.replaceFirst(',', '.');
          productController.companyProduct.price = double.parse(price);
        },
        validator: (value) => validatePrice(context, value!),
      ),
    );
  }
}
