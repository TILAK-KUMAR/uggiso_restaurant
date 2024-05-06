import 'package:flutter/material.dart';

import '../../base/common/utils/colors.dart';
import '../../base/common/utils/fonts.dart';


class TextFieldCurvedEdges extends StatelessWidget {
  final TextEditingController controller;
  final Color backgroundColor;
  final TextInputType keyboardType;
  final Color borderColor;
  final double borderRadius;
  final TextAlign textAlign;
  final int length;
  final int maxLines;
  final FocusNode? focusNode;
  final ValueChanged<String>? onSubmitted;
  final TextInputAction? textInputAction;

  const TextFieldCurvedEdges({
    Key? key,
    required this.controller,
    required this.backgroundColor,
    required this.keyboardType,
    required this.borderColor,
    this.borderRadius = 20.0,
    this.textAlign = TextAlign.start,
    this.length = 100,
    this.maxLines = 1,
    this.focusNode,
    this.onSubmitted,
    this.textInputAction
  }): super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(borderRadius),
        border: Border.all(color:borderColor)
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: TextField(
          style: AppFonts.title.copyWith(color: AppColors.black),
          controller: controller,
          cursorColor: AppColors.black,
          keyboardType: keyboardType,
          textInputAction: textInputAction,
          textAlign: textAlign,
          maxLength: length,
          maxLines: maxLines,
          focusNode: focusNode,
          onSubmitted: onSubmitted,
          decoration: const InputDecoration(
            border: InputBorder.none,
            counterText: ''
          ),
        ),
      ),
    );
  }
}