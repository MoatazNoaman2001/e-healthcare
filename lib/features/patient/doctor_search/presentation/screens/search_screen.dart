import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import '../bloc/search_doctor_bloc.dart';
import '../widgets/doctor_card.dart';
import 'package:doctorapp/core/di/dependancy_injection.dart' as di;

class SearchDoctorsScreen extends StatefulWidget {
  const SearchDoctorsScreen({Key? key}) : super(key: key);

  @override
  State<SearchDoctorsScreen> createState() => _SearchDoctorsScreenState();
}

class _SearchDoctorsScreenState extends State<SearchDoctorsScreen> {
  final TextEditingController _searchController = TextEditingController();
  final FocusNode _searchFocusNode = FocusNode();
  String? _selectedSpecialty;

  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      context.read<DoctorSearchBloc>().add(const SearchDoctorsEvent());
      context.read<DoctorSearchBloc>().add(const LoadSpecialtiesEvent());
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    _searchFocusNode.dispose();
    super.dispose();
  }

  @override
Widget build(BuildContext context) {
  return Scaffold(
    body: BlocBuilder<DoctorSearchBloc, DoctorSearchState>(
      builder: (context, state) {
        return Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: _buildSearchBar(context),
            ),
            if (state.specialties.isNotEmpty)
              _buildSpecialtyFilter(context, state),
            Expanded(
              child: _buildDoctorsList(context, state),
            ),
          ],
        );
      },
    ),
  );
}
  Widget _buildSearchBar(BuildContext context) {
    return TextFormField(
      controller: _searchController,
      focusNode: _searchFocusNode,
      // textDirection: TextDirection.rtl,
      decoration: InputDecoration(
        hintText: 'search_hint'.tr(),
        // hintTextDirection: TextDirection.rtl,
        prefixIcon: const Icon(Icons.search),
        filled: true,
        fillColor: Colors.grey.shade100,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide.none,
        ),
        suffixIcon: _searchController.text.isNotEmpty
            ? IconButton(
                icon: const Icon(Icons.clear),
                onPressed: () {
                  _searchController.clear();
                  context
                      .read<DoctorSearchBloc>()
                      .add(const SearchDoctorsEvent());
                },
              )
            : null,
      ),
      onChanged: (value) {
        if (value.length > 2) {
          context.read<DoctorSearchBloc>().add(
                SearchDoctorsEvent(
                  query: value,
                  specialty: _selectedSpecialty,
                ),
              );
        } else if (value.isEmpty) {
          context.read<DoctorSearchBloc>().add(
                SearchDoctorsEvent(
                  specialty: _selectedSpecialty,
                ),
              );
        }
      },
    );
  }

  Widget _buildSpecialtyFilter(BuildContext context, DoctorSearchState state) {
    return Container(
      height: 50,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: state.specialties.length,
        itemBuilder: (context, index) {
          final specialty = state.specialties[index];
          final isSelected = specialty.name == _selectedSpecialty;

          return Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: FilterChip(
              label: Text(specialty.name),
              selected: isSelected,
              onSelected: (selected) {
                setState(() {
                  _selectedSpecialty = selected ? specialty.name : null;
                });

                context.read<DoctorSearchBloc>().add(
                      SearchDoctorsEvent(
                        query: _searchController.text,
                        specialty: selected ? specialty.name : null,
                      ),
                    );
              },
              backgroundColor: Colors.grey.shade200,
              selectedColor: Colors.blue.shade100,
              checkmarkColor: Colors.blue,
            ),
          );
        },
      ),
    );
  }

  Widget _buildDoctorsList(BuildContext context, DoctorSearchState state) {
    if (state.isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (state.error != null) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.error_outline, size: 48, color: Colors.red),
            const SizedBox(height: 16),
            Text('${'error_occurred'.tr()} ${state.error}'),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                context.read<DoctorSearchBloc>().add(
                      SearchDoctorsEvent(
                        query: _searchController.text,
                        specialty: _selectedSpecialty,
                      ),
                    );
              },
              child: Text('retry'.tr()),
            ),
          ],
        ),
      );
    }

    if (state.doctors.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.search_off, size: 64, color: Colors.grey.shade400),
            const SizedBox(height: 16),
            Text('no_doctors_found'.tr(),
                style:
                    const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            Text('try_another_filter'.tr()),
          ],
        ),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: state.doctors.length,
      itemBuilder: (context, index) {
        final doctor = state.doctors[index];
        return DoctorCard(
          name: 'د. ${doctor.firstName} ${doctor.lastName}',
          specialty: doctor.specialization,
          rating: doctor.rating ?? 0.0,
          experience: '${doctor.experience ?? 0} سنوات',
          nextAppointment: doctor.nextAvailableSlot ?? 'غير متاح',
          onTap: () => Navigator.pushNamed(context, '/book-appointment',
              arguments: doctor),
          onBook: () => Navigator.pushNamed(context, '/book-appointment',
              arguments: doctor),
        );
      },
    );
  }
}
