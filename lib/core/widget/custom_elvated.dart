import 'package:flutter/material.dart';
import 'package:e_commarcae/core/utils/extension.dart';

class CustomElvated extends StatelessWidget {
  const CustomElvated({
    super.key,
    this.buttonTitle,
    required this.action,
    this.textwanted,
    this.child,
    this.isLoading = false,
  });

  final String? buttonTitle;
  final VoidCallback action;
  final bool? textwanted;
  final Widget? child;
  final bool? isLoading;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: context.wp(0.7),
      height: 50,
      child: ElevatedButton(
        onPressed: action,
        style: ElevatedButton.styleFrom(
          elevation: 6,
          backgroundColor: Theme.of(context).colorScheme.primary,
          foregroundColor: Theme.of(context).colorScheme.onPrimary,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        child: isLoading??false
            ? const SizedBox(
                width: 20,
                height: 20,
                child: CircularProgressIndicator(strokeWidth: 2),
              )
            : (textwanted ?? false
                  ? Text(
                      buttonTitle ?? 'default',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: context.responsiveValue(
                          mobile: 18,
                          tablet: 22,
                          desktop: 26,
                        ),
                        fontWeight: FontWeight.bold,
                      ),
                    )
                  : child),
      ),
    );
  }
}
