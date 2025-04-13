import 'package:flutter/material.dart';
import '../widgets/search_input_field.dart';
import '../widgets/doctor_card.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            const SearchInputField(),
            const SizedBox(height: 16),
            Expanded(
              child: ListView.builder(
                itemCount: 5,
                itemBuilder: (context, index) {
                  return DoctorCard(
                    name: 'د. جون دو',
                    specialty: 'أخصائي قلب',
                    rating: 4.5,
                    experience: '10 سنوات',
                    nextAppointment: 'غدًا، 10:00 صباحًا',
                    onTap: () {
                      Navigator.pushNamed(context, '/doctorProfile');
                    },
                    onBook: () {
                      // حجز موعد
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
