import 'package:doctorapp/screens/doctor/edit_profile_screen.dart';
import 'package:flutter/material.dart';

class DoctorProfileScreen extends StatelessWidget {
  const DoctorProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('الملف الشخصي'),
        backgroundColor: Colors.teal.shade700,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            // صورة الطبيب ومعلومات أساسية
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.3),
                    spreadRadius: 2,
                    blurRadius: 7,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: Column(
                children: [
                  const CircleAvatar(
                    radius: 50,
                    backgroundImage: AssetImage(
                      'assets/images/doctor.png',
                    ), // تأكد من وجود الصورة في المسار
                    backgroundColor: Colors.teal,
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    'د. أحمد محمد',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Colors.teal,
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'أخصائي أمراض باطنية',
                    style: TextStyle(fontSize: 16, color: Colors.grey),
                  ),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      _buildInfoItem(Icons.star, '4.9', 'التقييم'),
                      _buildInfoItem(
                        Icons.medical_services,
                        '10',
                        'سنوات الخبرة',
                      ),
                      _buildInfoItem(Icons.people, '1200+', 'مرضى'),
                    ],
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            // معلومات الاتصال
            _buildSectionCard(
              title: 'معلومات الاتصال',
              children: [
                _buildInfoRow(Icons.phone, '0123456789'),
                _buildInfoRow(Icons.email, 'doctor@example.com'),
                _buildInfoRow(Icons.location_on, 'القاهرة، مصر'),
                _buildInfoRow(Icons.access_time, 'ساعات العمل: 9 ص - 5 م'),
              ],
            ),

            const SizedBox(height: 20),

            // معلومات التخصص
            _buildSectionCard(
              title: 'التخصص والمؤهلات',
              children: [
                _buildQualificationItem(
                  'دكتوراه في الطب الباطني',
                  'جامعة القاهرة - 2015',
                ),
                _buildQualificationItem('زمالة الكلية الملكية', 'لندن - 2018'),
                _buildQualificationItem(
                  'بورد أمراض الجهاز الهضمي',
                  'أمريكا - 2020',
                ),
              ],
            ),

            const SizedBox(height: 20),

            // أزرار التحكم
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const EditProfileScreen(),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.teal.shade700,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: const Text(
                  'تعديل الملف الشخصي',
                  style: TextStyle(fontSize: 16),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // دالة مساعدة لعنصر المعلومات
  Widget _buildInfoItem(IconData icon, String value, String label) {
    return Column(
      children: [
        Icon(icon, color: Colors.teal, size: 28),
        const SizedBox(height: 4),
        Text(
          value,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        Text(label, style: const TextStyle(fontSize: 12, color: Colors.grey)),
      ],
    );
  }

  // دالة مساعدة لصف المعلومات
  Widget _buildInfoRow(IconData icon, String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Icon(icon, color: Colors.teal),
          const SizedBox(width: 12),
          Text(text, style: const TextStyle(fontSize: 16)),
        ],
      ),
    );
  }

  // دالة مساعدة لعنصر المؤهل
  Widget _buildQualificationItem(String title, String subtitle) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading: const Icon(Icons.medical_information, color: Colors.teal),
      title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
      subtitle: Text(subtitle, style: const TextStyle(color: Colors.grey)),
    );
  }

  // دالة مساعدة لإنشاء بطاقة قسم
  Widget _buildSectionCard({
    required String title,
    required List<Widget> children,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 1,
            blurRadius: 5,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.teal,
            ),
          ),
          const SizedBox(height: 12),
          ...children,
        ],
      ),
    );
  }
}
