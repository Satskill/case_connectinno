import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:pasaportsmart/core/util/extension.dart';

import 'loading.dart';

typedef DataWidgetBuilder<T> = Widget Function(BuildContext context, T data);

class AppFutureBuilder<T> extends StatelessWidget {
  final DataWidgetBuilder<T> builder;
  final Future<T> future;
  final Widget? placeHolder;
  final double? loadingSize;
  final Color? loadingColor;
  final String? loadingText;

  const AppFutureBuilder({
    super.key,
    this.placeHolder,
    required this.builder,
    this.loadingSize,
    this.loadingColor,
    required this.future,
    this.loadingText,
  });

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<T>(
      future: future,
      builder: (context, snapshot) {
        Widget child;
        Key key;

        if (snapshot.hasError) {
          if (snapshot.error is DioException) {
            final errorCode =
                (snapshot.error as DioException).response?.statusCode;
            key = ValueKey('error-$errorCode');
            child = Center(
              key: key,
              child: AppErrorWidget(errorCode: errorCode),
            );
          } else {
            key = ValueKey('error-${snapshot.error}');
            child = Center(
              key: key,
              child: AppErrorWidget(text: snapshot.error.toString()),
            );
          }
        } else if (snapshot.connectionState == ConnectionState.waiting) {
          key = const ValueKey('loading');
          child = SizedBox(
            key: key,
            child: placeHolder ??
                Center(
                  child: LoadingWidget(
                      size: loadingSize,
                      color: loadingColor,
                      text: loadingText),
                ),
          );
        } else if (snapshot.hasData && snapshot.data != null) {
          key = ValueKey('child-${snapshot.data.hashCode}');
          child = SizedBox(
            key: key,
            child: builder(context, snapshot.data as T),
          );
        } else {
          key = const ValueKey('unknown');
          child = const UnknownErrorWidget(key: ValueKey('unknown'));
        }

        return AnimatedSwitcher(
          duration: 300.millisecond,
          child: child,
        );
      },
    );
  }
}
