import 'package:flutter_bloc/flutter_bloc.dart';
import 'medical_record_event.dart';
import 'medical_record_state.dart';

class MedicalRecordBloc extends Bloc<MedicalRecordEvent, MedicalRecordState> {
  MedicalRecordBloc() : super(MedicalRecordInitial()) {
    on<LoadMedicalRecord>((event, emit) async {
      emit(MedicalRecordLoading());
      await Future.delayed(const Duration(seconds: 1)); // simulate fetch
      emit(MedicalRecordLoaded());
    });
  }
}
