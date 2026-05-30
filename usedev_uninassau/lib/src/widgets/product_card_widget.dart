import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:usedev_uninassau/src/models/product.dart';
import 'package:usedev_uninassau/src/screens/product_detail_screen.dart';
import 'package:usedev_uninassau/src/theme/responsive.dart';

class ProductCardWidget extends StatelessWidget {
  const ProductCardWidget({
    required this.product,
    super.key,
  });

  final Product product;

  @override
  Widget build(BuildContext context) {
    final titleSize = Responsive.valueForScreen(
      context,
      mobile: 20,
      tablet: 22,
      desktop: 25,
    );

    return Card(
      margin: EdgeInsets.zero,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      elevation: 5,
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute<void>(
              builder: (context) => ProductDetailScreen(product: product),
            ),
          );
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _ProductCardImage(imagePath: product.imagePath),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
              child: Text(
                product.name,
                style: TextStyle(
                  fontSize: titleSize,
                  fontWeight: FontWeight.bold,
                  fontFamily: GoogleFonts.orbitron().fontFamily,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(15, 0, 15, 12),
              child: Text(
                product.price,
                style: TextStyle(
                  fontSize: Responsive.valueForScreen(
                    context,
                    mobile: 24,
                    tablet: 28,
                    desktop: 31,
                  ),
                  fontFamily: GoogleFonts.poppins().fontFamily,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ProductCardImage extends StatelessWidget {
  const _ProductCardImage({required this.imagePath});

  final String imagePath;

  @override
  Widget build(BuildContext context) {
    final imageHeight = Responsive.valueForScreen(
      context,
      mobile: 200,
      tablet: 220,
      desktop: 240,
    );

    if (imagePath.startsWith('http')) {
      return Image.network(
        imagePath,
        height: imageHeight,
        width: double.infinity,
        fit: BoxFit.cover,
      );
    }

    return Image.asset(
      imagePath,
      height: imageHeight,
      width: double.infinity,
      fit: BoxFit.cover,
      errorBuilder: (context, error, stackTrace) {
        return Container(
          height: imageHeight,
          color: Colors.grey.shade200,
          alignment: Alignment.center,
          child: const Icon(Icons.image_not_supported_outlined, size: 48),
        );
      },
    );
  }
}
