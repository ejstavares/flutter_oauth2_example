class ConfigModel {
  String? clientId;
  String? clientSecret;

  String? discoverURL;
  String? userInfoEndpoint;

  ConfigModel({this.clientId, this.clientSecret, this.discoverURL, this.userInfoEndpoint});

  factory ConfigModel.fromJson(Map<String, dynamic> json) =>
    ConfigModel(
      clientId: json['client_id'] as String?,
      clientSecret: json['client_secret'] as String?,
      discoverURL: json['discover_url'] as String?,
      userInfoEndpoint: json['user_info_endpoint'] as String?,
    );

  Map<String, dynamic> toJson() =>   <String, dynamic> {
    'client_id': clientId,
    'client_secret': clientSecret,
    'discover_url': discoverURL,
    'user_info_endpoint': userInfoEndpoint,
  };
}

