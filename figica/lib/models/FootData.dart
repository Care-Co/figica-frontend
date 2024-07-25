import 'package:fisica/index.dart';
import 'package:flutter/material.dart';

class FootData {
  String footprintId;
  DateTime measuredDate;
  DateTime measuredTime;
  int classType;
  int accuracy;
  String? imageUrl;
  double weight;

  FootData({
    required this.footprintId,
    required this.measuredDate,
    required this.measuredTime,
    required this.classType,
    required this.accuracy,
    this.imageUrl,
    required this.weight,
  });

  static String settype(int typeint) {
    switch (typeint) {
      case 0:
        return '정상발';
      case 1:
        return '요족';
      case 2:
        return '평발';
      case 3:
        return '척추 전만증';
      case 4:
        return '척추 후만증';
      case 5:
        return '척추 좌 측만증';
      case 6:
        return '척추 우 측만증';
      case 7:
        return '골반 비틀림';
      default:
        return '알 수 없는 상태';
    }
  }

  String toString() {
    return 'footData(measuredDate: $measuredDate, measuredTime: $measuredTime, classType: $classType, accuracy: $accuracy, imageUrl: $imageUrl, weight: $weight)';
  }

  // Method to parse from JSON
  factory FootData.fromJson(Map<String, dynamic> json) {
    return FootData(
      footprintId: json['footprintId'],
      measuredDate: DateTime.parse(json['measuredDate']),
      measuredTime: DateTime.parse("${json['measuredDate']} ${json['measuredTime']}"),
      classType: json['classType'],
      accuracy: json['accuracy'],
      imageUrl: json['imageUrl'],
      weight: json['weight'].toDouble(),
    );
  }

  // Method to convert to JSON
  Map<String, dynamic> toJson() {
    return {
      'footprintId': footprintId,
      'measuredDate': measuredDate.toIso8601String().split('T')[0],
      'measuredTime': measuredTime.toIso8601String().split('T')[1],
      'classType': classType,
      'accuracy': accuracy,
      'imageUrl': imageUrl,
      'weight': weight,
    };
  }

  static String timeElapsedSince(BuildContext context, DateTime logTime) {
    DateTime currentTime = DateTime.now();
    Duration timeDifference = currentTime.difference(logTime);
    int months = (currentTime.year - logTime.year) * 12 + currentTime.month - logTime.month;
    int days = timeDifference.inDays;
    int hours = timeDifference.inHours % 24;
    int minutes = timeDifference.inMinutes % 60;

    String timeDiffStr = "";

    if (minutes > 0) {
      if (timeDiffStr.isNotEmpty) timeDiffStr += ", ";
      timeDiffStr = SetLocalizations.of(context).getText('profileHistoryDateMinuteLabel', values: {'minute': minutes.toString()});
    }
    if (hours > 0) {
      if (timeDiffStr.isNotEmpty) timeDiffStr += ", ";
      timeDiffStr = SetLocalizations.of(context).getText('profileHistoryDateHourLabel', values: {'hour': hours.toString()});
    }
    if (days > 0) {
      if (timeDiffStr.isNotEmpty) timeDiffStr += ", ";
      timeDiffStr = SetLocalizations.of(context).getText('profileHistoryDateDayLabel', values: {'day': days.toString()});
    }
    if (months > 0) {
      timeDiffStr = SetLocalizations.of(context).getText('profileHistoryDateMonthLabel', values: {'month': months.toString()});
    }
    return timeDiffStr.isEmpty ? SetLocalizations.of(context).getText('profileHistoryDateMinuteLabel', values: {'minute': '1'}) : timeDiffStr;
  }
}
