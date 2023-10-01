class ApiEndpoints {
  ApiEndpoints._();

  static const Duration connectionTimeout = Duration(seconds: 1000);
  static const Duration receiveTimeout = Duration(seconds: 1000);
  static const String baseUrl = "http://192.168.8.108:88/";

  static const String login = "/selfservicev2/ApiSecurity/ApiLogin";
  static const String getData =
      "/selfservicev2/NEAReportsApi/PersonalDailyReport";
}
