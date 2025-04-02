// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sports_trending/source/color_assets.dart';
import 'package:sports_trending/source/styles.dart';
import 'package:sports_trending/utils/screen_util.dart';
import 'package:sports_trending/widgets/custom_input_formatter.dart';

/// Bordered textfiled with floating label
class CustomTextFormField extends StatelessWidget {
  final FormFieldValidator? validator;
  final FocusNode? focusNode;
  final bool autoFocus;
  final TextEditingController controller;
  final bool? enableInteractiveSelection;
  final ValueChanged<String>? onChange;
  final TextInputType? textInputType;
  final Widget? prefix;
  final String? prefixText;
  final String? prefixIcon;
  final int? maxLength;
  final int? maxLines;
  final Function()? suffixOnClick;
  final Function()? prefixOnClick;
  final String? hint;
  TextStyle? hintStyle;
  final TextInputAction? input;
  final bool? obscureText;
  final Size? prefixIconSize;
  final Size? suffixIconSize;
  final BoxConstraints? prefixIconConstraints;
  final BoxConstraints? suffixIconConstraints;
  final Key? key1;
  final Widget? suffix;
  final List<TextInputFormatter>? inputFormatters;
  final TextStyle? style;
  final String? suffixIcon;
  final bool isSuffixText;
  final String suffixText;
  final bool? isEditable;
  final Color? borderColor;
  final Color? prefixIconColor;
  final TextStyle? errorStyle;
  final Function(String)? onTextSubmit;
  final EdgeInsetsGeometry? contentPadding;
  final Color? fillColor;
  final Color? cursorColor;
  final bool? disableFloatingLabel;
  final bool? displayCounter;
  final TextInputAction? textInputAction;
  final String? placeHolder;
  final bool alignLabelWithHint;
  final bool isBorder;
  final bool? readOnly;
  final void Function()? onTap;
  final Widget? Function(
    BuildContext context, {
    required int currentLength,
    required bool isFocused,
    int? maxLength,
  })?
  onBuildCounter;

