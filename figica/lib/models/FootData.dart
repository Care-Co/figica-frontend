class FootData {
  DateTime measuredDate;
  DateTime measuredTime;
  int classType;
  int accuracy;
  String imageUrl;
  double weight;

  FootData({
    required this.measuredDate,
    required this.measuredTime,
    required this.classType,
    required this.accuracy,
    required this.imageUrl,
    required this.weight,
  });
  static void sortData(List<FootData> data) {
    try {
      data.sort((a, b) => a.measuredTime.compareTo(b.measuredTime));
    } on Exception catch (e) {
      print(e);
    }
  }

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
      'measuredDate': measuredDate.toIso8601String().split('T')[0],
      'measuredTime': measuredTime.toIso8601String().split('T')[1],
      'classType': classType,
      'accuracy': accuracy,
      'imageUrl': imageUrl,
      'weight': weight,
    };
  }
}
