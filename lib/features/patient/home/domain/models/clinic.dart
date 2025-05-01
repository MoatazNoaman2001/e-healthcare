import 'package:equatable/equatable.dart';

class Clinic extends Equatable {
  final int clinicId;
  final String name;
  final String address;
  final String city;
  final String phoneNumber;

  const Clinic({
    required this.clinicId,
    required this.name,
    required this.address,
    required this.city,
    required this.phoneNumber,
  });

  factory Clinic.fromJson(Map<String, dynamic> json) {
    return Clinic(
      clinicId: json['clinic_id'] ?? 0,
      name: json['name']?? "",
      address: json['address'] ?? "",
      city: json['city']?? "",
      phoneNumber: json['phone_number']?? "",
    );
  }

  @override
  List<Object?> get props => [clinicId, name, address, city, phoneNumber];
}