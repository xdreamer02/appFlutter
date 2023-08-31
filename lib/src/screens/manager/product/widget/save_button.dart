import 'package:flutter/material.dart';
import 'package:planck/constants/constants.dart';
import 'package:planck/generated/l10n.dart';
import 'package:planck/src/models/company_product_model.dart';
import 'package:planck/src/screens/manager/product/product_controller.dart';
import 'package:planck/src/screens/manager/products/products_controller.dart';
import 'package:planck/src/widgets/secondary_button.dart';

class SaveButton extends StatelessWidget {
  const SaveButton({
    Key? key,
    required this.productController,
    required GlobalKey<FormState> formKey,
    required this.productsController,
  })  : _formKey = formKey,
        super(key: key);

  final ProductController productController;
  final GlobalKey<FormState> _formKey;
  final ProductsController productsController;

  @override
  Widget build(BuildContext context) {
    return SecondaryButton(
      color: Theme.of(context).colorScheme.secondary,
      text: S.of(context).bSaveChanges,
      onPressed: () async {
        FocusScope.of(context).requestFocus(FocusNode());
        final s = S.of(context);
        final scaffoldMessenger = ScaffoldMessenger.of(context);

        if (productController.companyProduct.image.isEmpty) {
          scaffoldMessenger.showSnackBar(SnackBar(
            backgroundColor: kErrorColor,
            content: Text(s.errPleaseUploadImage),
          ));
          return;
        }

        if (!_formKey.currentState!.validate()) return;
        _formKey.currentState!.save();

        CompanyProductModel? companyProduct = await productController
            .updateProduct(productsController.storeCompany.company.id);

        if (companyProduct == null) {
          scaffoldMessenger.showSnackBar(SnackBar(
            backgroundColor: kErrorColor,
            content: Text(s.errUnknown),
          ));
          return;
        }

        productsController.setProducts(companyProduct);
        scaffoldMessenger.showSnackBar(SnackBar(
          backgroundColor: kPrimaryColor,
          content: Text(s.mRChangesMadeCorrectly),
        ));
      },
    );
  }
}
