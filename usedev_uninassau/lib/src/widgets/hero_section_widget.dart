import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:usedev_uninassau/src/theme/app_colors.dart';
import 'package:usedev_uninassau/src/theme/responsive.dart';

class HeroSectionWidget extends StatelessWidget {
  const HeroSectionWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final titleSize = Responsive.valueForScreen(
      context,
      mobile: 28,
      tablet: 38,
      desktop: 50,
    );
    final imageWidth = Responsive.valueForScreen(
      context,
      mobile: 220,
      tablet: 280,
      desktop: 340,
    );
    final horizontalPadding = Responsive.horizontalPadding(context);

    return SizedBox(
      width: double.infinity,
      child: DecoratedBox(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/banner_cta.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
          child: Column(
            spacing: 20,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 20),
                child: Image.asset('assets/hero_cta.png', width: imageWidth),
              ),
              Text.rich(
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: GoogleFonts.orbitron().fontFamily,
                  fontSize: titleSize,
                  fontWeight: FontWeight.bold,
                ),
                TextSpan(
                  text: 'Hora de abraçar seu ',
                  style: const TextStyle(color: AppColors.pink),
                  children: const [
                    TextSpan(
                      text: 'lado geek',
                      style: TextStyle(color: AppColors.limeGreen),
                    ),
                  ],
                ),
              ),
              ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.purple,
                  padding: EdgeInsets.symmetric(
                    horizontal: Responsive.valueForScreen(
                      context,
                      mobile: 24,
                      tablet: 28,
                      desktop: 30,
                    ),
                    vertical: Responsive.valueForScreen(
                      context,
                      mobile: 16,
                      tablet: 20,
                      desktop: 25,
                    ),
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50),
                  ),
                ),
                child: Text(
                  'Ver as Novidades',
                  style: TextStyle(
                    fontFamily: GoogleFonts.poppins().fontFamily,
                    fontSize: Responsive.valueForScreen(
                      context,
                      mobile: 16,
                      tablet: 20,
                      desktop: 25,
                    ),
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(height: 32),
            ],
          ),
        ),
      ),
    );
  }
}
