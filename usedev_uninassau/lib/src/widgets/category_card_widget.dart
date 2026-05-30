import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:usedev_uninassau/src/models/category_item.dart';
import 'package:usedev_uninassau/src/theme/app_colors.dart';

class CategoryCardWidget extends StatelessWidget {
  const CategoryCardWidget({
    required this.category,
    super.key,
  });

  final CategoryItem category;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      shadowColor: Colors.black26,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      clipBehavior: Clip.antiAlias,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          ColoredBox(
            color: AppColors.darkNavy,
            child: AspectRatio(
              aspectRatio: 1,
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Image.asset(
                  category.imagePath,
                  fit: BoxFit.contain,
                  errorBuilder: (context, error, stackTrace) => Icon(
                    Icons.image_outlined,
                    size: 64,
                    color: Colors.white.withValues(alpha: 0.4),
                  ),
                ),
              ),
            ),
          ),
          ColoredBox(
            color: Colors.white,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 16),
              child: Text(
                category.name,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: AppColors.darkNavy,
                  fontFamily: GoogleFonts.orbitron().fontFamily,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
