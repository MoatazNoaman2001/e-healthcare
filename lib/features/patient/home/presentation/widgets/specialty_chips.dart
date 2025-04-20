// lib/features/home/presentation/widgets/specialty_chips.dart

import 'package:flutter/material.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/home_bloc.dart';

class SpecialtyChips extends StatelessWidget {
  const SpecialtyChips({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeState>(
      builder: (context, state) {
        if (state.isSpecializationsLoading) {
          return const Center(
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 16.0),
              child: CircularProgressIndicator(),
            ),
          );
        }

        if (state.specializationsError != null) {
          return Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              child: Text('خطأ: ${state.specializationsError}'),
            ),
          );
        }

        if (state.specializations.isEmpty) {
          return const Center(
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 16.0),
              child: Text('لا توجد تخصصات متاحة'),
            ),
          );
        }

        return Wrap(
          spacing: 8.0,
          runSpacing: 4.0,
          children: state.specializations.map((specialization) {
            return ActionChip(
              label: Text(specialization.name),
              backgroundColor: Colors.blue.shade100,
              labelStyle: const TextStyle(color: Colors.blue),
              onPressed: () {
                // When a specialty is tapped, filter doctors by this specialty
                context.read<HomeBloc>().add(
                  FetchDoctorsEvent(searchQuery: specialization.name),
                );
              },
            );
          }).toList(),
        );
      },
    );
  }
}

