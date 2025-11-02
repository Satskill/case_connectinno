import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:pasaportsmart/core/util/extension.dart';

class AppGenerator {
  /// Bir gün verildiğinde o günün içinde bulunduğu günlerin listesini verir
  /// [isNullable] değeri o ayın hangi günde başlıyorsa listenin başına pazartesiye kadar null döndürür
  /// örnek kullanım
  ///```dart
  ///getDaysInMonth(DateTime(2022,1,1), isNullable: true); // 2022 Şubat Salı günü başladığından
  /// //Çıktı Aşağıdaki gibi olur
  ///[null,DateTime(2022,2,1),DateTime(2022,2,2),...,DateTime(2022,2,28)]
  ///```
  static List<DateTime?> getDaysInMonth(DateTime date, {bool isNullable = true}) {
    List<DateTime?> daysInMonth = [];
    DateTime firstDay = DateTime(date.year, date.month, 1);
    DateTime lastDay = DateTime(date.year, date.month + 1, 0);

    for (int i = 0; i < lastDay.day; i++) {
      daysInMonth.add(firstDay.add(Duration(days: i)));
    }

    if (isNullable) {
      final weekStart = (firstDay.weekday - 1);
      daysInMonth.insertAll(0, List.generate(weekStart, (index) => null));
    }

    return daysInMonth;
  }

  static List<DateTime> getDays(DateTime date) {
    List<DateTime> daysInMonth = [];
    DateTime firstDay = DateTime(date.year, date.month, 1);
    DateTime lastDay = DateTime(date.year, date.month + 1, 0);

    for (int i = 0; i < lastDay.day; i++) {
      daysInMonth.add(firstDay.add(Duration(days: i)));
    }

    return daysInMonth;
  }

  /// Verilen tarihin takvim görüntüsünü oluşturacak şekilde
  /// gün listesinin döndürür
  static List<DateTime> generateCalendarDays(DateTime date) {
    List<DateTime> daysInMonth = getDays(date);
    final firstDay = daysInMonth.first;
    final lastDay = daysInMonth.last;
    for (var i = 0; i < (firstDay.weekday - 1); i++) {
      daysInMonth.insert(0, firstDay.subtract(Duration(days: i + 1)));
    }
    for (var i = 0; i < (7 - lastDay.weekday); i++) {
      daysInMonth.add(lastDay.add(Duration(days: i + 1)));
    }
    if (daysInMonth.length == 35) {
      for (var i = 0; i < 7; i++) {
        daysInMonth.add(daysInMonth.last.add(Duration(days: i + 1)));
      }
    }
    return daysInMonth;
  }

  /// Farklı ayların listesi verilerek o aylardaki günlerin listesini döndürür
  /// örnek kullanım
  ///```dart
  ///getDayInMonths([DateTime(2022,1,1), DateTime(2022,2,1), DateTime(2022,3,1)]);
  ///```
  static Map<DateTime, List<DateTime?>> getDaysInMonths(List<DateTime> dateList) {
    Map<DateTime, List<DateTime?>> result = {};

    for (var date in dateList) {
      if (!result.containsKey(date)) {
        result[date] = getDaysInMonth(date);
      }
    }

    return result;
  }

  static DateTime convertToDateTime(String str, {String pattern = '-'}) {
    final str2 = str.split(pattern);
    final year = int.parse(str2.first);
    final month = int.parse(str2.last);
    return DateTime(year, month);
  }

  static List<DateTime> convertToDateTimeList(List<String> list, {String pattern = '-'}) {
    List<DateTime> dateList = [];
    for (var str in list) {
      dateList.add(convertToDateTime(str, pattern: pattern));
    }
    return dateList;
  }

  static Color randomColor() => Color((math.Random().nextDouble() * 0xFFFFFF).toInt()).withOpacity(1.0);

  static String appointmentDateText({required DateTime start, required DateTime end}) {
    if (start.year != DateTime.now().year) {
      if (start.isSameDay(end)) {
        return '${DateFormat.yMMMMd().format(start)} ${DateFormat.Hm().format(start)} - ${DateFormat.Hm().format(end)}';
      }
      return '${DateFormat("dd MMMM yyyy HH:mm").format(start)} - ${DateFormat("dd MMMM yyyy HH:mm").format(end)}';
    } else {
      if (start.isSameDay(end)) {
        return '${DateFormat.MMMMd().format(start)} ${DateFormat.Hm().format(start)} - ${DateFormat.Hm().format(end)}';
      }
      return '${DateFormat("dd MMMM HH:mm").format(start)} - ${DateFormat("dd MMMM HH:mm").format(end)}';
    }
  }

  /// Takvim için bir TimeOfDay to double çevirici. TimePicker ile aldığımız verinin Takvim için gereken double değere çevirilme işlemini yapar
  static double timeOfDayToDouble(TimeOfDay time) {
    return time.hour + time.minute / 60;
  }

  /// Takvim için bir double değeri TimeOfDay değerine çevirici.
  static TimeOfDay doubleToTimeOfDay(double value) {
    if (value > 24) return const TimeOfDay(hour: 23, minute: 59);
    if (value < 0 || value == 24) return const TimeOfDay(hour: 0, minute: 0);
    int hours = value.floor();
    int minutes = ((value - hours) * 60).round();
    return TimeOfDay(hour: hours, minute: minutes);
  }
}
