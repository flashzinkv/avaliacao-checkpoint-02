import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:usedev_uninassau/src/controllers/profile_controller.dart';
import 'package:usedev_uninassau/src/screens/cart_screen.dart';
import 'package:usedev_uninassau/src/screens/initial_screen.dart';
import 'package:usedev_uninassau/src/screens/profile_screen.dart';
import 'package:usedev_uninassau/src/theme/app_colors.dart';
import 'package:usedev_uninassau/src/widgets/app_snackbar.dart';

class AppDrawerWidget extends StatelessWidget {
  const AppDrawerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final profile = ProfileScope.of(context);

    return Drawer(
      backgroundColor: AppColors.darkNavy,
      child: SafeArea(
        child: AnimatedBuilder(
          animation: profile,
          builder: (context, _) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(24, 24, 24, 16),
                  child: Column(
                    children: [
                      ColorFiltered(
                        colorFilter: const ColorFilter.mode(
                          AppColors.limeGreen,
                          BlendMode.srcIn,
                        ),
                        child: Image.asset('assets/logo_usedev.png', height: 48),
                      ),
                      const SizedBox(height: 12),
                      Text(
                        'Hora de abraçar seu lado geek!',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: AppColors.limeGreen,
                          fontSize: 14,
                          fontFamily: GoogleFonts.orbitron().fontFamily,
                        ),
                      ),
                    ],
                  ),
                ),
                const Divider(color: AppColors.limeGreen, height: 1),
                Expanded(
                  child: ListView(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    children: [
                      _DrawerTile(
                        icon: Icons.home_outlined,
                        label: 'Início',
                        onTap: () => _navigateTo(context, const InitialScreen()),
                      ),
                      _DrawerTile(
                        icon: Icons.shopping_cart_outlined,
                        label: 'Carrinho',
                        onTap: () => _navigateTo(context, const CartScreen()),
                      ),
                      _DrawerTile(
                        icon: profile.isLoggedIn
                            ? Icons.person
                            : Icons.person_outline,
                        label: profile.isLoggedIn ? 'Meu Perfil' : 'Entrar',
                        onTap: () => _navigateTo(context, const ProfileScreen()),
                      ),
                      const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                        child: Divider(color: AppColors.limeGreen),
                      ),
                      _DrawerTile(
                        icon: Icons.info_outline,
                        label: 'Sobre nós',
                        onTap: () => _showComingSoon(context),
                      ),
                      _DrawerTile(
                        icon: Icons.mail_outline,
                        label: 'Contato',
                        onTap: () => _showComingSoon(context),
                      ),
                      _DrawerTile(
                        icon: Icons.local_shipping_outlined,
                        label: 'Entregas',
                        onTap: () => _showComingSoon(context),
                      ),
                    ],
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  void _navigateTo(BuildContext context, Widget screen) {
    Navigator.pop(context);

    if (screen is InitialScreen) {
      Navigator.of(context).popUntil((route) => route.isFirst);
      return;
    }

    Navigator.push(
      context,
      MaterialPageRoute<void>(builder: (context) => screen),
    );
  }

  void _showComingSoon(BuildContext context) {
    Navigator.pop(context);
    AppSnackbar.success(context, 'Conteúdo em breve!');
  }
}

class _DrawerTile extends StatelessWidget {
  const _DrawerTile({
    required this.icon,
    required this.label,
    required this.onTap,
  });

  final IconData icon;
  final String label;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(icon, color: AppColors.limeGreen, size: 28),
      title: Text(
        label,
        style: TextStyle(
          color: Colors.white,
          fontSize: 16,
          fontFamily: GoogleFonts.poppins().fontFamily,
        ),
      ),
      onTap: onTap,
    );
  }
}
