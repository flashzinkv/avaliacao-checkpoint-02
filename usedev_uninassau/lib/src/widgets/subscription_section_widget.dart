import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:usedev_uninassau/src/theme/app_colors.dart';
import 'package:usedev_uninassau/src/theme/responsive.dart';

class SubscriptionSectionWidget extends StatelessWidget {
  const SubscriptionSectionWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: const BoxDecoration(color: AppColors.limeGreen),
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: Responsive.horizontalPadding(context),
          vertical: 40,
        ),
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 640),
            child: Column(
              spacing: 20,
              children: [
                Text(
                  'Inscreva-se para ganhar descontos!',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: AppColors.darkNavy,
                    fontFamily: GoogleFonts.orbitron().fontFamily,
                  ),
                ),
                Text(
                  'Cadastre seu email, receba novidades e descontos imperdíveis antes de todo mundo!',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 16,
                    color: AppColors.darkNavy,
                    fontFamily: GoogleFonts.poppins().fontFamily,
                  ),
                ),
                TextField(
                  keyboardType: TextInputType.emailAddress,
                  textAlign: TextAlign.center,
                  decoration: InputDecoration(
                    hintText: 'Digite seu melhor endereço de email',
                    hintStyle: TextStyle(
                      color: AppColors.darkNavy.withValues(alpha: 0.6),
                      fontFamily: GoogleFonts.poppins().fontFamily,
                    ),
                    filled: true,
                    fillColor: Colors.white,
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 24,
                      vertical: 18,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(50),
                      borderSide: const BorderSide(color: AppColors.darkNavy),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(50),
                      borderSide: const BorderSide(color: AppColors.darkNavy),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(50),
                      borderSide: const BorderSide(
                        color: AppColors.darkNavy,
                        width: 2,
                      ),
                    ),
                  ),
                ),
                ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.purple,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 48,
                      vertical: 16,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50),
                    ),
                  ),
                  child: Text(
                    'Inscrever',
                    style: TextStyle(
                      fontFamily: GoogleFonts.poppins().fontFamily,
                      fontSize: 18,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
