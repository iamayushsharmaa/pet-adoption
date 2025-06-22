import 'package:flutter/material.dart';
import 'package:petadoption/core/constant.dart';

import '../../../../core/common/widget/pet_card.dart';
import '../../../../theme/app_colors.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textColor = theme.textTheme.bodyLarge?.color ?? AppColors.black;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Home',
          style: TextStyle(fontWeight: FontWeight.bold, color: textColor),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              decoration: BoxDecoration(
                color: theme.inputDecorationTheme.fillColor ?? theme.cardColor,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.grey.shade300),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: const TextField(
                decoration: InputDecoration(
                  icon: Icon(Icons.search, color: Colors.grey),
                  hintText: 'Search...',
                  border: InputBorder.none,
                ),
              ),
            ),
            const SizedBox(height: 20),
            Text(
              'Pets',
              style: TextStyle(
                fontSize: 22,
                color: textColor,
                fontWeight: FontWeight.w800,
              ),
            ),
            const SizedBox(height: 10),
            ListView.builder(
              itemCount: mockPets.length,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                final pet = mockPets[index];
                return PetCard(
                  pet: pet,
                  onPetClicked: (clickedPet) {
                    print('Clicked on: ${clickedPet.name}');
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
