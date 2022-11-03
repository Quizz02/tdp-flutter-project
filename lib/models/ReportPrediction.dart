class ReportPrediction {
  int? id;
  String? hash;
  int? year;
  int? month;
  int? hour;
  int? dayOfTheWeek;
  int? dayOfTheMonth;
  double? latitude;
  double? longitude;

  ReportPrediction(
      {this.id,
        this.hash,
        this.year,
        this.month,
        this.hour,
        this.dayOfTheWeek,
        this.dayOfTheMonth,
        this.latitude,
        this.longitude,
        });

  ReportPrediction.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    hash = json['hash'];
    year = json['year'];
    month = json['month'];
    hour = json['hour'];
    dayOfTheWeek = json['dayOfTheWeek'];
    dayOfTheMonth = json['dayOfTheMonth'];
    latitude = json['latitude'];
    longitude = json['longitude'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['hash'] = this.hash;
    data['year'] = this.year;
    data['month'] = this.month;
    data['hour'] = this.hour;
    data['dayOfTheWeek'] = this.dayOfTheWeek;
    data['dayOfTheMonth'] = this.dayOfTheMonth;
    data['latitude'] = this.latitude;
    data['longitude'] = this.longitude;
    return data;
  }
}