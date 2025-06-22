import 'package:flutter/material.dart';
import 'package:petadoption/core/entities/pet_entity.dart';

class PetCard extends StatelessWidget {
  final PetEntity pet;
  final Function(PetEntity pet) onPetClicked;

  const PetCard({super.key, required this.onPetClicked, required this.pet});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final textColor = theme.textTheme.bodyLarge?.color ?? Colors.black;
    final bgColor = pet.isAdopted
        ? Colors.grey.shade300.withOpacity(0.6)
        : theme.cardColor;

    return GestureDetector(
      onTap: pet.isAdopted ? null : () => onPetClicked(pet),
      child: Opacity(
        opacity: pet.isAdopted ? 0.5 : 1.0,
        child: LayoutBuilder(
          builder: (context, constraints) {
            return Container(
              height: 160,
              margin: const EdgeInsets.only(bottom: 16),
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: bgColor,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: isDark
                        ? Colors.black.withOpacity(0.4)
                        : Colors.black.withOpacity(0.07),
                    blurRadius: 12,
                    offset: const Offset(0, 6),
                  ),
                ],
              ),
              child: Row(
                children: [
                  Hero(
                    tag: 'petImage-${pet.id}',
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: Image.network(
                        pet.imageUrl,
                        height: double.infinity,
                        width: constraints.maxWidth > 400 ? 300 : 110,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) => Container(
                          color: Colors.grey.shade300,
                          width: constraints.maxWidth > 400 ? 300 : 110,
                          height: double.infinity,
                          child: const Icon(Icons.pets, size: 40),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 14),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              pet.age,
                              style: theme.textTheme.bodyMedium?.copyWith(
                                fontSize: 13,
                                color: isDark
                                    ? Colors.grey[400]
                                    : Colors.grey[700],
                              ),
                            ),
                            const SizedBox(width: 10),
                            if (pet.isAdopted)
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 10,
                                  vertical: 4,
                                ),
                                decoration: BoxDecoration(
                                  color: Colors.grey.shade700,
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: const Text(
                                  'Adopted',
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        Text(
                          pet.name,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: theme.textTheme.titleLarge?.copyWith(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            color: textColor,
                          ),
                        ),
                        const SizedBox(height: 12),
                        Row(
                          children: [
                            Text(
                              'Price: ',
                              style: theme.textTheme.bodyMedium?.copyWith(
                                fontSize: 14,
                                color: isDark
                                    ? Colors.grey[400]
                                    : Colors.grey[700],
                              ),
                            ),
                            Expanded(
                              child: Text(
                                '₹${pet.price.toStringAsFixed(0)}',
                                style: theme.textTheme.bodyLarge?.copyWith(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w600,
                                  color: textColor,
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ),
                        const Spacer(),
                        Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 12,
                                vertical: 5,
                              ),
                              decoration: BoxDecoration(
                                color: theme.colorScheme.primary.withOpacity(
                                  isDark ? 0.08 : 0.12,
                                ),
                                borderRadius: BorderRadius.circular(16),
                                border: Border.all(
                                  color: theme.colorScheme.primary.withOpacity(
                                    isDark ? 0.25 : 0.4,
                                  ),
                                ),
                              ),
                              child: Text(
                                pet.breed,
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                  color: theme.colorScheme.primary,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
