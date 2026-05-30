import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:usedev_uninassau/src/theme/app_colors.dart';

class QuantityCounterWidget extends StatelessWidget {
  const QuantityCounterWidget({
    required this.quantity,
    required this.onChanged,
    super.key,
  });

  final int quantity;
  final ValueChanged<int> onChanged;

  @override
  Widget build(BuildContext context) {
    final isActive = quantity > 1;

    return Row(
      mainAxisSize: MainAxisSize.min,
      spacing: 8,
      children: [
        _CounterButton(
          icon: Icons.remove,
          onPressed: quantity > 1 ? () => onChanged(quantity - 1) : null,
        ),
        Container(
          width: 48,
          height: 40,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            border: Border.all(
              color: isActive ? AppColors.purple : AppColors.darkNavy,
              width: isActive ? 2 : 1,
            ),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Text(
            '$quantity',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              fontFamily: GoogleFonts.poppins().fontFamily,
              color: AppColors.darkNavy,
            ),
          ),
        ),
        _CounterButton(
          icon: Icons.add,
          filled: true,
          onPressed: () => onChanged(quantity + 1),
        ),
      ],
    );
  }
}

class _CounterButton extends StatelessWidget {
  const _CounterButton({
    required this.icon,
    required this.onPressed,
    this.filled = false,
  });

  final IconData icon;
  final VoidCallback? onPressed;
  final bool filled;

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: onPressed,
      style: OutlinedButton.styleFrom(
        shape: const CircleBorder(),
        padding: const EdgeInsets.all(8),
        backgroundColor: filled ? AppColors.purple : Colors.transparent,
        side: BorderSide(
          color: filled ? AppColors.purple : AppColors.darkNavy,
        ),
        minimumSize: const Size(40, 40),
      ),
      child: Icon(
        icon,
        size: 18,
        color: filled ? Colors.white : AppColors.darkNavy,
      ),
    );
  }
}
