import 'package:equatable/equatable.dart';

class Specialization extends Equatable {
  final int id;
  final String name;

  const Specialization({
    required this.id,
    required this.name,
  });

  factory Specialization.fromJson(Map<String, dynamic> json) {
    return Specialization(
      id: json['id'],
      name: json['name'],
    );
  }

  @override
  List<Object?> get props => [id, name];
}
