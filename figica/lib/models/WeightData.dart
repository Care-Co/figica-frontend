class WeightData {
  DateTime measuredDate;
  DateTime measuredTime;
  double weight;
  double weightChange;
  String weightType;

  WeightData({
    required this.measuredDate,
    required this.measuredTime,
    required this.weight,
    required this.weightChange,
    required this.weightType,
  });

  static void sortData(List<WeightData> data) {
    try {
      data.sort((a, b) => a.measuredTime.compareTo(b.measuredTime));
    } on Exception catch (e) {
      print(e);
    }
  }

  static void sortData2(List<WeightData> data) {
    try {
      data.sort((a, b) => b.measuredTime.compareTo(a.measuredTime));
    } on Exception catch (e) {
      print(e);
    }
  }

  String toString() {
    return '{measuredDate: $measuredDate, measuredTime: $measuredTime, weight: $weight, weightType: $weightType,weightChange: $weightChange}';
  }

  factory WeightData.fromJson(Map<String, dynamic> json) {
    return WeightData(
      measuredDate: DateTime.parse(json['measuredDate']),
      measuredTime: DateTime.parse("${json['measuredDate']} ${json['measuredTime']}"),
      weight: json['weight'].toDouble(),
      weightChange: json['weightChange']?.toDouble() ?? 1.0,
      weightType: json['weightType'],
    );
  }
  Map<String, dynamic> toJson() {
    return {
      'measuredDate': measuredDate.toIso8601String().split('T')[0],
      'measuredTime': measuredTime.toIso8601String().split('T')[1],
      'weight': weight,
      'weightType': weightType,
      'weightChange': weightChange,
    };
  }
}
