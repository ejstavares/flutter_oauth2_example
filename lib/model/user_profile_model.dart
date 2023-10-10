class UserProfileModel {
  int? id;
  String? name;
  String? email;
  String? sub;
  String? token;
  String? idToken;

  UserProfileModel({this.id, this.name, this.email, this.sub, this.token, this.idToken});

  factory UserProfileModel.fromJson(Map<String, dynamic> json) =>
    UserProfileModel(
      id: json['id'] as int?,
      name: json['name'] as String?,
      email: json['email'] as String?,
      sub: json['sub'] as String?,
      token: json['token'] as String?,
      idToken: json['idToken'] as String?,
    );

  Map<String, dynamic> toJson() =>   <String, dynamic> {
    'id': id,
    'name': name,
    'email': email,
    'sub': sub,
    'token': token,
    'idToken': idToken,
  };
}

