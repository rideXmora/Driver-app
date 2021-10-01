import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:driver_app/theme/colors.dart';

class CustomTextField extends StatelessWidget {
  CustomTextField({
    required this.height,
    required this.width,
    required this.controller,
    this.obscureText = false,
    required this.suffix,
    required this.hintText,
    required this.prefixIcon,
    required this.prefixBoxColor,
    required this.phoneNumberPrefix,
    this.keyboardType = TextInputType.text,
    required this.dropDown,
    this.readOnly = false,
    this.onTap,
    this.phoneNumberPrefixWidth = 38,
    this.onChanged,
    required this.inputFormatters,
    this.onSubmit,
    this.textInputAction = TextInputAction.next,
  });

  final double height;
  final double width;
  final TextEditingController controller;
  final bool obscureText;
  final Widget suffix;
  final String hintText;
  final Widget prefixIcon;
  final Color prefixBoxColor;
  final Widget phoneNumberPrefix;
  final TextInputType keyboardType;
  final Widget dropDown;
  final bool readOnly;
  final onTap;
  final double phoneNumberPrefixWidth;
  final onChanged;
  final List<TextInputFormatter> inputFormatters;
  final onSubmit;
  final TextInputAction textInputAction;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: 54,
      decoration: BoxDecoration(
        color: primaryColor,
        borderRadius: BorderRadius.circular(13),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 3),
        child: TextField(
          onTap: onTap,
          onSubmitted: onSubmit,
          style: TextStyle(
            color: primaryColorWhite,
            fontSize: 20,
            fontWeight: FontWeight.w500,
          ),
          controller: controller,
          obscureText: obscureText,
          textInputAction: textInputAction,
          keyboardType: keyboardType,
          readOnly: readOnly,
          minLines: 1,
          textAlignVertical: TextAlignVertical.center,
          inputFormatters: inputFormatters,
          decoration: InputDecoration(
            border: InputBorder.none,
            hintText: hintText,
            hintStyle: TextStyle(
              color: primaryColorWhite.withOpacity(0.5),
              fontSize: 20,
              fontWeight: FontWeight.w500,
            ),
            prefixIcon: Padding(
              padding: const EdgeInsets.only(right: 10),
              child: Container(
                width: phoneNumberPrefixWidth,
                height: 54,
                child: Row(
                  children: [
                    Container(
                      width: 38,
                      height: 48,
                      decoration: BoxDecoration(
                        color: prefixBoxColor,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: prefixIcon,
                    ),
                    phoneNumberPrefix,
                    dropDown,
                  ],
                ),
              ),
            ),
            prefixIconConstraints: BoxConstraints(
              minWidth: 38,
            ),
            suffixIcon: suffix,
            suffixIconConstraints: BoxConstraints(
              // ignore: unnecessary_null_comparison
              minWidth: suffix == null ? 0 : 38,
            ),
          ),
        ),
      ),
    );
  }
}
