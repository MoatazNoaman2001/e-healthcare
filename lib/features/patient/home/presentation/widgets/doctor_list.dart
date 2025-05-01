import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/home_bloc.dart';

class DoctorsList extends StatelessWidget {
  const DoctorsList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeState>(
      builder: (context, state) {
        if (state.isDoctorsLoading) {
          return const Center(
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 24.0),
              child: CircularProgressIndicator(),
            ),
          );
        }

        if (state.doctorsError != null) {
          return Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 24.0),
              child: Column(
                children: [
                  const Icon(Icons.error_outline, size: 48, color: Colors.red),
                  const SizedBox(height: 16),
                  Text('خطأ: ${state.doctorsError}'),
                ],
              ),
            ),
          );
        }

        if (state.doctors.isEmpty) {
          return Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 24.0),
              child: Column(
                children: [
                  Icon(Icons.search_off, size: 48, color: Colors.grey.shade500),
                  const SizedBox(height: 16),
                  const Text('لم يتم العثور على أطباء مطابقين للبحث'),
                ],
              ),
            ),
          );
        }

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Text(
                'تم العثور على ${state.doctors.length} طبيب',
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
            ),
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: state.doctors.length,
              itemBuilder: (context, index) {
                final doctor = state.doctors[index];
                return Card(
                  margin: const EdgeInsets.only(bottom: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: ListTile(
                    contentPadding: const EdgeInsets.all(12),
                    leading: CircleAvatar(
                      radius: 30,
                      backgroundColor: Colors.blue.shade100,
                      child: doctor.imageUrl != null
                          ? ClipRRect(
                        borderRadius: BorderRadius.circular(30),
                        child: Image.network(
                          doctor.imageUrl!,
                          width: 60,
                          height: 60,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) {
                            return const Icon(Icons.person, size: 30, color: Colors.blue);
                          },
                        ),
                      )
                          : const Icon(Icons.person, size: 30, color: Colors.blue),
                    ),
                    title: Text(
                      'د. ${doctor.firstName} ${doctor.lastName}',
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 4),
                        Text(
                          doctor.title,
                          style: TextStyle(
                            color: Colors.grey.shade600,
                          ),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          doctor.specialization,
                          style: TextStyle(
                            color: Colors.blue.shade800,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                    trailing: ElevatedButton(
                      onPressed: () {
                        // Navigate to doctor appointment booking
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color.fromARGB(255, 10, 33, 51),
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: const Text('حجز'),
                    ),
                    onTap: () {
                      // Navigate to doctor details
                    },
                  ),
                );
              },
            ),
          ],
        );
      },
    );
  }
}