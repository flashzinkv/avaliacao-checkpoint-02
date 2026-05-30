import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:usedev_uninassau/src/controllers/profile_controller.dart';
import 'package:usedev_uninassau/src/models/user.dart';
import 'package:usedev_uninassau/src/theme/app_colors.dart';
import 'package:usedev_uninassau/src/theme/responsive.dart';
import 'package:usedev_uninassau/src/widgets/app_drawer_widget.dart';
import 'package:usedev_uninassau/src/widgets/app_search_bar_widget.dart';
import 'package:usedev_uninassau/src/widgets/app_snackbar.dart';
import 'package:usedev_uninassau/src/widgets/app_top_bar_widget.dart';
import 'package:usedev_uninassau/src/widgets/footer_section_widget.dart';
import 'package:usedev_uninassau/src/widgets/responsive_page_widget.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _obscurePassword = true;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final profile = ProfileScope.of(context);
    final horizontalPadding = Responsive.horizontalPadding(context);

    return Scaffold(
      appBar: const AppTopBarWidget(enableProfileNavigation: false),
      drawer: const AppDrawerWidget(),
      body: AnimatedBuilder(
        animation: profile,
        builder: (context, _) {
          return SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const AppSearchBarWidget(),
                const ProductBannerWidget(),
                ResponsivePage(
                  child: Padding(
                    padding: EdgeInsets.all(horizontalPadding),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Row(
                          children: [
                            IconButton(
                              onPressed: () => Navigator.pop(context),
                              icon: const Icon(Icons.arrow_back, size: 28),
                            ),
                            Text(
                              profile.isLoggedIn ? 'Meu Perfil' : 'Entrar',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                fontFamily: GoogleFonts.poppins().fontFamily,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),
                        if (profile.isLoggedIn)
                          _LoggedInContent(
                            user: profile.user!,
                            onLogout: () {
                              profile.logout();
                              AppSnackbar.success(
                                context,
                                'Você saiu da sua conta.',
                              );
                            },
                          )
                        else
                          _LoginForm(
                            emailController: _emailController,
                            passwordController: _passwordController,
                            obscurePassword: _obscurePassword,
                            onTogglePassword: () {
                              setState(() {
                                _obscurePassword = !_obscurePassword;
                              });
                            },
                            onSubmit: () {
                              final error = profile.login(
                                email: _emailController.text,
                                password: _passwordController.text,
                              );

                              if (error != null) {
                                AppSnackbar.error(context, error);
                                return;
                              }

                              _passwordController.clear();
                              AppSnackbar.success(
                                context,
                                'Login realizado com sucesso!',
                              );
                            },
                          ),
                        const SizedBox(height: 32),
                      ],
                    ),
                  ),
                ),
                const FooterSectionWidget(),
              ],
            ),
          );
        },
      ),
    );
  }
}

class _LoginForm extends StatelessWidget {
  const _LoginForm({
    required this.emailController,
    required this.passwordController,
    required this.obscurePassword,
    required this.onTogglePassword,
    required this.onSubmit,
  });

  final TextEditingController emailController;
  final TextEditingController passwordController;
  final bool obscurePassword;
  final VoidCallback onTogglePassword;
  final VoidCallback onSubmit;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: const Color(0xFFF0F0F0),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        spacing: 16,
        children: [
          Text(
            'Acesse sua conta',
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: AppColors.darkNavy,
              fontFamily: GoogleFonts.orbitron().fontFamily,
            ),
          ),
          Text(
            'Entre para acompanhar pedidos e salvar seus dados de compra.',
            style: TextStyle(
              fontSize: 14,
              height: 1.4,
              color: AppColors.subtitleText,
              fontFamily: GoogleFonts.poppins().fontFamily,
            ),
          ),
          _ProfileTextField(
            controller: emailController,
            label: 'E-mail',
            hint: 'seu@email.com',
            keyboardType: TextInputType.emailAddress,
          ),
          _ProfileTextField(
            controller: passwordController,
            label: 'Senha',
            hint: 'Mínimo de 6 caracteres',
            obscureText: obscurePassword,
            suffixIcon: IconButton(
              onPressed: onTogglePassword,
              icon: Icon(
                obscurePassword ? Icons.visibility_off : Icons.visibility,
                color: AppColors.darkNavy,
              ),
            ),
          ),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: onSubmit,
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.purple,
                padding: const EdgeInsets.symmetric(vertical: 18),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(50),
                ),
              ),
              child: Text(
                'Entrar',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  fontFamily: GoogleFonts.poppins().fontFamily,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _LoggedInContent extends StatelessWidget {
  const _LoggedInContent({
    required this.user,
    required this.onLogout,
  });

  final User user;
  final VoidCallback onLogout;

  @override
  Widget build(BuildContext context) {
    final initials = user.name
        .split(' ')
        .where((part) => part.isNotEmpty)
        .take(2)
        .map((part) => part[0].toUpperCase())
        .join();

    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: const Color(0xFFF0F0F0),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        spacing: 20,
        children: [
          CircleAvatar(
            radius: 40,
            backgroundColor: AppColors.purple,
            child: Text(
              initials,
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Colors.white,
                fontFamily: GoogleFonts.orbitron().fontFamily,
              ),
            ),
          ),
          Text(
            'Olá, ${user.name}!',
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: AppColors.darkNavy,
              fontFamily: GoogleFonts.orbitron().fontFamily,
            ),
          ),
          _ProfileInfoRow(label: 'Nome', value: user.name),
          _ProfileInfoRow(label: 'E-mail', value: user.email),
          SizedBox(
            width: double.infinity,
            child: OutlinedButton(
              onPressed: onLogout,
              style: OutlinedButton.styleFrom(
                foregroundColor: AppColors.darkNavy,
                side: const BorderSide(color: AppColors.darkNavy),
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(50),
                ),
              ),
              child: Text(
                'Sair',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  fontFamily: GoogleFonts.poppins().fontFamily,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _ProfileInfoRow extends StatelessWidget {
  const _ProfileInfoRow({
    required this.label,
    required this.value,
  });

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 4,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 13,
            color: AppColors.subtitleText,
            fontFamily: GoogleFonts.poppins().fontFamily,
          ),
        ),
        Text(
          value,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: AppColors.darkNavy,
            fontFamily: GoogleFonts.poppins().fontFamily,
          ),
        ),
      ],
    );
  }
}

class _ProfileTextField extends StatelessWidget {
  const _ProfileTextField({
    required this.controller,
    required this.label,
    required this.hint,
    this.keyboardType,
    this.obscureText = false,
    this.suffixIcon,
  });

  final TextEditingController controller;
  final String label;
  final String hint;
  final TextInputType? keyboardType;
  final bool obscureText;
  final Widget? suffixIcon;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 8,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: AppColors.darkNavy,
            fontFamily: GoogleFonts.poppins().fontFamily,
          ),
        ),
        TextField(
          controller: controller,
          keyboardType: keyboardType,
          obscureText: obscureText,
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: TextStyle(
              color: AppColors.subtitleText,
              fontFamily: GoogleFonts.poppins().fontFamily,
            ),
            filled: true,
            fillColor: Colors.white,
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 20,
              vertical: 16,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: AppColors.darkNavy),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(
                color: AppColors.darkNavy.withValues(alpha: 0.3),
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: AppColors.purple, width: 2),
            ),
            suffixIcon: suffixIcon,
          ),
        ),
      ],
    );
  }
}
