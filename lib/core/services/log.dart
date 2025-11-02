import 'dart:convert';
import 'dart:developer' as dev;

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:pasaportsmart/core/util/extension.dart';

class LogService {
  LogService._();

  static const bool _logActive = kDebugMode;
  static const bool _logResponse = false;

  static void logLn(String? str, {Object? error, ConsoleColor color = ConsoleColor.yellow}) {
    final leading = '\x1B[${color.foreground}${color.background}m';
    const trailing = '\x1B[0m';
    if (_logActive) {
      dev.log('$leading$str$trailing', error: error);
    }
  }

  static void logResponse({
    required String name,
    FormData? formData,
    required dynamic data,
    required Uri uri,
    required String method,
    Map<String, dynamic>? postParams,
    Object? error,
    ConsoleColor color = ConsoleColor.white,
  }) {
    final str = """
[REQUEST]
[$method]
Name: $name(${postParams != null ? postParams.fieldString : ''})
Uri: $uri
FormData: ${formData?.multiline}
${'-'.multiple(20, 2)}

[RESPONSE]
Data Type: ${data.runtimeType} ${data is List ? "Count: ${data.length}" : ""}
$data
--
""";
    if (!_logResponse) return;
    logLn(str, color: color, error: error);
  }

  static void logData({required String name, Map? map, String? json}) {
    final str = """
$name
${map != null ? jsonEncode(map) : ''}

${'-'.multiple(20, 2)}

${json ?? ''}
--
""";
    logLn(str);
  }

  static void logError({required String name, FormData? formData, Object? error, ConsoleColor color = ConsoleColor.whiteRed}) {
    logLn('$name(${formData?.multiline}) [ERROR]:\n\n${error.runtimeType}\n--', color: color, error: error);
  }
}

/// Konsol logları için renklendirme
enum ConsoleColor {
  white(foreground: '37', background: ''),
  purple(foreground: '35', background: ''),
  yellow(foreground: '33', background: ''),
  red(foreground: '31', background: ''),
  black(foreground: '30', background: ''),
  blackWhite(foreground: '30', background: ';47'),
  whiteRed(foreground: '37', background: ';41'),
  whitePurple(foreground: '37', background: ';45'),
  yellowRed(foreground: '33', background: ';41');

  const ConsoleColor({required this.foreground, this.background});

  final String foreground;
  final String? background;
}
