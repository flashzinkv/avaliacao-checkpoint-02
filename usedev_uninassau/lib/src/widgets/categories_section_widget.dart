import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:usedev_uninassau/src/models/category_item.dart';
import 'package:usedev_uninassau/src/theme/app_colors.dart';
import 'package:usedev_uninassau/src/theme/responsive.dart';
import 'package:usedev_uninassau/src/widgets/category_card_widget.dart';
import 'package:usedev_uninassau/src/widgets/responsive_page_widget.dart';

class CategoriesSectionWidget extends StatelessWidget {
  const CategoriesSectionWidget({
    this.categories = defaultCategories,
    super.key,
  });

  final List<CategoryItem> categories;

  @override
  Widget build(BuildContext context) {
    final horizontalPadding = Responsive.horizontalPadding(context);
    final titleSize = Responsive.valueForScreen(
      context,
      mobile: 24,
      tablet: 26,
      desktop: 28,
    );

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: horizontalPadding, vertical: 16),
      child: Column(
        spacing: 20,
        children: [
          Text(
            'Categorias',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: titleSize,
              fontWeight: FontWeight.bold,
              color: AppColors.darkNavy,
              fontFamily: GoogleFonts.orbitron().fontFamily,
            ),
          ),
          Text(
            'De roupas a gadgets tecnológicos temos tudo para atender '
            'suas paixões e hobbies com estilo e autenticidade.',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: Responsive.valueForScreen(
                context,
                mobile: 14,
                tablet: 15,
                desktop: 16,
              ),
              height: 1.4,
              color: AppColors.subtitleText,
              fontFamily: GoogleFonts.poppins().fontFamily,
            ),
          ),
          ResponsiveGrid(
            itemCount: categories.length,
            mobileColumns: 1,
            tabletColumns: 2,
            desktopColumns: 4,
            itemBuilder: (context, index) {
              return CategoryCardWidget(category: categories[index]);
            },
          ),
        ],
      ),
    );
  }
}
