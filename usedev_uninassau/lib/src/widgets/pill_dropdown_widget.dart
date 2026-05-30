import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:usedev_uninassau/src/theme/app_colors.dart';

class PillDropdownWidget extends StatelessWidget {
  const PillDropdownWidget({
    required this.label,
    required this.value,
    required this.items,
    required this.onChanged,
    super.key,
  });

  final String label;
  final String? value;
  final List<String> items;
  final ValueChanged<String?> onChanged;

  @override
  Widget build(BuildContext context) {
    final hasValue = value != null;

    final hintStyle = TextStyle(
      fontSize: 16,
      color: AppColors.subtitleText,
      fontFamily: GoogleFonts.poppins().fontFamily,
    );

    final selectedStyle = TextStyle(
      fontSize: 16,
      color: AppColors.purple,
      fontWeight: FontWeight.w600,
      fontFamily: GoogleFonts.poppins().fontFamily,
    );

    final itemStyle = TextStyle(
      fontSize: 16,
      color: AppColors.darkNavy,
      fontFamily: GoogleFonts.poppins().fontFamily,
    );

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 4),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(50),
        border: Border.all(
          color: hasValue ? AppColors.purple : const Color(0xFFDDDDDD),
          width: hasValue ? 2 : 1,
        ),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          isExpanded: true,
          value: value,
          hint: Text(label, style: hintStyle),
          icon: Icon(
            Icons.keyboard_arrow_down,
            color: hasValue ? AppColors.purple : AppColors.darkNavy,
          ),
          dropdownColor: Colors.white,
          borderRadius: BorderRadius.circular(16),
          menuMaxHeight: 240,
          alignment: AlignmentDirectional.centerStart,
          style: selectedStyle,
          items: items
              .map(
                (item) => DropdownMenuItem<String>(
                  value: item,
                  alignment: AlignmentDirectional.centerStart,
                  child: Text(item, style: itemStyle),
                ),
              )
              .toList(),
          onChanged: onChanged,
        ),
      ),
    );
  }
}
