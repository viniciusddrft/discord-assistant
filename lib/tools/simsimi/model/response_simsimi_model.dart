class MessageSimsimiModel {
  final String methods, success, noti, location, donate;

  MessageSimsimiModel.fromJson(Map<String, dynamic> json)
      : methods = json['methods'],
        success = json['success'],
        noti = json['noti'],
        location = json['location'],
        donate = json['donate'];

  Map<String, dynamic> toJson() => {
        'methods': methods,
        'success': success,
        'noti': noti,
        'location': location,
        'donate': donate,
      };
}
