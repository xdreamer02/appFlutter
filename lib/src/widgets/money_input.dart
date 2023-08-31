import 'package:flutter/material.dart';
import 'package:planck/constants/constants.dart';
import 'package:planck/generated/l10n.dart';

class MoneyInput extends StatelessWidget {
  MoneyInput(
    this.money, {
    Key? key,
  }) : super(key: key);

  final double money;
  final TextEditingController textEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    textEditingController.text = money.toStringAsFixed(kCoinDecimals);
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
            labelText: S.of(context).lTMoneyValid,
            prefixIcon:
                const Icon(Icons.price_check_outlined, color: kPrimaryColor),
            border: InputBorder.none,
            hintTextDirection: TextDirection.rtl,
            helperText: S.of(context).lHMoneyValid),
      ),
    );
  }
}
