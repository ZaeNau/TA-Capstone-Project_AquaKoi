import 'package:flutter/material.dart';
import '../core/app_export.dart';

class CustomTextFormField extends StatefulWidget {
  const CustomTextFormField({
    super.key,
    this.alignment,
    this.width,
    this.scrollPadding,
    this.controller,
    this.focusNode,
    this.autofocus = true,
    this.textStyle,
    this.obscureText = false,
    this.textInputAction = TextInputAction.next,
    this.textInputType = TextInputType.text,
    this.maxLines,
    this.hintText,
    this.hintStyle,
    this.prefix,
    this.prefixConstraints,
    this.suffix,
    this.suffixConstraints,
    this.contentPadding,
    this.borderDecoration,
    this.fillColor,
    this.filled = true,
    this.validator, required void Function(dynamic _) onFieldSubmitted,
  });

  final Alignment? alignment;
  final double? width;
  final TextEditingController? scrollPadding;
  final TextEditingController? controller;
  final FocusNode? focusNode;
  final bool? autofocus;
  final TextStyle? textStyle;
  final bool? obscureText;
  final TextInputAction? textInputAction;
  final TextInputType? textInputType;
  final int? maxLines;
  final String? hintText;
  final TextStyle? hintStyle;
  final Widget? prefix;
  final BoxConstraints? prefixConstraints;
  final Widget? suffix;
  final BoxConstraints? suffixConstraints;
  final EdgeInsets? contentPadding;
  final InputBorder? borderDecoration;
  final Color? fillColor;
  final bool? filled;
  final FormFieldValidator<String>? validator;

  @override
  _CustomTextFormFieldState createState() => _CustomTextFormFieldState();
}

class _CustomTextFormFieldState extends State<CustomTextFormField> {
  late bool _obscureText;

  @override
  void initState() {
    super.initState();
    _obscureText = widget.obscureText ?? false;
  }

  void _toggleVisibility() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  @override
  Widget build(BuildContext context) {
    return widget.alignment != null
        ? Align(
            alignment: widget.alignment ?? Alignment.center,
            child: textFormFieldWidget(context),
          )
        : textFormFieldWidget(context);
  }

  Widget textFormFieldWidget(BuildContext context) => SizedBox(
        width: widget.width ?? double.maxFinite,
        child: TextFormField(
          scrollPadding:
              EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
          controller: widget.controller,
          focusNode: widget.focusNode ?? FocusNode(),
          autofocus: widget.autofocus!,
          style: widget.textStyle ?? CustomTextStyles.bodyMediumPrimary,
          obscureText: _obscureText,
          textInputAction: widget.textInputAction,
          keyboardType: widget.textInputType,
          maxLines: widget.maxLines ?? 1,
          decoration: decoration,
          validator: widget.validator,
        ),
      );

  InputDecoration get decoration => InputDecoration(
        hintText: widget.hintText ?? "",
        hintStyle: widget.hintStyle ?? CustomTextStyles.bodyMediumPrimary,
        prefixIcon: widget.prefix,
        prefixIconConstraints: widget.prefixConstraints,
        suffixIcon: widget.obscureText!
            ? IconButton(
                icon: Icon(
                  _obscureText ? Icons.visibility : Icons.visibility_off,
                ),
                onPressed: _toggleVisibility,
              )
            : widget.suffix,
        suffixIconConstraints: widget.suffixConstraints,
        isDense: true,
        contentPadding: widget.contentPadding ?? EdgeInsets.all(10.h),
        fillColor: widget.fillColor ?? theme.colorScheme.onSecondaryContainer,
        filled: widget.filled,
        border: widget.borderDecoration ??
            OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.h),
              borderSide: BorderSide(
                color: appTheme.blueGray100,
                width: 1,
              ),
            ),
        enabledBorder: widget.borderDecoration ??
            OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.h),
              borderSide: BorderSide(
                color: appTheme.blueGray100,
                width: 1,
              ),
            ),
        focusedBorder: widget.borderDecoration ??
            OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.h),
              borderSide: BorderSide(
                color: appTheme.blueGray100,
                width: 1,
              ),
            ),
      );
}
