import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:usedev_uninassau/src/controllers/cart_controller.dart';
import 'package:usedev_uninassau/src/models/product.dart';
import 'package:usedev_uninassau/src/theme/app_colors.dart';
import 'package:usedev_uninassau/src/theme/responsive.dart';
import 'package:usedev_uninassau/src/widgets/accordion_widget.dart';
import 'package:usedev_uninassau/src/widgets/app_top_bar_widget.dart';
import 'package:usedev_uninassau/src/widgets/app_drawer_widget.dart';
import 'package:usedev_uninassau/src/widgets/app_search_bar_widget.dart';
import 'package:usedev_uninassau/src/widgets/app_snackbar.dart';
import 'package:usedev_uninassau/src/widgets/footer_section_widget.dart';
import 'package:usedev_uninassau/src/widgets/pill_dropdown_widget.dart';
import 'package:usedev_uninassau/src/widgets/product_radio_tile.dart';
import 'package:usedev_uninassau/src/widgets/responsive_page_widget.dart';

class ProductDetailScreen extends StatefulWidget {
  const ProductDetailScreen({
    required this.product,
    super.key,
  });

  final Product product;

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  String? _selectedColor;
  String? _selectedSize;
  String? _selectedQuantity;

  Product get product => widget.product;

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
            const AppSearchBarWidget(),
            const ProductBannerWidget(),
            ResponsivePage(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: horizontalPadding,
                      vertical: 8,
                    ),
                    child: Row(
                      children: [
                        IconButton(
                          onPressed: () => Navigator.pop(context),
                          icon: const Icon(Icons.arrow_back, size: 28),
                        ),
                        Text(
                          'Detalhes do Produto',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            fontFamily: GoogleFonts.poppins().fontFamily,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
                    child: Responsive.isWide(context)
                        ? Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            spacing: 32,
                            children: [
                              Expanded(child: _buildProductImage(context)),
                              Expanded(child: _buildProductForm(context)),
                            ],
                          )
                        : Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            spacing: 16,
                            children: [
                              _buildProductImage(context),
                              _buildProductForm(context),
                            ],
                          ),
                  ),
                  const SizedBox(height: 32),
                ],
              ),
            ),
            const FooterSectionWidget(),
          ],
        ),
      ),
    );
  }

  Widget _buildProductImage(BuildContext context) {
    final imageHeight = Responsive.valueForScreen(
      context,
      mobile: 280,
      tablet: 320,
      desktop: 420,
    );

    return Image.asset(
      product.imagePath,
      height: imageHeight,
      fit: BoxFit.contain,
      errorBuilder: (context, error, stackTrace) {
        return Container(
          height: imageHeight,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: AppColors.darkNavy.withValues(alpha: 0.05),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Icon(
            Icons.checkroom_outlined,
            size: 80,
            color: AppColors.purple.withValues(alpha: 0.4),
          ),
        );
      },
    );
  }

  Widget _buildProductForm(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 16,
      children: [
        Row(
          children: [
            Expanded(
              child: Text(
                product.name,
                style: TextStyle(
                  fontSize: Responsive.valueForScreen(
                    context,
                    mobile: 24,
                    tablet: 26,
                    desktop: 28,
                  ),
                  fontWeight: FontWeight.bold,
                  color: AppColors.darkNavy,
                  fontFamily: GoogleFonts.orbitron().fontFamily,
                ),
              ),
            ),
            Icon(Icons.share, color: AppColors.purple, size: 28),
            const SizedBox(width: 12),
            Icon(Icons.favorite_border, color: AppColors.purple, size: 28),
          ],
        ),
        Text(
          product.description,
          style: TextStyle(
            fontSize: 16,
            color: AppColors.darkNavy,
            fontFamily: GoogleFonts.poppins().fontFamily,
          ),
        ),
        Text(
          product.price,
          style: TextStyle(
            fontSize: Responsive.valueForScreen(
              context,
              mobile: 32,
              tablet: 34,
              desktop: 36,
            ),
            fontWeight: FontWeight.bold,
            color: AppColors.darkNavy,
            fontFamily: GoogleFonts.poppins().fontFamily,
          ),
        ),
        Text(
          'Escolha a cor do tecido',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: AppColors.darkNavy,
            fontFamily: GoogleFonts.poppins().fontFamily,
          ),
        ),
        ...product.colors.map(
          (color) => ProductRadioTile(
            label: color,
            selected: _selectedColor == color,
            onTap: () => setState(() => _selectedColor = color),
          ),
        ),
        PillDropdownWidget(
          label: 'Quantidade',
          value: _selectedQuantity,
          items: product.quantities,
          onChanged: (value) {
            setState(() => _selectedQuantity = value);
          },
        ),
        PillDropdownWidget(
          label: 'Tamanho',
          value: _selectedSize,
          items: product.sizes,
          onChanged: (value) {
            setState(() => _selectedSize = value);
          },
        ),
        AccordionWidget(
          title: 'Como cuidar do produto?',
          content:
              'Lave na máquina com água fria, ciclo delicado. '
              'Não use alvejante. Seque à sombra e passe com ferro '
              'em temperatura baixa para preservar a estampa.',
        ),
        SizedBox(
          width: double.infinity,
          child: ElevatedButton.icon(
            onPressed: () {
              if (_selectedColor == null ||
                  _selectedSize == null ||
                  _selectedQuantity == null) {
                AppSnackbar.error(
                  context,
                  'Algo deu errado, tente novamente!',
                );
                return;
              }

              CartScope.of(context).addItem(
                product: product,
                quantity: int.parse(_selectedQuantity!),
                size: _selectedSize!,
              );

              AppSnackbar.success(
                context,
                'Produto adicionado ao carrinho!',
              );
            },
            icon: const Icon(Icons.add_shopping_cart, color: Colors.white),
            label: Text(
              'Adicionar ao carrinho',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.white,
                fontFamily: GoogleFonts.poppins().fontFamily,
              ),
            ),
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.purple,
              padding: const EdgeInsets.symmetric(vertical: 18),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(50),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
