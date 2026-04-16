import 'package:e_commarcae/core/utils/extension.dart';
import 'package:flutter/material.dart';

class CardBC extends StatelessWidget {
  const CardBC({super.key, required this.img, required this.title});
  final String img;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: context.wp(.4),
      height: context.responsiveValue(mobile: 40, tablet: 60, desktop: 90),
      margin: EdgeInsets.only(top: 3, left: 5, right: 5),
      child: Column(
        children: [
          Card(
            elevation: 4,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            child: Image.network(img, fit: BoxFit.contain),
          ),
          Text(title),
        ],
      ),
    );
  }
}
