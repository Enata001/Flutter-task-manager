import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CTextField extends StatelessWidget {
  final String hintText;
  final TextEditingController? controller;
  final TextInputType textInputType;
  final bool isPassword;
  final IconData? icon;
  final VoidCallback? action;
  final String? Function(String?)? validator;
  final String? initialValue;
  final bool? expands;
  final bool? filled;
  final Color? fillColor;
  final TextCapitalization? textCapitalization;
  final Function(String?)? onChanged;
  final FocusNode? focusNode;
  final TextInputAction? inputAction;
  final Function(String?)? onSubmitted;

  const CTextField({
    super.key,
    this.controller,
    required this.hintText,
    required this.textInputType,
    this.isPassword = false,
    this.icon,
    this.action,
    this.validator,
    this.initialValue,
    this.expands,
    this.filled,
    this.fillColor,
    this.onChanged,
    this.textCapitalization,
    this.focusNode,
    this.onSubmitted,
    this.inputAction,
  });

  @override
  Widget build(BuildContext context) {
    final inputBorder = OutlineInputBorder(
      borderSide: Divider.createBorderSide(
        context,
        color: Theme.of(context).colorScheme.secondary,
      ),
      borderRadius: BorderRadius.circular(
        10,
      ),
    );
    return Container(
      margin: const EdgeInsets.only(
        top: 25,
      ),
      child: TextFormField(
        initialValue: initialValue,
        style: GoogleFonts.lato(
          fontSize: 16,
          color: Theme.of(context).colorScheme.scrim,
        ),
        expands: expands ?? false,
        controller: controller,
        onTapOutside: (_) => FocusScope.of(context).unfocus(),
        textInputAction: inputAction,

        onFieldSubmitted: onSubmitted,
        onChanged: onChanged,
        textCapitalization: textCapitalization ?? TextCapitalization.none,
        decoration: InputDecoration(
          fillColor: fillColor,
          filled: filled,
          suffixIcon: icon != null
              ? IconButton(
                  onPressed: action,
                  icon: Icon(
                    icon,
                    color: Theme.of(context).colorScheme.secondary,
                  ),
                )
              : null,
          labelText: hintText,
          alignLabelWithHint: true,
          border: inputBorder,
          focusedBorder: inputBorder,
          enabledBorder: inputBorder,
          contentPadding: const EdgeInsets.all(
            10,
          ),
        ),
        obscureText: isPassword,
        keyboardType: textInputType,
        validator: validator,
      ),
    );
  }
}
