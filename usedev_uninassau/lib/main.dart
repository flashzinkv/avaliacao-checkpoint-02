import 'package:flutter/material.dart';
import 'package:usedev_uninassau/src/controllers/cart_controller.dart';
import 'package:usedev_uninassau/src/controllers/profile_controller.dart';
import 'package:usedev_uninassau/src/screens/initial_screen.dart';

void main() {
  runApp(
    MyApp(
      cartController: CartController(),
      profileController: ProfileController(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({
    required this.cartController,
    required this.profileController,
    super.key,
  });

  final CartController cartController;
  final ProfileController profileController;

  @override
  Widget build(BuildContext context) {
    return CartScope(
      controller: cartController,
      child: ProfileScope(
        controller: profileController,
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'UseDev',
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          ),
          home: const InitialScreen(),
        ),
      ),
    );
  }
}
