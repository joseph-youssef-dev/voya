class EndPoints {
  /// auth endpoints
  static const String baserUrl = "http://voya.runasp.net/api";
  static const String login = "/Auth/login";
  static const String registerPassenger = "/Auth/register-passenger";
  static const String registerDriver = "/Auth/register-driver";

  static const String verfiyAccount = "/Auth/verify-email-otp";
  static const String forgetPassword = "/Auth/forget-password";
  static const String resetPassword = "/Auth/reset-password";
  static const String refreshToken = "/Auth/refresh-token";
  static const String logout = "/Auth/logout";

  /// trip endpoints
  static const String getAllTrips = "/Trip/GetAllTrips";

  /// passenger endpoints
  static const String getPassengerProfile = "/Passanger/GetProfile";
  static const String getMyTrips = "/Passanger/GetMyTrips";
  static const String updatePassengerProfile = "/Passanger/UpdateProflie";

  /// booking trip
  static const String createBooking = "/Booking/create-booking";
  static const String updateBooking = "/Booking/update-booking/{id}";
  static const String getAllBookings = "/Booking/get-all";
  static const String getBookingById = "/Booking/get-booking/{id}";

  /// driver endpoints
  static const String getDriverProfile = "/Driver/get-profile";
  static const String updateDriverProfile = "/Driver/update-driver";
  static const String getDriverTrips = "/Driver/get-trips";
  static const String getVehicles = "/Driver/get-vehicles";
  static const String addVehicle = "/Driver/add-vehicle";
  static const String updateVehicle = "/Driver/update-vehicle/{id}";
  static const String deleteVehicle = "/Driver/vehicle/{id}";
}
