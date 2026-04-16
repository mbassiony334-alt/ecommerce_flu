import 'package:flutter/material.dart';

class Inputcustombutton extends StatelessWidget {
  const Inputcustombutton({
    super.key,
    required this.labelText,
    required this.controller,
    required this.prefixIcon,
    required this.hint,
    required this.validator,
    required this.keyboardType,
    this.obscureText,
  });

  final IconData prefixIcon;
  final TextInputType keyboardType;
  final String labelText;
  final bool? obscureText;
  final String hint;
  final String? Function(String?)? validator;
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: TextFormField(
        controller: controller,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        obscureText: obscureText ?? false,
        keyboardType: keyboardType,
        decoration: InputDecoration(
          labelText: labelText,
          hintText: hint,
          prefixIcon: Icon(
            prefixIcon,
            color: Theme.of(context).colorScheme.primary,
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(color: Colors.grey),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(
              color: Theme.of(context).colorScheme.primary,
              width: 2,
            ),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(color: Colors.red),
          ),
        ),
        validator:validator,
      ),
    );
  }
}
