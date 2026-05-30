import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:usedev_uninassau/src/theme/app_colors.dart';
import 'package:usedev_uninassau/src/theme/responsive.dart';

class AppSearchBarWidget extends StatelessWidget {
  const AppSearchBarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(
        Responsive.horizontalPadding(context),
        8,
        Responsive.horizontalPadding(context),
        16,
      ),
      child: TextField(
        decoration: InputDecoration(
          hintText: 'O que você procura?',
          hintStyle: TextStyle(
            color: AppColors.subtitleText,
            fontFamily: GoogleFonts.poppins().fontFamily,
          ),
          filled: true,
          fillColor: const Color(0xFFEEEEEE),
          contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(50),
            borderSide: BorderSide.none,
          ),
          suffixIcon: const Icon(Icons.search, color: AppColors.darkNavy),
        ),
      ),
    );
  }
}

class ProductBannerWidget extends StatelessWidget {
  const ProductBannerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 72,
      width: double.infinity,
      child: CustomPaint(
        painter: _GridBannerPainter(),
        child: const SizedBox.expand(),
      ),
    );
  }
}

class _GridBannerPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final background = Paint()..color = const Color(0xFF2A0F4E);
    canvas.drawRect(Offset.zero & size, background);

    final linePaint = Paint()
      ..color = AppColors.purple.withValues(alpha: 0.45)
      ..strokeWidth = 1;

    for (var i = 0; i <= 8; i++) {
      final y = size.height * (i / 8);
      canvas.drawLine(Offset(0, y), Offset(size.width, y), linePaint);
    }

    for (var i = 0; i <= 12; i++) {
      final x = size.width * (i / 12);
      canvas.drawLine(Offset(x, 0), Offset(x, size.height), linePaint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
