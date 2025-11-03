import 'package:case_connectinno/core/constant/app_text_style.dart';
import 'package:case_connectinno/core/constant/color.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppFormField extends StatefulWidget {
  final TextEditingController? controller;
  final String? hintText;
  final TextInputAction? textInputAction;
  final void Function()? onTap;
  final FocusNode? focusNode;
  final bool obscureText;
  final List<TextInputFormatter>? inputFormatters;
  final TextInputType? keyboardType;
  final String? Function(String? value)? validator;
  final bool isBigField;
  final bool readOnly;
  final bool enabled;
  final String? helperText;
  final Widget? prefixIcon;
  final ValueChanged<String>? onChanged;
  final ValueChanged<String>? onFieldSubmitted;
  final InputBorder? border;
  final InputBorder? selectedBorder;
  final Iterable<String>? autofillHints;
  final TextCapitalization textCapitalization;
  final EdgeInsets? padding;
  const AppFormField({
    super.key,
    this.controller,
    this.hintText,
    this.textInputAction,
    this.onTap,
    this.obscureText = false,
    this.inputFormatters,
    this.keyboardType,
    this.validator,
    this.isBigField = false,
    this.readOnly = false,
    this.enabled = true,
    this.helperText,
    this.prefixIcon,
    this.onChanged,
    this.border,
    this.selectedBorder,
    this.autofillHints,
    this.onFieldSubmitted,
    this.focusNode,
    this.textCapitalization = TextCapitalization.none,
    this.padding,
  });

  @override
  State<AppFormField> createState() => _AppFormFieldState();
}

class _AppFormFieldState extends State<AppFormField> {
  late bool isVisible;

  @override
  void initState() {
    isVisible = !widget.obscureText;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      focusNode: widget.focusNode,
      autofillHints: widget.autofillHints,
      controller: widget.controller,
      textInputAction: widget.textInputAction,
      onTap: widget.onTap,
      onChanged: widget.onChanged,
      readOnly: widget.readOnly,
      obscureText: !isVisible,
      inputFormatters: widget.inputFormatters,
      keyboardType: widget.keyboardType,
      validator: widget.validator,
      enabled: widget.enabled,
      autocorrect: true,
      enableIMEPersonalizedLearning: true,
      enableSuggestions: true,
      style: AppTextStyle.fieldText,
      onFieldSubmitted: widget.onFieldSubmitted,
      textCapitalization: widget.textCapitalization,
      onTapOutside: (event) {
        FocusManager.instance.primaryFocus?.unfocus();
      },
      textAlignVertical: TextAlignVertical.center,
      textAlign: TextAlign.start,
      maxLines: widget.isBigField ? 6 : 1,
      cursorColor: AppColor.primary,
      decoration: InputDecoration(
        border:
            widget.border ??
            OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.r),
              borderSide: const BorderSide(
                color: AppColor.boldBorderColor,
                width: 1,
              ),
            ),
        enabledBorder:
            widget.border ??
            OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.r),
              borderSide: const BorderSide(
                color: AppColor.boldBorderColor,
                width: 1,
              ),
            ),
        focusedBorder:
            widget.selectedBorder ??
            OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.r),
              borderSide: const BorderSide(
                color: AppColor.boldBorderColor,
                width: 1,
              ),
            ),
        prefixIcon: widget.prefixIcon,
        contentPadding:
            widget.padding ??
            EdgeInsets.symmetric(
              horizontal: 12,
              vertical: widget.isBigField ? 12 : 0,
            ).r,
        hintText: widget.hintText,
        helperText: widget.helperText,
        suffixIcon: widget.obscureText
            ? IconButton(
                onPressed: () {
                  setState(() {
                    isVisible = !isVisible;
                  });
                },
                icon: Icon(
                  !isVisible
                      ? Icons.visibility_off_outlined
                      : Icons.visibility_outlined,
                ),
              )
            : null,
        suffixIconColor: AppColor.primary,
      ),
    );
  }
}
