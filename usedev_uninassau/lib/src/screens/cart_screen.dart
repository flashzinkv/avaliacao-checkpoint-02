import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:usedev_uninassau/src/controllers/cart_controller.dart';
import 'package:usedev_uninassau/src/theme/app_colors.dart';
import 'package:usedev_uninassau/src/theme/responsive.dart';
import 'package:usedev_uninassau/src/widgets/app_drawer_widget.dart';
import 'package:usedev_uninassau/src/widgets/app_search_bar_widget.dart';
import 'package:usedev_uninassau/src/widgets/app_top_bar_widget.dart';
import 'package:usedev_uninassau/src/widgets/cart_item_widget.dart';
import 'package:usedev_uninassau/src/widgets/cart_summary_widget.dart';
import 'package:usedev_uninassau/src/widgets/footer_section_widget.dart';
import 'package:usedev_uninassau/src/widgets/responsive_page_widget.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final cart = CartScope.of(context);
    final horizontalPadding = Responsive.horizontalPadding(context);

    return Scaffold(
      appBar: const AppTopBarWidget(enableCartNavigation: false),
      drawer: const AppDrawerWidget(),
      body: AnimatedBuilder(
        animation: cart,
        builder: (context, _) {
          return SingleChildScrollView(
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
                              'Carrinho de Compras',
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
                        child: Container(
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: const Color(0xFFDCEEFF),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            spacing: 12,
                            children: [
                              Icon(Icons.info_outline, color: Colors.blue.shade700),
                              Expanded(
                                child: Text(
                                  'Atenção, os produtos no carrinho não ficam reservados. '
                                  'Finalize a compra para garantir! :)',
                                  style: TextStyle(
                                    fontFamily: GoogleFonts.poppins().fontFamily,
                                    color: AppColors.darkNavy,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(horizontalPadding),
                        child: Responsive.isDesktop(context)
                            ? Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                spacing: 24,
                                children: [
                                  Expanded(flex: 3, child: _buildCartItems(cart)),
                                  Expanded(flex: 2, child: _buildSummary(context, cart)),
                                ],
                              )
                            : Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                spacing: 24,
                                children: [
                                  _buildCartItems(cart),
                                  _buildSummary(context, cart),
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
          );
        },
      ),
    );
  }

  Widget _buildCartItems(CartController cart) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      decoration: BoxDecoration(
        color: const Color(0xFFF0F0F0),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 20, bottom: 8),
            child: Text(
              'Detalhes da compra',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                fontFamily: GoogleFonts.orbitron().fontFamily,
                color: AppColors.darkNavy,
              ),
            ),
          ),
          if (cart.isEmpty)
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 32),
              child: Center(
                child: Text(
                  'Seu carrinho está vazio.\nAdicione produtos para continuar.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontFamily: GoogleFonts.poppins().fontFamily,
                    color: AppColors.subtitleText,
                  ),
                ),
              ),
            )
          else
            for (var index = 0; index < cart.items.length; index++) ...[
              CartItemWidget(
                item: cart.items[index],
                onQuantityChanged: (quantity) {
                  cart.updateQuantity(index, quantity);
                },
                onSizeChanged: (size) {
                  cart.updateSize(index, size);
                },
                onRemove: () => cart.removeAt(index),
              ),
              if (index < cart.items.length - 1)
                const Divider(color: Color(0xFFCCCCCC)),
            ],
        ],
      ),
    );
  }

  Widget _buildSummary(BuildContext context, CartController cart) {
    return CartSummaryWidget(
      totalProducts: cart.totalProducts,
      subtotal: cart.subtotal,
      shipping: cart.shipping,
      total: cart.total,
      isEmpty: cart.isEmpty,
    );
  }
}
