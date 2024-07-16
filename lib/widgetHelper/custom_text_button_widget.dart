import 'package:flutter/material.dart';
import 'package:expense_tracker/helper/app_constant.dart';

class CustomTextButtonWidget extends StatelessWidget {
  final String btnText;
  final VoidCallback? onPressed;
  final Widget? icon;
  final Color? backgroundColor;
  final Color? textColor;
  final double? fontSize;
  final Size? fixedSize;
  final double? borderRadius;
  final double? padding;
  final Color? borderSideColor;

  const CustomTextButtonWidget({
    Key? key,
    required this.btnText,
    this.onPressed,
    this.icon,
    this.backgroundColor,
    this.textColor,
    this.fontSize,
    this.fixedSize,
    this.borderRadius,
    this.padding,
    this.borderSideColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      style: TextButton.styleFrom(
        backgroundColor: backgroundColor ?? MyColor.colorBlue,
        fixedSize: fixedSize ?? const Size(double.maxFinite, 45),
        shape: RoundedRectangleBorder(
            side:
                BorderSide(color: borderSideColor ?? MyColor.colorTransparent),
            borderRadius: BorderRadius.circular(borderRadius ?? 13)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (icon != null) ...[
            icon!,
            const SizedBox(
              width: 10,
            ),
          ],
          Container(
            margin: const EdgeInsets.all(0),
            padding: const EdgeInsets.all(0),
            color: MyColor.colorTransparent,
            child: Text(
              btnText,
              style: TextStyle(
                  color: textColor ?? MyColor.colorTextWhite,
                  fontWeight: FontWeight.w400,
                  fontSize: fontSize ?? FontSize.textSizeNormalReaderView),
            ),
          ),
        ],
      ),
    );
  }
}
