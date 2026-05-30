import 'package:flutter/material.dart';
import 'package:usedev_uninassau/src/controllers/profile_controller.dart';
import 'package:usedev_uninassau/src/screens/cart_screen.dart';
import 'package:usedev_uninassau/src/screens/profile_screen.dart';

class AppTopBarWidget extends StatelessWidget implements PreferredSizeWidget {
  const AppTopBarWidget({
    this.enableCartNavigation = true,
    this.enableProfileNavigation = true,
    super.key,
  });

  final bool enableCartNavigation;
  final bool enableProfileNavigation;

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    final profile = ProfileScope.of(context);

    return AnimatedBuilder(
      animation: profile,
      builder: (context, _) {
        return AppBar(
          leading: IconButton(
            onPressed: () => Scaffold.of(context).openDrawer(),
            icon: const Icon(Icons.menu, size: 40),
          ),
          title: Image.asset('assets/logo_usedev.png', height: 40),
          centerTitle: true,
          actions: [
            IconButton(
              onPressed: enableProfileNavigation
                  ? () {
                      Navigator.push(
                        context,
                        MaterialPageRoute<void>(
                          builder: (context) => const ProfileScreen(),
                        ),
                      );
                    }
                  : null,
              icon: Icon(
                profile.isLoggedIn ? Icons.person : Icons.person_outline,
                size: 40,
              ),
            ),
            const SizedBox(width: 10),
            IconButton(
              onPressed: enableCartNavigation
                  ? () {
                      Navigator.push(
                        context,
                        MaterialPageRoute<void>(
                          builder: (context) => const CartScreen(),
                        ),
                      );
                    }
                  : null,
              icon: const Icon(Icons.shopping_cart_outlined, size: 40),
            ),
            const SizedBox(width: 25),
          ],
        );
      },
    );
  }
}
