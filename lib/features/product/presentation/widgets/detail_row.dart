import 'package:flutter/material.dart';
import 'package:pixelfield_test/constants/export.dart';

class DetailRow extends StatelessWidget {
  const DetailRow({
    super.key,
    required this.label,
    required this.value,
    this.isLast = false,
  });

  final String label;
  final String value;
  final bool isLast;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12),
      decoration: BoxDecoration(
        border: isLast
            ? null
            : const Border(
                bottom: BorderSide(
                  color: AppColors.greyscaleBlack1,
                ),
              ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: context.bodyLarge.copyWith(
              color: AppColors.white,
            ),
          ),
          Text(
            value,
            style: context.bodyLarge.copyWith(
              color: AppColors.greyscaleGrey2,
            ),
          ),
        ],
      ),
    );
  }
}
