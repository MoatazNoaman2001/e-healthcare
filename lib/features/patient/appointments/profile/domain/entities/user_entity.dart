// domain/entities/user_entity.dart
class UserEntity {
  final String name;
  final String email;
  final String phone;
  final String birthDate;
  final String bloodType;
  final String height;
  final String weight;
  final String insuranceCompany;
  final String insuranceNumber;
  final String insuranceExpiry;

  UserEntity({
    required this.name,
    required this.email,
    required this.phone,
    required this.birthDate,
    required this.bloodType,
    required this.height,
    required this.weight,
    required this.insuranceCompany,
    required this.insuranceNumber,
    required this.insuranceExpiry,
  });
}
