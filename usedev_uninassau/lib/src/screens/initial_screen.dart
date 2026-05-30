import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:usedev_uninassau/src/models/product.dart';
import 'package:usedev_uninassau/src/theme/responsive.dart';
import 'package:usedev_uninassau/src/widgets/app_top_bar_widget.dart';
import 'package:usedev_uninassau/src/widgets/app_drawer_widget.dart';
import 'package:usedev_uninassau/src/widgets/categories_section_widget.dart';
import 'package:usedev_uninassau/src/widgets/hero_section_widget.dart';
import 'package:usedev_uninassau/src/widgets/product_card_widget.dart';
import 'package:usedev_uninassau/src/widgets/footer_section_widget.dart';
import 'package:usedev_uninassau/src/widgets/responsive_page_widget.dart';
import 'package:usedev_uninassau/src/widgets/subscription_section_widget.dart';

class InitialScreen extends StatefulWidget {
  const InitialScreen({super.key});

  @override
  State<InitialScreen> createState() => _InitialScreenState();
}

class _InitialScreenState extends State<InitialScreen> {
  @override
  Widget build(BuildContext context) {
    final horizontalPadding = Responsive.horizontalPadding(context);

    return Scaffold(
      appBar: const AppTopBarWidget(),
      drawer: const AppDrawerWidget(),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const HeroSectionWidget(),
            ResponsivePage(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const CategoriesSectionWidget(),
                  Padding(
                    padding: EdgeInsets.fromLTRB(
                      horizontalPadding,
                      20,
                      horizontalPadding,
                      0,
                    ),
                    child: Text(
                      'Promos Especiais',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: Responsive.valueForScreen(
                          context,
                          mobile: 24,
                          tablet: 26,
                          desktop: 28,
                        ),
                        fontWeight: FontWeight.bold,
                        fontFamily: GoogleFonts.orbitron().fontFamily,
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(horizontalPadding),
                    child: ResponsiveGrid(
                      itemCount: productCatalog.length,
                      mobileColumns: 1,
                      tabletColumns: 2,
                      desktopColumns: 3,
                      itemBuilder: (context, index) {
                        return ProductCardWidget(product: productCatalog[index]);
                      },
                    ),
                  ),
                ],
              ),
            ),
            const SubscriptionSectionWidget(),
            const FooterSectionWidget(),
          ],
        ),
      ),
    );
  }
}
