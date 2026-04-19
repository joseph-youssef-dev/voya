class PassengerProfileModel {
  final String ssn;
  final String firstName;
  final String lastName;
  final String birthDate;
  final String phone;
  final String town;
  final String? profileImage;

  PassengerProfileModel({
    required this.ssn,
    required this.firstName,
    required this.lastName,
    required this.birthDate,
    required this.phone,
    required this.town,
    this.profileImage,
  });

  factory PassengerProfileModel.fromJson(Map<String, dynamic> json) {
    return PassengerProfileModel(
      ssn: json['ssn'] ?? '',
      firstName: json['firstName'] ?? '',
      lastName: json['lastName'] ?? '',
      birthDate: json['birthDate'] ?? '',
      phone: json['phone'] ?? '',
      town: json['town'] ?? '',
      profileImage: json['profileImage'],
    );
  }
}
