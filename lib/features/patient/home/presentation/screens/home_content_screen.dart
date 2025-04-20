import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../bloc/home_bloc.dart';
import '../widgets/doctor_list.dart';
import '../widgets/recent_doctor.dart';
import '../widgets/specialty_chips.dart';
import '../widgets/next_appointment_card.dart';

class HomeContentScreen extends StatefulWidget {
  const HomeContentScreen({Key? key}) : super(key: key);

  @override
  State<HomeContentScreen> createState() => _HomeContentScreenState();
}

class _HomeContentScreenState extends State<HomeContentScreen> {
  final TextEditingController _searchController = TextEditingController();
  int? _userId;
  int? _patientId;
  bool _isSearching = false;

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  Future<void> _loadUserData() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _userId = prefs.getInt('user_id');
      _patientId = prefs.getInt('patient_id') ?? _userId; // Fallback to user_id if patient_id isn't set
    });

    if (_userId != null && _patientId != null) {
      _fetchInitialData();
    }
  }

  void _fetchInitialData() {
    // Load specializations
    context.read<HomeBloc>().add(const FetchSpecializationsEvent());

    // Load appointments for the patient
    if (_patientId != null) {
      context.read<HomeBloc>().add(FetchUpcomingAppointmentsEvent(patientId: _patientId!));
      context.read<HomeBloc>().add(FetchPastAppointmentsEvent(patientId: _patientId!));
    }

    // Load clinics
    context.read<HomeBloc>().add(const FetchClinicsEvent());

    // Load popular doctors (no search query)
    context.read<HomeBloc>().add(const FetchDoctorsEvent());
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSearchField(context),
          const SizedBox(height: 16),

          if (!_isSearching) ...[
            const Text('التخصصات', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            const SpecialtyChips(),
            const SizedBox(height: 16),
            const NextAppointmentCard(),
            const SizedBox(height: 16),
            const RecentDoctors(),
          ] else ...[
            const DoctorsList(),
          ],
        ],
      ),
    );
  }

  Widget _buildSearchField(BuildContext context) {
    return TextFormField(
      controller: _searchController,
      textDirection: TextDirection.rtl,
      decoration: InputDecoration(
        hintText: 'ابحث عن طبيب، تخصص',
        hintTextDirection: TextDirection.rtl,
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
            setState(() {
              _isSearching = false;
            });
            context.read<HomeBloc>().add(const FetchDoctorsEvent());
          },
        )
            : null,
      ),
      onChanged: (value) {
        if (value.length > 2) {
          setState(() {
            _isSearching = true;
          });
          context.read<HomeBloc>().add(FetchDoctorsEvent(searchQuery: value));
        } else if (value.isEmpty) {
          setState(() {
            _isSearching = false;
          });
          context.read<HomeBloc>().add(const FetchDoctorsEvent());
        }
      },
    );
  }
}
