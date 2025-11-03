import 'package:case_connectinno/core/constant/app_text_style.dart';
import 'package:case_connectinno/core/constant/color.dart';
import 'package:case_connectinno/core/constant/ui.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:lottie/lottie.dart';

enum AlertType { warn, info, approved, denied, onTheWay }

/// Basit Alert Dialog
///
/// Sağ button reddetmedir ve her zaman `false`, sol button ise onaylamadır ve her zaman `true` döndürür.
/// Eğer [isSingleButton] true ise tek olan buton `true` döndürür
class AppAlertDialog extends StatelessWidget {
  final String? text;
  final Widget? htmlText;
  final String? title;
  final String? leftButtonText;
  final String? rightButtonText;
  final Color? leftTextColor;
  final Color? rightTextColor;
  final Color? bottomTextColor;
  final bool isSingleButton;
  final AlertType? type;
  final Widget? customIcon;
  final void Function()? leftFunction;
  final void Function()? rightFunction;
  final void Function()? bottomFunction;
  final bool? isThirdButtonActive;
  final String? thirdButtonText;
  final Widget? child;
  const AppAlertDialog({
    super.key,
    this.text,
    this.htmlText,
    this.title,
    this.leftButtonText,
    this.rightButtonText,
    this.leftTextColor,
    this.rightTextColor = AppColor.primary,
    this.isSingleButton = false,
    this.type,
    this.customIcon,
    this.leftFunction,
    this.rightFunction,
    this.isThirdButtonActive,
    this.bottomFunction,
    this.thirdButtonText,
    this.bottomTextColor,
    this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: AppColor.white,
      surfaceTintColor: AppColor.white,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(AppUI.paddingValue),
            child:
                child ??
                Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(title ?? "Uyarı!", style: AppTextStyle.bigButtonText),
                    type != null ? AppUI.verticalGap() : AppUI.zeroGap,
                    SizedBox(
                      height: (customIcon != null || type != null) ? 160 : 0,
                      child: buildImage(type, customIcon),
                    ),
                    AppUI.verticalGap(),
                    text == null
                        ? AppUI.zeroGap
                        : ConstrainedBox(
                            constraints: const BoxConstraints(maxHeight: 300),
                            child: SingleChildScrollView(
                              child: Text(
                                text!,
                                textAlign: TextAlign.center,
                                style: AppTextStyle.contentText,
                              ),
                            ),
                          ),
                    text == null ? AppUI.zeroGap : AppUI.verticalGap(),
                    htmlText == null
                        ? AppUI.zeroGap
                        : ConstrainedBox(
                            constraints: const BoxConstraints(maxHeight: 300),
                            child: SingleChildScrollView(child: htmlText),
                          ),
                    htmlText == null ? AppUI.zeroGap : AppUI.verticalGap(),
                  ],
                ),
          ),
          const Divider(height: 0),
          SizedBox(
            height: 48,
            child: Row(
              children: [
                Expanded(
                  child: InkWell(
                    highlightColor: leftTextColor?.withValues(alpha: 0.1),
                    splashColor: leftTextColor?.withValues(alpha: 0.3),
                    onTap: () {
                      if (leftFunction != null) {
                        leftFunction!();
                        Navigator.of(context).pop(true);
                      } else {
                        Navigator.of(context).pop(true);
                      }
                    },
                    borderRadius: BorderRadius.only(
                      bottomLeft: AppUI.radius,
                      bottomRight: isSingleButton ? AppUI.radius : Radius.zero,
                    ),
                    child: Ink(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                          bottomLeft: AppUI.radius,
                          bottomRight: isSingleButton
                              ? AppUI.radius
                              : Radius.zero,
                        ),
                      ),
                      child: Center(
                        child: Text(
                          leftButtonText ?? "Onayla",
                          style: AppTextStyle.smallButtonText,
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  ),
                ),
                isSingleButton
                    ? AppUI.zeroGap
                    : const VerticalDivider(width: 0),
                isSingleButton
                    ? AppUI.zeroGap
                    : Expanded(
                        child: InkWell(
                          splashColor: rightTextColor?.withValues(alpha: 0.3),
                          highlightColor: rightTextColor?.withValues(
                            alpha: 0.1,
                          ),
                          onTap: () {
                            if (rightFunction != null) {
                              rightFunction!();
                              Navigator.of(context).pop(false);
                            } else {
                              Navigator.of(context).pop(false);
                            }
                          },
                          borderRadius: BorderRadius.only(
                            bottomRight: AppUI.radius,
                          ),
                          child: Ink(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.only(
                                bottomRight: AppUI.radius,
                              ),
                            ),
                            child: Center(
                              child: Text(
                                rightButtonText ?? "İptal",
                                style: AppTextStyle.smallButtonText.copyWith(
                                  color: rightTextColor,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
              ],
            ),
          ),
          Visibility(
            visible: isThirdButtonActive ?? false,
            child: Container(
              height: 48,
              decoration: const BoxDecoration(
                border: Border(top: BorderSide(color: AppColor.black)),
              ),
              child: InkWell(
                splashColor: bottomTextColor?.withValues(alpha: 0.3),
                highlightColor: bottomTextColor?.withValues(alpha: 0.1),
                onTap: () {
                  context.pop();
                  if (isThirdButtonActive != null && isThirdButtonActive!) {
                    bottomFunction!();
                  }
                },
                borderRadius: BorderRadius.only(bottomRight: AppUI.radius),
                child: Ink(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(bottomRight: AppUI.radius),
                  ),
                  child: Center(
                    child: Text(
                      thirdButtonText ?? "İptal",
                      style: AppTextStyle.smallButtonText.copyWith(
                        color: bottomTextColor,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildImage(AlertType? type, Widget? widget) {
    if (widget != null) {
      return widget;
    } else {
      if (type == AlertType.approved) {
        return Lottie.asset('assets/lottie/check.json', repeat: false);
      } else if (type == AlertType.info) {
        return Lottie.asset('assets/lottie/info.json', repeat: false);
      } else if (type == AlertType.denied) {
        return Lottie.asset('assets/lottie/cancel.json', repeat: false);
      } else if (type == AlertType.onTheWay) {
        return Lottie.asset('assets/lottie/courier.json', repeat: false);
      } else if (type == AlertType.warn) {
        return Lottie.asset('assets/lottie/warning.json', repeat: false);
      } else {
        return AppUI.zeroGap;
      }
    }
  }
}
