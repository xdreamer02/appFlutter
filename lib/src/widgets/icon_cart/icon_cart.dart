import 'package:badges/badges.dart' as badges;
import 'package:flutter/material.dart';
import 'package:planck/src/screens/cart/cart_screen.dart';
import 'package:planck/src/widgets/icon_cart/icon_cart_controller.dart';
import 'package:provider/provider.dart';

class IconCart extends StatelessWidget {
  const IconCart({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final items = Provider.of<IconCartController>(context).items;
    if (items <= 0) {
      return IconButton(
          icon: const Icon(Icons.shopping_cart_outlined),
          onPressed: () => _goToCartScreen(context));
    }
    return GestureDetector(
      onTap: () => _goToCartScreen(context),
      child: badges.Badge(
        position: badges.BadgePosition.topEnd(top: 0, end: 3),
        badgeContent: Text(
          items.toString(),
          style: const TextStyle(color: Colors.white),
        ),
        child: IconButton(
            icon: const Icon(Icons.shopping_cart_outlined),
            onPressed: () => _goToCartScreen(context)),
      ),
    );
  }

  _goToCartScreen(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => CartScreen(),
      ),
    );
  }
}
