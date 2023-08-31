import 'package:flutter/material.dart';
import 'package:planck/constants/constants.dart';
import 'package:planck/generated/l10n.dart';

class AmountInput extends StatelessWidget {
  AmountInput(
    this.amount, {
    Key? key,
  }) : super(key: key);

  final double amount;
  final TextEditingController textEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    textEditingController.text = amount.toStringAsFixed(kCoinDecimals);
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding * 0.4),
      margin: const EdgeInsets.symmetric(horizontal: kDefaultPadding * 0.5),
      decoration: BoxDecoration(
        color: kPrimaryColor.withOpacity(0.05),
        borderRadius: BorderRadius.circular(20),
      ),
      child: TextField(
        controller: textEditingController,
        readOnly: true,
        autofocus: true,
        decoration: InputDecoration(
            contentPadding: const EdgeInsets.only(
                left: kDefaultPadding * 0.5, top: kDefaultPadding * 0.5),
            labelText: 'Amount',
            prefixIcon:
                const Icon(Icons.credit_score_outlined, color: kPrimaryColor),
            border: InputBorder.none,
            hintTextDirection: TextDirection.rtl,
            helperText: S.of(context).lHAmounValid),
      ),
    );
  }
}
