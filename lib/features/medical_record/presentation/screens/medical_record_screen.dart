import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/medical_record_bloc.dart';
import '../bloc/medical_record_event.dart';
import '../bloc/medical_record_state.dart';

class MedicalRecordScreen extends StatelessWidget {
  const MedicalRecordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => MedicalRecordBloc()..add(LoadMedicalRecord()),
      child: Directionality(
        textDirection: TextDirection.rtl,
        child: Scaffold(
          appBar: AppBar(title: const Text('السجل الطبي'), centerTitle: true),
          body: BlocBuilder<MedicalRecordBloc, MedicalRecordState>(
            builder: (context, state) {
              if (state is MedicalRecordLoading) {
                return const Center(child: CircularProgressIndicator());
              } else if (state is MedicalRecordLoaded) {
                return Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildSectionTitle(context, 'المعلومات الأساسية'),
                      const SizedBox(height: 8),
                      _buildInfoCard(
                        child: Column(
                          children: [
                            _buildInfoRow('الاسم', state.name),
                            _buildInfoRow('العمر', '${state.age} سنة'),
                            _buildInfoRow('فصيلة الدم', state.bloodType),
                            _buildInfoRow('الطول', state.height),
                            _buildInfoRow('الوزن', state.weight),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              } else if (state is MedicalRecordError) {
                return Center(child: Text(state.message));
              }
              return const SizedBox();
            },
          ),
        ),
      ),
    );
  }

  Widget _buildSectionTitle(BuildContext context, String title) {
    return Row(
      children: [
        Icon(Icons.local_hospital, color: Theme.of(context).colorScheme.primary),
        const SizedBox(width: 8),
        Text(title, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Theme.of(context).colorScheme.primary)),
      ],
    );
  }

  Widget _buildInfoCard({required Widget child}) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(padding: const EdgeInsets.all(16), child: child),
    );
  }

  Widget _buildInfoRow(String title, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title, style: TextStyle(fontSize: 16, color: Colors.grey.shade700)),
          Text(value, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }
}
