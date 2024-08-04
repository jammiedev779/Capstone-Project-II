class PatientProfile {
  final int id;
  final String phoneNumber;
  final String firstName;
  final String lastName;
  final String age;
  final String gender;
  final String address;
  final String email;

  PatientProfile({
    required this.id,
    required this.phoneNumber,
    required this.firstName,
    required this.lastName,
    required this.age,
    required this.gender,
    required this.address,
    required this.email,
  });

  factory PatientProfile.fromJson(Map<String, dynamic> json) {
    return PatientProfile(
      id: json['id'],
      phoneNumber: json['phone_number'] ?? '',
      firstName: json['first_name'] ?? '',
      lastName: json['last_name'] ?? '',
      age: json['age'] ?? '',
      gender: json['gender'] ?? '',
      address: json['address'] ?? '',
      email: json['email'] ?? '',
    );
  }
}
