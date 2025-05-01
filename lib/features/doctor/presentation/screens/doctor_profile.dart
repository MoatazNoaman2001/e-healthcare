import 'package:doctorapp/features/doctor/domain/entities/doctor.dart';
import 'package:doctorapp/features/doctor/domain/entities/educations.dart';
import 'package:doctorapp/features/doctor/domain/entities/work_experiance.dart';
import 'package:doctorapp/features/doctor/presentation/bloc/doctor/doctor_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../../domain/entities/certifications.dart';

class DoctorProfileScreen extends StatefulWidget {
  const DoctorProfileScreen({Key? key}) : super(key: key);

  @override
  State<DoctorProfileScreen> createState() => _DoctorProfileScreenState();
}

class _DoctorProfileScreenState extends State<DoctorProfileScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
    _loadProfileData();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  void _loadProfileData() {
    context.read<DoctorBloc>().add(GetMyProfileEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<DoctorBloc, DoctorState>(
        builder: (context, state) {
          if (state is DoctorLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is DoctorError) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.error_outline,
                    size: 64,
                    color: Colors.red.shade400,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Error: ${state.failure.message}',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.red.shade600,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 24),
                  ElevatedButton.icon(
                    onPressed: _loadProfileData,
                    icon: const Icon(Icons.refresh),
                    label: const Text('Try Again'),
                  ),
                ],
              ),
            );
          } else if (state is MyProfileLoaded) {
            return _buildProfileContent(state.doctor, context);
          }

          // Default loading state
          return const Center(child: CircularProgressIndicator());
        },
      ),
    );
  }

  Widget _buildProfileContent(Doctor doctor, BuildContext context) {
    return CustomScrollView(
      slivers: [
        // App Bar with profile image and basic details
        SliverAppBar(
          expandedHeight: 250,
          pinned: true,
          flexibleSpace: FlexibleSpaceBar(
            background: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    Theme.of(context).primaryColor,
                    Theme.of(context).primaryColor.withOpacity(0.7),
                  ],
                ),
              ),
              child: SafeArea(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Profile Image
                    CircleAvatar(
                      radius: 60,
                      backgroundColor: Colors.white,
                      child: doctor.profilePicture != null
                          ? ClipOval(
                        child: Image.network(
                          doctor.profilePicture!,
                          width: 120,
                          height: 120,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) {
                            return const Icon(
                              Icons.person,
                              size: 60,
                              color: Colors.grey,
                            );
                          },
                        ),
                      )
                          : Text(
                        '${doctor.firstName[0]}${doctor.lastName[0]}',
                        style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).primaryColor,
                        ),
                      ),
                    ),
                    const SizedBox(height: 12),
                    // Doctor Name and Specialization
                    Text(
                      'Dr. ${doctor.fullName}',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      doctor.specialization ?? 'General Practitioner',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          leading: IconButton(icon: Icon(Icons.arrow_back_ios_new_rounded, color: Colors.white), onPressed: () {
            Navigator.pop(context);
          },),
          actions: [
            IconButton(
              icon: const Icon(Icons.edit, color: Colors.white,),
              onPressed: () {
                // Navigate to edit profile screen
                Navigator.pushNamed(
                  context,
                  '/doctor_schedule_setup_screen',
                  arguments: doctor,
                ).then((_) => _loadProfileData());
              },
              tooltip: 'schedule setup',
            ),
          ],
        ),

        // Profile stats
        SliverToBoxAdapter(
          child: Container(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Quick Stats Row
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    _buildStatCard(
                      context,
                      'Years Exp.',
                      '${doctor.yearsOfExperience ?? 0}',
                      Icons.work_history,
                    ),
                    _buildStatCard(
                      context,
                      'License',
                      doctor.licenseNumber ?? 'N/A',
                      Icons.badge,
                    ),
                    _buildStatCard(
                      context,
                      'Rating',
                      doctor.rating != null ? '${doctor.rating}/5.0' : 'N/A',
                      Icons.star,
                    ),
                  ],
                ),

                const SizedBox(height: 24),

                // Tabs for different sections
                TabBar(
                  controller: _tabController,
                  labelColor: Theme.of(context).primaryColor,
                  unselectedLabelColor: Colors.grey,
                  indicatorColor: Theme.of(context).primaryColor,
                  tabs: const [
                    Tab(text: 'About'),
                    Tab(text: 'Education'),
                    Tab(text: 'Experience'),
                    Tab(text: 'Certifications'),
                  ],
                ),

                // Tab content
                SizedBox(
                  height: 500, // Fixed height for tab content
                  child: TabBarView(
                    controller: _tabController,
                    children: [
                      // About Tab
                      _buildAboutTab(doctor),

                      // Education Tab
                      _buildEducationTab(doctor.educationList ?? []),

                      // Experience Tab
                      _buildExperienceTab(doctor.workExperienceList ?? []),

                      // Certifications Tab
                      _buildCertificationsTab(doctor.certificationsList ?? []),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildStatCard(BuildContext context, String title, String value, IconData icon) {
    return Container(
      width: MediaQuery.of(context).size.width / 3.5,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          Icon(
            icon,
            color: Theme.of(context).primaryColor,
            size: 28,
          ),
          const SizedBox(height: 8),
          Text(
            value,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Theme.of(context).primaryColor,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            title,
            style: TextStyle(
              fontSize: 12,
              color: Colors.grey[600],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAboutTab(Doctor doctor) {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(vertical: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Bio Section
          const SectionTitle(title: 'Biography'),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.1),
                  spreadRadius: 1,
                  blurRadius: 4,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Text(
              doctor.bio?.isNotEmpty == true
                  ? doctor.bio!
                  : 'No biography information available.',
              style: const TextStyle(
                fontSize: 14,
                height: 1.5,
              ),
            ),
          ),

          const SizedBox(height: 24),

          // Contact Information
          const SectionTitle(title: 'Contact Information'),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.1),
                  spreadRadius: 1,
                  blurRadius: 4,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Column(
              children: [
                InfoRow(
                  icon: Icons.email,
                  title: 'Email',
                  value: doctor.email,
                ),
                const SizedBox(height: 12),
                InfoRow(
                  icon: Icons.phone,
                  title: 'Phone',
                  value: doctor.phoneNumber,
                ),
                const SizedBox(height: 12),
                InfoRow(
                  icon: Icons.location_on,
                  title: 'Clinic Address',
                  value: doctor.clinicAddress ?? 'No address specified',
                ),
              ],
            ),
          ),

          const SizedBox(height: 24),

          // Specialties
          const SectionTitle(title: 'Specializations'),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.1),
                  spreadRadius: 1,
                  blurRadius: 4,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: doctor.specializationsList != null && doctor.specializationsList!.isNotEmpty
                ? Wrap(
              spacing: 8,
              runSpacing: 8,
              children: doctor.specializationsList!.map((specialization) {
                return Chip(
                  label: Text(specialization),
                  backgroundColor: Theme.of(context).primaryColor.withOpacity(0.1),
                  labelStyle: TextStyle(
                    color: Theme.of(context).primaryColor,
                  ),
                );
              }).toList(),
            )
                : const Text('No specializations specified'),
          ),
        ],
      ),
    );
  }

  Widget _buildEducationTab(List<Education> educationList) {
    if (educationList.isEmpty) {
      return const Center(
        child: Text('No education information available.'),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.symmetric(vertical: 16),
      itemCount: educationList.length,
      itemBuilder: (context, index) {
        final education = educationList[index];
        return TimelineCard(
          title: education.degree,
          subtitle: education.institution,
          description: education.fieldOfStudy ?? '',
          startDate: education.startDate,
          endDate: education.isCurrentlyStudying ? null : education.endDate,
          isOngoing: education.isCurrentlyStudying,
        );
      },
    );
  }

  Widget _buildExperienceTab(List<WorkExperience> experienceList) {
    if (experienceList.isEmpty) {
      return const Center(
        child: Text('No work experience information available.'),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.symmetric(vertical: 16),
      itemCount: experienceList.length,
      itemBuilder: (context, index) {
        final experience = experienceList[index];
        return TimelineCard(
          title: experience.position,
          subtitle: experience.organization,
          description: experience.description ?? '',
          startDate: experience.startDate,
          endDate: experience.isCurrentlyWorking ? null : experience.endDate,
          isOngoing: experience.isCurrentlyWorking,
        );
      },
    );
  }

  Widget _buildCertificationsTab(List<Certification> certificationsList) {
    if (certificationsList.isEmpty) {
      return const Center(
        child: Text('No certifications available.'),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.symmetric(vertical: 16),
      itemCount: certificationsList.length,
      itemBuilder: (context, index) {
        final certification = certificationsList[index];
        return Container(
          margin: const EdgeInsets.only(bottom: 16),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.1),
                spreadRadius: 1,
                blurRadius: 4,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Theme.of(context).primaryColor.withOpacity(0.1),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      Icons.verified,
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          certification.name,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                        Text(
                          certification.issuingOrganization,
                          style: const TextStyle(
                            color: Colors.grey,
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                  ),
                  if (certification.isExpired)
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: Colors.red.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: const Text(
                        'Expired',
                        style: TextStyle(
                          color: Colors.red,
                          fontSize: 12,
                        ),
                      ),
                    ),
                ],
              ),
              const SizedBox(height: 12),
              const Divider(),
              const SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Issue Date',
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: 12,
                        ),
                      ),
                      Text(
                        DateFormat('MMM yyyy').format(certification.issueDate),
                        style: const TextStyle(
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      const Text(
                        'Expiry Date',
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: 12,
                        ),
                      ),
                      Text(
                        certification.expiryDate != null
                            ? DateFormat('MMM yyyy').format(certification.expiryDate!)
                            : 'No Expiry',
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          color: certification.isExpired ? Colors.red : null,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              if (certification.credentialId != null) ...[
                const SizedBox(height: 12),
                Row(
                  children: [
                    const Text(
                      'Credential ID: ',
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 12,
                      ),
                    ),
                    Text(
                      certification.credentialId!,
                      style: const TextStyle(
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ],
              if (certification.credentialUrl != null) ...[
                const SizedBox(height: 8),
                InkWell(
                  onTap: () {
                    // Launch URL - would need url_launcher package
                  },
                  child: Row(
                    children: [
                      const Icon(
                        Icons.link,
                        size: 16,
                        color: Colors.blue,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        'View Credential',
                        style: TextStyle(
                          color: Theme.of(context).primaryColor,
                          fontWeight: FontWeight.w500,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ],
          ),
        );
      },
    );
  }
}

// Helper Widgets

class SectionTitle extends StatelessWidget {
  final String title;

  const SectionTitle({Key? key, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Text(
        title,
        style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: Theme.of(context).primaryColor,
        ),
      ),
    );
  }
}

class InfoRow extends StatelessWidget {
  final IconData icon;
  final String title;
  final String value;

  const InfoRow({
    Key? key,
    required this.icon,
    required this.title,
    required this.value,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(
          icon,
          size: 18,
          color: Theme.of(context).primaryColor,
        ),
        const SizedBox(width: 12),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: TextStyle(
                fontSize: 12,
                color: Colors.grey[600],
              ),
            ),
            const SizedBox(height: 2),
            Text(
              value,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class TimelineCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final String? description;
  final DateTime startDate;
  final DateTime? endDate;
  final bool isOngoing;

  const TimelineCard({
    Key? key,
    required this.title,
    required this.subtitle,
    this.description,
    required this.startDate,
    this.endDate,
    required this.isOngoing,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 24),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Timeline dot and line
          Column(
            children: [
              Container(
                width: 16,
                height: 16,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Theme.of(context).primaryColor,
                ),
              ),
              Container(
                width: 2,
                height: description != null && description!.isNotEmpty ? 120 : 80,
                color: Colors.grey[300],
              ),
            ],
          ),
          const SizedBox(width: 16),
          // Content
          Expanded(
            child: Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.1),
                    spreadRadius: 1,
                    blurRadius: 4,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              title,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              subtitle,
                              style: const TextStyle(
                                color: Colors.grey,
                                fontSize: 14,
                              ),
                            ),
                          ],
                        ),
                      ),
                      if (isOngoing)
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                          decoration: BoxDecoration(
                            color: Theme.of(context).primaryColor.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Text(
                            'Current',
                            style: TextStyle(
                              color: Theme.of(context).primaryColor,
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                    ],
                  ),
                  if (description != null && description!.isNotEmpty) ...[
                    const SizedBox(height: 8),
                    Text(
                      description!,
                      style: const TextStyle(
                        fontSize: 14,
                        height: 1.5,
                      ),
                    ),
                  ],
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Icon(
                        Icons.calendar_today,
                        size: 14,
                        color: Colors.grey[600],
                      ),
                      const SizedBox(width: 4),
                      Text(
                        isOngoing
                            ? '${DateFormat('MMM yyyy').format(startDate)} - Present'
                            : '${DateFormat('MMM yyyy').format(startDate)} - ${endDate != null ? DateFormat('MMM yyyy').format(endDate!) : 'N/A'}',
                        style: TextStyle(
                          color: Colors.grey[600],
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// Extension to provide extra fields for the Doctor entity
extension DoctorExtension on Doctor {
  String? get rating => null; // This would come from your actual API
  int? get yearsOfExperience => null; // This would come from your actual API
  List<Education>? get educationList => null; // This would come from your actual API
  List<WorkExperience>? get workExperienceList => null; // This would come from your actual API
  List<Certification>? get certificationsList => null; // This would come from your actual API
  List<String>? get specializationsList => specialization != null ? [specialization!] : null;
}