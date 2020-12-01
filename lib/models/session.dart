import 'package:meta/meta.dart' show required;

class Session {
  final String token;
  final int expiresIn;
  final DateTime createAt;

  Session({
    @required this.token,
    @required this.expiresIn,
    @required this.createAt,
  });

  //NOTA EL MOVIL SOLO ALMACENA STRINGS
  static Session fromJson(Map<String, dynamic> json) {
    return Session(
      token: json['token'],
      expiresIn: json['expiresIn'],
      createAt: DateTime.parse(json['createAt']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'token': this.token,
      'expiresIn': this.expiresIn,
      'createAt': this.createAt.toIso8601String()
    };
  }
}