  CustomTextFormField({
    required this.controller,
    this.key1,
    this.focusNode,
    this.maxLength,
    this.errorStyle,
    this.validator,
    this.hintStyle,
    this.prefixIconColor,
    this.onChange,
    this.prefix,
    this.prefixText,
    this.input,
    this.isEditable,
    this.prefixIcon,
    this.hint,
    this.suffix,
    this.style,
    this.suffixIcon,
    this.inputFormatters,
    this.maxLines = 1,
    this.onTextSubmit,
    this.suffixOnClick,
    this.prefixOnClick,
    this.isSuffixText = false,
    this.placeHolder,
    this.onTap,
    this.suffixText = "",
    this.alignLabelWithHint = false,
    this.isBorder = true,
    BoxConstraints? prefixIconConstraints,
    EdgeInsets? contentPadding,
    BoxConstraints? suffixIconConstraints,
    Size? prefixIconSize,
    Size? suffixIconSize,
    bool? autoFocus,
    bool? obscureText,
    bool? disableFloatingLabel,
    bool? displayCounter,
    Color? cursorColor,
    Color? fillColor,
    Color? borderColor,
    this.enableInteractiveSelection = true,
    this.textInputType = TextInputType.text,
    this.textInputAction,
    this.onBuildCounter,
    this.readOnly,
  }) : cursorColor = cursorColor ?? ColorAssets.themeColorOrange,
       fillColor = fillColor ?? Colors.white,
       borderColor = borderColor ?? Colors.white,
       autoFocus = autoFocus ?? false,
       obscureText = obscureText ?? false,
       disableFloatingLabel = disableFloatingLabel ?? false,
       displayCounter = displayCounter ?? false,
       prefixIconConstraints =
           prefixIconConstraints ??
           const BoxConstraints(
             minWidth: 15,
             minHeight: 25,
             maxWidth: 50,
             maxHeight: 50,
           ),
       contentPadding = contentPadding ?? const EdgeInsets.all(10),
       suffixIconConstraints =
           suffixIconConstraints ??
           const BoxConstraints(
             minWidth: 10,
             minHeight: 25,
             maxWidth: 70,
             maxHeight: 50,
           ),
       prefixIconSize =
           prefixIconSize ?? Size(Constant.size20, Constant.size20),
       suffixIconSize =
           suffixIconSize ?? Size(Constant.size20, Constant.size20),
       super(key: key1);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      key: key1,
      readOnly: readOnly ?? false,
      enableInteractiveSelection: enableInteractiveSelection,
      controller: controller,
      validator: validator,
      keyboardType: textInputType,
      textInputAction: textInputAction ?? TextInputAction.done,
      onChanged: onChange,
      focusNode: focusNode,
      textAlignVertical: TextAlignVertical.center,
      // cursorHeight: 14,
      autofocus: autoFocus,
      onFieldSubmitted:
          (submit) =>
              onTextSubmit != null
                  ? onTextSubmit?.call(submit)
                  : (input == TextInputAction.next
                      ? FocusScope.of(context).nextFocus()
                      : null),
      inputFormatters:
          inputFormatters ??
          ([
            NoLeadingSpaceFormatter(),
            NoLeadingNextLineFormatter(),
            FilteringTextInputFormatter.singleLineFormatter,
            FilteringTextInputFormatter.deny(
              RegExp(
                '\u00a9|\u00ae|[\u2000-\u3300]|\ud83c[\ud000-\udfff]|\ud83d[\ud000-\udfff]|\ud83e[\ud000-\udfff]',
              ),
            ),
            LengthLimitingTextInputFormatter(maxLength),
          ]),
      style: style ?? Styles.textStyleDarkGreyNormal,
      maxLines: maxLines,
      enabled: isEditable,
      cursorColor: cursorColor,
      obscureText: obscureText!,
      onTap: onTap,
      maxLength: (displayCounter ?? false) ? maxLength : null,
      buildCounter: (displayCounter ?? false) ? onBuildCounter : null,

      decoration: InputDecoration(
        border: isBorder ? const UnderlineInputBorder() : InputBorder.none,
        focusedBorder:
            isBorder
                ? OutlineInputBorder(
                  borderSide:  BorderSide(color: borderColor!),
                  borderRadius: BorderRadius.circular(Constant.size8),
                )
                : null,
        enabledBorder:
            isBorder
                ? OutlineInputBorder(
              borderSide:  BorderSide(color: borderColor!),
                  borderRadius: BorderRadius.circular(Constant.size8),
                )
                : null,
        errorBorder:
            isBorder
                ? OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.red, width: 1.0),
                  borderRadius: BorderRadius.circular(Constant.size8),
                )
                : null,

        prefixIconConstraints: prefixIconConstraints,
        prefix: prefix,
        prefixText: prefixText,

        suffixIconConstraints: suffixIconConstraints,
        suffix: suffix,
        errorMaxLines: 3,
        contentPadding: contentPadding,
        fillColor: fillColor,
        filled: true,
        hintMaxLines: 1,
        suffixIcon: GestureDetector(
          onTap: suffixOnClick,
          child: Padding(
            padding: const EdgeInsets.only(right: 14, left: 8),
            child: loadSvg(
              path: suffixIcon ?? "",
              size: suffixIconSize,
              color: prefixIconColor,
            ),
          ),
        ),
        // alignLabelWithHint: alignLabelWithHint,
        hintText: (disableFloatingLabel ?? false) ? placeHolder : null,
        hintStyle: hintStyle,
        labelText: (disableFloatingLabel ?? false) ? null : placeHolder,
      ),
    );
  }
}

Widget loadSvg({
  String path = "",
  Color? color,
  BoxFit fit = BoxFit.contain,
  Size? size,
}) {
  return SvgPicture.asset(
    path,
    height: size?.height,
    width: size?.width,
    color: color,
    fit: fit,
  );
}
