import 'package:flutter/material.dart';
import 'package:planck/constants/constants.dart';
import 'package:planck/generated/l10n.dart';
import 'package:planck/src/screens/admin/credit/credit_controller.dart';
import 'package:planck/src/screens/admin/credit/widget/amount_input.dart';
import 'package:planck/src/screens/admin/credit/widget/phone_input.dart';
import 'package:planck/src/screens/admin/credit/widget/top_up_balance_button.dart';
import 'package:planck/src/widgets/modal_progress_hud.dart';
import 'package:provider/provider.dart';

class CreditScreen extends StatelessWidget {
  CreditScreen({super.key});

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<CreditController>.value(
      value: CreditController(),
      child: Scaffold(
        body: Consumer<CreditController>(
          builder: (context, creditController, child) => ModalProgressHUD(
            inAsyncCall: creditController.inAsyncCall,
            child: Scaffold(
              appBar: AppBar(title: Text(S.of(context).tTopUpBalance)),
              body: Form(
                key: formKey,
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(kDefaultPadding),
                    child: Column(
                      children: [
                        const SizedBox(height: kDefaultPadding * 2),
                        PhoneInput(creditController),
                        const SizedBox(height: kDefaultPadding * 2),
                        AmountInput(creditController),
                        const SizedBox(height: kDefaultPadding * 2),
                        const SizedBox(height: kDefaultPadding * 2),
                        TopUpBalanceButton(creditController, formKey: formKey),
                        const SizedBox(height: kDefaultPadding * 7),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
