import 'package:charify_front/core/theme/app_colors.dart';
import 'package:flutter/material.dart';

class DefaultTextField extends StatelessWidget {
  final String? hintText;
  final String? prefixText;
  final String? initialValue;
  final TextInputType? keyboardType;
  final Function(String)? onChanged;
  final Widget? prefixIcon;

  const DefaultTextField({super.key, this.hintText, this.initialValue,this.keyboardType,this.prefixText,this.onChanged, this.prefixIcon});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      style: Theme.of(context).textTheme.bodyMedium,
      onChanged: onChanged,
      initialValue: initialValue,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        filled: true,
        fillColor: AppColors.onSurface,
        hintText: hintText,
        prefixText: prefixText,
        hintStyle: Theme.of(context).textTheme.bodyMedium?.copyWith(
          color: AppColors.text.withOpacity(0.7),
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: BorderSide.none,
        ),
        prefixIcon: prefixIcon
      ),
    );
  }
}
