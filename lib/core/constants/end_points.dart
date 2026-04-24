class EndPoints {
  /// auth endpoints
  static const String baserUrl = "http://voya.runasp.net/api";
  static const String login = "/Auth/login";
  static const String registerPassenger = "/Auth/register-passenger";
  static const String registerDriver = "/Auth/register-driver";

  /// trip endpoints
  static const String getAllTrips = "/Trip/GetAllTrips";

  /// passenger endpoints
  static const String getPassengerProfile = "/Passanger/GetProfile";
  static const String getMyTrips = "/Passanger/GetMyTrips";
  static const String updatePassengerProfile = "/Passanger/UpdateProflie";
}

class ApiKey {
  static String from = "From";
  static String to = "To";
}
