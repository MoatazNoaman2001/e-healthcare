import 'package:flutter/material.dart';

class MedicalRecordScreen extends StatelessWidget {
  const MedicalRecordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(title: const Text('السجل الطبي'), centerTitle: true),
        body: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // معلومات عامة
                _buildSectionTitle(context, 'المعلومات الأساسية'),
                const SizedBox(height: 8),
                _buildInfoCard(
                  child: Column(
                    children: [
                      _buildInfoRow('الاسم', 'محمد أحمد محمود'),
                      const SizedBox(height: 8),
                      _buildInfoRow('العمر', '35 سنة'),
                      const SizedBox(height: 8),
                      _buildInfoRow('فصيلة الدم', 'O+'),
                      const SizedBox(height: 8),
                      _buildInfoRow('الطول', '175 سم'),
                      const SizedBox(height: 8),
                      _buildInfoRow('الوزن', '75 كجم'),
                    ],
                  ),
                ),
                const SizedBox(height: 20),

                // الأمراض المزمنة
                _buildSectionTitle(context, 'الأمراض المزمنة'),
                const SizedBox(height: 8),
                _buildInfoCard(
                  child: Column(
                    children: [
                      _buildChronicDiseaseItem(
                        'ارتفاع ضغط الدم',
                        'تم التشخيص في 2020',
                      ),
                      const Divider(height: 24),
                      _buildChronicDiseaseItem(
                        'السكري من النوع الثاني',
                        'تم التشخيص في 2019',
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),

                // الحساسية
                _buildSectionTitle(context, 'الحساسية'),
                const SizedBox(height: 8),
                _buildInfoCard(
                  child: Column(
                    children: [
                      _buildAllergyItem('البنسلين'),
                      const Divider(height: 24),
                      _buildAllergyItem('المكسرات'),
                      const Divider(height: 24),
                      _buildAllergyItem('غبار الطلع'),
                    ],
                  ),
                ),
                const SizedBox(height: 20),

                // العمليات الجراحية
                _buildSectionTitle(context, 'العمليات الجراحية'),
                const SizedBox(height: 8),
                _buildInfoCard(
                  child: Column(
                    children: [
                      _buildSurgeryItem(
                        'استئصال الزائدة الدودية',
                        'يناير 2018',
                        'مستشفى المواساة',
                        'د. محمد سعيد - جراح عام',
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),

                // الأدوية الحالية
                _buildSectionTitle(context, 'الأدوية الحالية'),
                const SizedBox(height: 8),
                _buildInfoCard(
                  child: Column(
                    children: [
                      _buildMedicationItem(
                        'كونكور',
                        '5 مجم',
                        'قرص واحد يومياً صباحاً',
                        'لعلاج ارتفاع ضغط الدم',
                      ),
                      const Divider(height: 24),
                      _buildMedicationItem(
                        'جلوكوفاج',
                        '500 مجم',
                        'قرص مرتين يومياً بعد الطعام',
                        'لعلاج السكري',
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),

                // الفحوصات الأخيرة
                _buildSectionTitle(context, 'الفحوصات الأخيرة'),
                const SizedBox(height: 8),
                _buildInfoCard(
                  child: Column(
                    children: [
                      _buildLabTestItem(
                        'تحليل الدم الشامل',
                        'مارس 2023',
                        'تم إرفاق النتائج',
                      ),
                      const Divider(height: 24),
                      _buildLabTestItem(
                        'أشعة على الصدر',
                        'فبراير 2023',
                        'لا توجد ملاحظات',
                      ),
                      const Divider(height: 24),
                      _buildLabTestItem(
                        'تحليل السكر التراكمي',
                        'يناير 2023',
                        'النتيجة 7.1% (مرتفع قليلاً)',
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),

                // التطعيمات
                _buildSectionTitle(context, 'التطعيمات'),
                const SizedBox(height: 8),
                _buildInfoCard(
                  child: Column(
                    children: [
                      _buildVaccinationItem(
                        'كوفيد-19',
                        'الجرعة الأولى: يناير 2021\nالجرعة الثانية: مارس 2021\nالجرعة المنشطة: ديسمبر 2021',
                      ),
                      const Divider(height: 24),
                      _buildVaccinationItem(
                        'الإنفلونزا الموسمية',
                        'آخر جرعة: سبتمبر 2022',
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 32),

                // زر تحميل التقرير
                Center(
                  child: SizedBox(
                    width: double.infinity,
                    child: ElevatedButton.icon(
                      onPressed: () {
                        // تحميل التقرير الطبي كامل
                      },
                      icon: const Icon(Icons.download),
                      label: const Text('تحميل التقرير الطبي كامل'),
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 12),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSectionTitle(BuildContext context, String title) {
    return Row(
      children: [
        Icon(
          Icons.local_hospital,
          color: Theme.of(context).colorScheme.primary,
          size: 20,
        ),
        const SizedBox(width: 8),
        Text(
          title,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Theme.of(context).colorScheme.primary,
          ),
        ),
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
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: TextStyle(fontSize: 16, color: Colors.grey.shade700),
        ),
        Text(
          value,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
      ],
    );
  }

  Widget _buildChronicDiseaseItem(String disease, String diagnosis) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Icon(Icons.medical_information, color: Colors.red, size: 20),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                disease,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                diagnosis,
                style: TextStyle(fontSize: 14, color: Colors.grey.shade600),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildAllergyItem(String allergy) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const Icon(Icons.warning_amber, color: Colors.amber, size: 20),
        const SizedBox(width: 12),
        Text(
          allergy,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
      ],
    );
  }

  Widget _buildSurgeryItem(
    String surgery,
    String date,
    String hospital,
    String doctor,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            const Icon(Icons.medical_services, color: Colors.blue, size: 20),
            const SizedBox(width: 12),
            Text(
              surgery,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ],
        ),
        const SizedBox(height: 8),
        Padding(
          padding: const EdgeInsets.only(right: 32),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'التاريخ: $date',
                style: TextStyle(fontSize: 14, color: Colors.grey.shade600),
              ),
              const SizedBox(height: 4),
              Text(
                'المستشفى: $hospital',
                style: TextStyle(fontSize: 14, color: Colors.grey.shade600),
              ),
              const SizedBox(height: 4),
              Text(
                'الطبيب: $doctor',
                style: TextStyle(fontSize: 14, color: Colors.grey.shade600),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildMedicationItem(
    String name,
    String dose,
    String instruction,
    String purpose,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            const Icon(Icons.medication, color: Colors.green, size: 20),
            const SizedBox(width: 12),
            Text(
              '$name ($dose)',
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ],
        ),
        const SizedBox(height: 8),
        Padding(
          padding: const EdgeInsets.only(right: 32),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'الجرعة: $instruction',
                style: TextStyle(fontSize: 14, color: Colors.grey.shade600),
              ),
              const SizedBox(height: 4),
              Text(
                'الغرض: $purpose',
                style: TextStyle(fontSize: 14, color: Colors.grey.shade600),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildLabTestItem(String test, String date, String result) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Icon(Icons.science, color: Colors.purple, size: 20),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                test,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                'التاريخ: $date',
                style: TextStyle(fontSize: 14, color: Colors.grey.shade600),
              ),
              const SizedBox(height: 4),
              Text(
                'النتيجة: $result',
                style: TextStyle(fontSize: 14, color: Colors.grey.shade600),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildVaccinationItem(String vaccine, String dates) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Icon(Icons.vaccines, color: Colors.teal, size: 20),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                vaccine,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                dates,
                style: TextStyle(fontSize: 14, color: Colors.grey.shade600),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
