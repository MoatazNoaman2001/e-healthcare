abstract class MedicalRecordState {}

class MedicalRecordInitial extends MedicalRecordState {}

class MedicalRecordLoading extends MedicalRecordState {}

class MedicalRecordLoaded extends MedicalRecordState {
  final String name = 'محمد أحمد محمود';
  final int age = 35;
  final String bloodType = 'O+';
  final String height = '175 سم';
  final String weight = '75 كجم';

  const MedicalRecordLoaded();
}

class MedicalRecordError extends MedicalRecordState {
  final String message;
  MedicalRecordError(this.message);
}
