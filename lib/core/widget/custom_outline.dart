import 'package:e_commarcae/core/utils/extension.dart';
import 'package:flutter/material.dart';

class CustomOutline extends StatelessWidget {
  const CustomOutline({super.key, required this.action, required this.title_btn});
  final VoidCallback action;
  final String title_btn;
  @override
  Widget build(BuildContext context) {
    return OutlinedButton(onPressed: action, child: Text(title_btn,style: TextStyle(
          fontSize: context.responsiveValue(
            mobile: 18,
            tablet: 22,
            desktop: 26,
          ),
        ),));
  }
}
