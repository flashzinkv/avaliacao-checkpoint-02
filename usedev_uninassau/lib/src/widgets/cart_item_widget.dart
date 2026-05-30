import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:usedev_uninassau/src/models/cart_item.dart';
import 'package:usedev_uninassau/src/theme/app_colors.dart';
import 'package:usedev_uninassau/src/widgets/pill_dropdown_widget.dart';
import 'package:usedev_uninassau/src/widgets/quantity_counter_widget.dart';

class CartItemWidget extends StatelessWidget {
  const CartItemWidget({
    required this.item,
    required this.onQuantityChanged,
    required this.onSizeChanged,
    required this.onRemove,
    super.key,
  });

  final CartItemModel item;
  final ValueChanged<int> onQuantityChanged;
  final ValueChanged<String> onSizeChanged;
  final VoidCallback onRemove;

  @override
  Widget build(BuildContext context) {
    final textStyle = TextStyle(
      fontFamily: GoogleFonts.poppins().fontFamily,
      color: AppColors.darkNavy,
    );

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16),
      child: Column(
        spacing: 16,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: 16,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.asset(
                  item.product.imagePath,
                  width: 100,
                  height: 100,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      width: 100,
                      height: 100,
                      color: AppColors.darkNavy.withValues(alpha: 0.08),
                      child: Icon(
                        Icons.checkroom_outlined,
                        color: AppColors.purple.withValues(alpha: 0.5),
                      ),
                    );
                  },
                ),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: 4,
                  children: [
                    Text(
                      item.product.name,
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        fontFamily: GoogleFonts.orbitron().fontFamily,
                        color: AppColors.darkNavy,
                      ),
                    ),
                    Text(item.product.description, style: textStyle),
                    Text(
                      item.formattedPrice,
                      style: textStyle.copyWith(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          Row(
            children: [
              Text('Quantidade:', style: textStyle.copyWith(fontWeight: FontWeight.bold)),
              const Spacer(),
              QuantityCounterWidget(
                quantity: item.quantity,
                onChanged: onQuantityChanged,
              ),
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: 8,
            children: [
              Text('Tamanho:', style: textStyle.copyWith(fontWeight: FontWeight.bold)),
              PillDropdownWidget(
                label: 'Tamanho',
                value: item.size,
                items: item.product.sizes,
                onChanged: (value) {
                  if (value != null) onSizeChanged(value);
                },
              ),
            ],
          ),
          Column(
            spacing: 4,
            children: [
              Text(
                'Excluir',
                style: textStyle.copyWith(fontWeight: FontWeight.bold),
              ),
              IconButton(
                onPressed: onRemove,
                icon: const Icon(Icons.delete_outline, size: 28),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
