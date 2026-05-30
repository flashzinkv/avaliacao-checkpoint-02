import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:usedev_uninassau/src/models/cart_item.dart';
import 'package:usedev_uninassau/src/theme/app_colors.dart';

class CartSummaryWidget extends StatelessWidget {
  const CartSummaryWidget({
    required this.totalProducts,
    required this.subtotal,
    required this.shipping,
    required this.total,
    required this.isEmpty,
    super.key,
  });

  final int totalProducts;
  final double subtotal;
  final double shipping;
  final double total;
  final bool isEmpty;

  @override
  Widget build(BuildContext context) {
    final textStyle = TextStyle(
      fontFamily: GoogleFonts.poppins().fontFamily,
      color: AppColors.darkNavy,
    );

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color(0xFFF0F0F0),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: 20,
        children: [
          Text(
            'Sumário',
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              fontFamily: GoogleFonts.orbitron().fontFamily,
              color: AppColors.darkNavy,
            ),
          ),
          _InputWithButton(label: 'Cupom de desconto', hint: 'Digite o cupom'),
          _InputWithButton(label: 'Frete', hint: 'Digite o CEP'),
          _SummaryRow(
            label: totalProducts == 1 ? '01 Produto' : '${totalProducts.toString().padLeft(2, '0')} Produtos',
            value: formatCurrency(subtotal),
          ),
          _SummaryRow(label: 'Frete', value: formatCurrency(shipping)),
          Row(
            children: [
              Icon(Icons.shopping_bag_outlined, color: AppColors.purple),
              const SizedBox(width: 8),
              Text(
                'Total:',
                style: textStyle.copyWith(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Spacer(),
              Text(
                formatCurrency(total),
                style: textStyle.copyWith(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: AppColors.purple,
                ),
              ),
            ],
          ),
          OutlinedButton(
            onPressed: () => Navigator.pop(context),
            style: OutlinedButton.styleFrom(
              foregroundColor: AppColors.darkNavy,
              side: const BorderSide(color: AppColors.purple, width: 2),
              padding: const EdgeInsets.symmetric(vertical: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(50),
              ),
            ),
            child: SizedBox(
              width: double.infinity,
              child: Text(
                'Continuar comprando',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  fontFamily: GoogleFonts.poppins().fontFamily,
                ),
              ),
            ),
          ),
          ElevatedButton(
            onPressed: isEmpty ? null : () {},
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.purple,
              padding: const EdgeInsets.symmetric(vertical: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(50),
              ),
            ),
            child: SizedBox(
              width: double.infinity,
              child: Text(
                'Ir para pagamento',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  fontFamily: GoogleFonts.poppins().fontFamily,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _InputWithButton extends StatelessWidget {
  const _InputWithButton({
    required this.label,
    required this.hint,
  });

  final String label;
  final String hint;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 8,
      children: [
        Text(
          label,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontFamily: GoogleFonts.poppins().fontFamily,
            color: AppColors.darkNavy,
          ),
        ),
        Row(
          spacing: 12,
          children: [
            Expanded(
              child: TextField(
                decoration: InputDecoration(
                  hintText: hint,
                  filled: true,
                  fillColor: Colors.white,
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 14,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(50),
                    borderSide: const BorderSide(color: Color(0xFFDDDDDD)),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(50),
                    borderSide: const BorderSide(color: Color(0xFFDDDDDD)),
                  ),
                ),
              ),
            ),
            ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.purple,
                padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(50),
                ),
              ),
              child: Text(
                'Ok',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontFamily: GoogleFonts.poppins().fontFamily,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class _SummaryRow extends StatelessWidget {
  const _SummaryRow({
    required this.label,
    required this.value,
  });

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          label,
          style: TextStyle(
            fontFamily: GoogleFonts.poppins().fontFamily,
            color: AppColors.darkNavy,
          ),
        ),
        const Spacer(),
        Text(
          value,
          style: TextStyle(
            fontFamily: GoogleFonts.poppins().fontFamily,
            color: AppColors.darkNavy,
          ),
        ),
      ],
    );
  }
}
