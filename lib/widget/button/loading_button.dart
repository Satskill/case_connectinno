import 'package:case_connectinno/core/constant/color.dart';
import 'package:case_connectinno/core/constant/ui.dart';
import 'package:case_connectinno/widget/base/loading.dart';
import 'package:case_connectinno/widget/button/scale_button.dart';
import 'package:flutter/material.dart';

class LoadingButton extends StatefulWidget {
  final Future<void> Function()? onTap;
  final Widget? child;
  final BoxDecoration? decoration;
  final bool waitAnimation;
  final EdgeInsets? padding;
  final bool isSmall;
  const LoadingButton({
    super.key,
    required this.onTap,
    this.child,
    this.decoration,
    this.waitAnimation = true,
    this.padding,
    this.isSmall = false,
  });

  static BoxDecoration get defaultDecoration => AppUI.boxDecoration;

  LoadingButton.update({
    super.key,
    this.onTap,
    this.child,
    this.waitAnimation = true,
    this.padding,
    this.isSmall = false,
  }) : decoration = defaultDecoration.copyWith(color: AppColor.success);

  LoadingButton.create({
    super.key,
    this.onTap,
    this.child,
    this.waitAnimation = true,
    this.padding,
    this.isSmall = false,
  }) : decoration = defaultDecoration.copyWith(color: AppColor.warning);

  LoadingButton.delete({
    super.key,
    this.onTap,
    this.child,
    this.waitAnimation = true,
    this.padding,
    this.isSmall = false,
  }) : decoration = defaultDecoration.copyWith(color: AppColor.error);

  @override
  State<LoadingButton> createState() => _LoadingButtonState();
}

class _LoadingButtonState extends State<LoadingButton> {
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return ScaleButton(
      bordered: false,
      padding: widget.padding,
      waitAnimation: widget.waitAnimation,
      onTap: widget.onTap != null
          ? () async {
              if (!isLoading) {
                if (mounted) {
                  setState(() {
                    isLoading = true;
                  });
                }
                await widget.onTap!();
                isLoading = false;
                if (mounted) {
                  setState(() {});
                }
              }
            }
          : null,
      decoration: widget.decoration ?? LoadingButton.defaultDecoration,
      child: Builder(
        builder: (context) {
          final newChild = AnimatedSwitcher(
            duration: AppUI.animationDuration,
            child: isLoading
                ? const LoadingWidget(
                    key: ValueKey(true),
                    size: 18,
                    color: AppColor.primary,
                  )
                : widget.child,
          );
          if (widget.isSmall) return newChild;
          return Center(child: newChild);
        },
      ),
    );
  }
}
