import 'package:flutter/material.dart';
import 'package:planck/constants/constants.dart';
import 'package:planck/src/screens/cart_summary/cart_summary_controller.dart';
import 'package:planck/src/screens/cart_summary/widget/details_products.dart';
import 'package:planck/src/widgets/avatar_image.dart';

class CompanyProducts extends StatelessWidget {
  const CompanyProducts({
    Key? key,
    required this.cartSummaryController,
    required this.width,
  }) : super(key: key);

  final CartSummaryController cartSummaryController;
  final double width;

  @override
  Widget build(BuildContext context) {
    return ListView(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      children: List.generate(
        cartSummaryController.summaries.length,
        (index) {
          return Container(
            padding: const EdgeInsets.all(kDefaultPadding),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Row(
                  children: [
                    SizedBox(
                      width: 35,
                      child: AvatarImage(
                          image:
                              cartSummaryController.summaries[index].fee.image),
                    ),
                    const SizedBox(width: 20),
                    Text(cartSummaryController.summaries[index].fee.name),
                    Expanded(child: Container()),
                    SizedBox(
                      width: 28,
                      child: AvatarImage(
                          image: cartSummaryController
                              .summaries[index].fee.marker),
                    ),
                  ],
                ),
                SizedBox(
                  width: width,
                  child: DetailsProducts(
                      cartSummary: cartSummaryController.summaries[index]),
                ),
                const Divider(height: 10),
              ],
            ),
          );
        },
      ),
    );
  }
}
