import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget {
  const CustomAppBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      pinned: true,
      title: Image.asset(
        "assets/images/logo.png",
        height: 50,
        width: 50,
        fit: BoxFit.contain,
      ),
      leading: Icon(Icons.menu),
      actions: [
        IconButton(onPressed: () {}, icon: Icon(Icons.shopping_cart_outlined))
      ],
      backgroundColor: Colors.green,
    );
  }
}
