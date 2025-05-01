import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../bloc/edit_profile_bloc.dart';
import '../bloc/edit_profile_event.dart';
import '../bloc/edit_profile_state.dart';
import '../../../profile/data/models/user_model.dart';

class EditProfileScreen extends StatefulWidget {
  final User user;

  const EditProfileScreen({Key? key, required this.user}) : super(key: key);

  @override
  _EditProfileScreenState createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _firstNameController;
  late TextEditingController _lastNameController;
  late TextEditingController _emailController;
  late TextEditingController _phoneController;
  late TextEditingController _birthDateController;
  late TextEditingController _heightController;
  late TextEditingController _weightController;

  String _selectedGender = 'male';
  String _selectedBloodType = 'A+';
  bool _isLoading = false;

  final Color _primaryColor = const Color(0xFF006272);
  final Color _accentColor = const Color(0xFFE0F7FA);

  @override
  void initState() {
    super.initState();
    _firstNameController = TextEditingController(text: widget.user.firstName);
    _lastNameController = TextEditingController(text: widget.user.lastName);
    _emailController = TextEditingController(text: widget.user.email);
    _phoneController = TextEditingController(text: widget.user.phoneNumber);
    _birthDateController = TextEditingController(text: widget.user.dateOfBirth);
    _heightController = TextEditingController(text: '170');
    _weightController = TextEditingController(text: '70');
  }

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _birthDateController.dispose();
    _heightController.dispose();
    _weightController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [_accentColor.withOpacity(0.4), Colors.white],
          ),
        ),
        child: SafeArea(
          child: CustomScrollView(
            slivers: [
              SliverToBoxAdapter(
                child: Column(
                  children: [
                    const SizedBox(height: 20),
                    _buildProfileHeader(),
                    const SizedBox(height: 20),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: BlocListener<EditProfileBloc, EditProfileState>(
                        listener: (context, state) {
                          if (state is EditProfileSuccess) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text('profile_updated_successfully'.tr()),
                                backgroundColor: Colors.green,
                                behavior: SnackBarBehavior.floating,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                              ),
                            );
                            Navigator.pop(context, true);
                          } else if (state is EditProfileFailure) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(state.message),
                                backgroundColor: Colors.red,
                                behavior: SnackBarBehavior.floating,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                              ),
                            );
                          }
                        },
                        child: Form(
                          key: _formKey,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              _buildSectionCard(
                                title: 'personal_info'.tr(),
                                children: [
                                  _buildTextField(
                                    controller: _firstNameController,
                                    label: 'first_name'.tr(),
                                    icon: Icons.person,
                                  ),
                                  const SizedBox(height: 16),
                                  _buildTextField(
                                    controller: _lastNameController,
                                    label: 'last_name'.tr(),
                                    icon: Icons.person_outline,
                                  ),
                                  const SizedBox(height: 16),
                                  _buildTextField(
                                    controller: _emailController,
                                    label: 'email'.tr(),
                                    icon: Icons.email,
                                    keyboardType: TextInputType.emailAddress,
                                  ),
                                  const SizedBox(height: 16),
                                  _buildTextField(
                                    controller: _phoneController,
                                    label: 'phone'.tr(),
                                    icon: Icons.phone,
                                    keyboardType: TextInputType.phone,
                                  ),
                                ],
                              ),
                              const SizedBox(height: 24),
                              _buildSectionCard(
                                title: 'health_info'.tr(),
                                children: [
                                  _buildTextField(
                                    controller: _birthDateController,
                                    label: 'birthdate'.tr(),
                                    icon: Icons.cake,
                                    readOnly: true,
                                    onTap: _selectBirthDate,
                                  ),
                                  const SizedBox(height: 16),
                                  _buildDropdownGender(),
                                  const SizedBox(height: 16),
                                  _buildDropdownBloodType(),
                                  const SizedBox(height: 16),
                                  _buildTextField(
                                    controller: _heightController,
                                    label: 'height'.tr(),
                                    icon: Icons.height,
                                    keyboardType: TextInputType.number,
                                  ),
                                  const SizedBox(height: 16),
                                  _buildTextField(
                                    controller: _weightController,
                                    label: 'weight'.tr(),
                                    icon: Icons.fitness_center,
                                    keyboardType: TextInputType.number,
                                  ),
                                ],
                              ),
                              const SizedBox(height: 32),
                              _buildSaveButton(),
                              const SizedBox(height: 20),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildProfileHeader() {
    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: _primaryColor.withOpacity(0.3),
                blurRadius: 15,
                spreadRadius: 5,
              ),
            ],
          ),
          // child: CircleAvatar(
          //   radius: 50,
          //   backgroundImage: widget.user.profileImage != null
          //       ? NetworkImage(widget.user.profileImage!)
          //       : const AssetImage('assets/default_profile.png') as ImageProvider,
          // ),
        ),
        const SizedBox(height: 12),
        Text(
          'edit_profile'.tr(),
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: _primaryColor,
          ),
        ),
      ],
    );
  }

  Widget _buildSectionCard({required String title, required List<Widget> children}) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 8.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Colors.white.withOpacity(0.9),
        boxShadow: [
          BoxShadow(
            color: _primaryColor.withOpacity(0.1),
            blurRadius: 10,
            spreadRadius: 2,
          ),
        ],
      ),
      padding: const EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: _primaryColor,
            ),
          ),
          const SizedBox(height: 16),
          ...children,
        ],
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required IconData icon,
    TextInputType? keyboardType,
    bool readOnly = false,
    VoidCallback? onTap,
  }) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: _accentColor.withOpacity(0.3),
        border: Border.all(color: _primaryColor.withOpacity(0.2)),
      ),
      child: TextFormField(
        controller: controller,
        keyboardType: keyboardType,
        readOnly: readOnly,
        onTap: onTap,
        decoration: InputDecoration(
          labelText: label,
          labelStyle: TextStyle(color: _primaryColor.withOpacity(0.7)),
          prefixIcon: Icon(icon, color: _primaryColor),
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 18),
        ),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'field_required'.tr();
          }
          return null;
        },
      ),
    );
  }

  Widget _buildDropdownGender() {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: _accentColor.withOpacity(0.3),
        border: Border.all(color: _primaryColor.withOpacity(0.2)),
      ),
      child: DropdownButtonFormField<String>(
        value: _selectedGender,
        items: ['male', 'female'].map((gender) {
          return DropdownMenuItem(
            value: gender,
            child: Text(gender.tr()),
          );
        }).toList(),
        onChanged: (value) {
          setState(() {
            _selectedGender = value ?? 'male';
          });
        },
        decoration: InputDecoration(
          labelText: 'gender'.tr(),
          labelStyle: TextStyle(color: _primaryColor.withOpacity(0.7)),
          prefixIcon: Icon(Icons.person, color: _primaryColor),
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 18),
        ),
      ),
    );
  }

  Widget _buildDropdownBloodType() {
    final bloodTypes = ['A+', 'A-', 'B+', 'B-', 'AB+', 'AB-', 'O+', 'O-'];
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: _accentColor.withOpacity(0.3),
        border: Border.all(color: _primaryColor.withOpacity(0.2)),
      ),
      child: DropdownButtonFormField<String>(
        value: _selectedBloodType,
        items: bloodTypes.map((blood) {
          return DropdownMenuItem(
            value: blood,
            child: Text(blood),
          );
        }).toList(),
        onChanged: (value) {
          setState(() {
            _selectedBloodType = value ?? 'A+';
          });
        },
        decoration: InputDecoration(
          labelText: 'blood_type'.tr(),
          labelStyle: TextStyle(color: _primaryColor.withOpacity(0.7)),
          prefixIcon: Icon(Icons.bloodtype, color: _primaryColor),
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 18),
        ),
      ),
    );
  }

  Widget _buildSaveButton() {
    return GestureDetector(
      onTap: _isLoading ? null : _onSavePressed,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 32.0),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [_primaryColor, _primaryColor.withOpacity(0.8)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: _primaryColor.withOpacity(0.4),
              blurRadius: 10,
              spreadRadius: 2,
            ),
          ],
        ),
        child: Center(
          child: _isLoading
              ? const SizedBox(
                  width: 24,
                  height: 24,
                  child: CircularProgressIndicator(
                    color: Colors.white,
                    strokeWidth: 2.5,
                  ),
                )
              : Text(
                  'save'.tr(),
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
        ),
      ),
    );
  }

  Future<void> _selectBirthDate() async {
    DateTime initialDate = DateTime.tryParse(_birthDateController.text) ?? DateTime(2000);
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: initialDate,
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.light(
              primary: _primaryColor,
              onPrimary: Colors.white,
              onSurface: Colors.black87,
            ),
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(
                foregroundColor: _primaryColor,
              ),
            ),
          ),
          child: child!,
        );
      },
    );
    if (pickedDate != null) {
      _birthDateController.text = DateFormat('yyyy-MM-dd').format(pickedDate);
    }
  }

  Future<void> _onSavePressed() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
      });
      final prefs = await SharedPreferences.getInstance();
      final patientId = prefs.getInt('patient_id');
      if (patientId != null) {
        context.read<EditProfileBloc>().add(
              UpdateProfile(
                patientId: patientId,
                firstName: _firstNameController.text.trim(),
                lastName: _lastNameController.text.trim(),
                email: _emailController.text.trim(),
                phone: _phoneController.text.trim(),
                emergencyContactPhone: _phoneController.text.trim(),
                birthDate: _birthDateController.text.trim(),
                gender: _selectedGender,
                bloodType: _selectedBloodType,
                height: _heightController.text.trim(),
                weight: _weightController.text.trim(),
              ),
            );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('error_loading_auth_data'.tr()),
            backgroundColor: Colors.red,
            behavior: SnackBarBehavior.floating,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          ),
        );
      }
      setState(() {
        _isLoading = false;
      });
    }
  }
}