import 'package:flutter/material.dart';

class Detail extends StatelessWidget {
  const Detail({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final priceBgColor = isDark ? Colors.grey[800] : Colors.grey[200];
    final priceTextColor = isDark ? Colors.white : Colors.black87;
    final buttonColor = isDark ? Colors.tealAccent[700] : Colors.teal;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Pet Details',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Center(
              child: CircleAvatar(
                radius: 160,
                backgroundImage: NetworkImage(
                  'https://images.unsplash.com/photo-1558788353-f76d92427f16',
                ),
              ),
            ),
            const SizedBox(height: 16),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Fluffy',
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                ),

                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 14,
                    vertical: 8,
                  ),
                  decoration: BoxDecoration(
                    color: priceBgColor,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    '\$120',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: priceTextColor,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),

            // Description
            const Text(
              'Fluffy is a playful and loving kitten who enjoys cuddles and chasing toys. She\'s looking for a forever home!',
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 24),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                IconText(icon: Icons.pets, label: 'Breed', value: 'Persian'),
                IconText(icon: Icons.female, label: 'Gender', value: 'Female'),
                IconText(
                  icon: Icons.calendar_today,
                  label: 'Age',
                  value: '2 yrs',
                ),
              ],
            ),
            const Spacer(),
            SizedBox(
              width: double.infinity,
              height: 55,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor:
                      Theme.of(context).brightness == Brightness.dark
                      ? Colors.white
                      : Colors.black,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                onPressed: () {
                  // Handle adoption
                },
                child: Text(
                  'Adopt Me',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).brightness == Brightness.dark
                        ? Colors.black
                        : Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class IconText extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;

  const IconText({
    super.key,
    required this.icon,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final backgroundColor = isDark ? Colors.grey[800] : Colors.grey[200];
    final iconColor = isDark ? Colors.white : Colors.black87;

    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: backgroundColor,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Icon(icon, size: 20, color: iconColor),
        ),
        const SizedBox(width: 8),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(label, style: Theme.of(context).textTheme.bodyMedium),
            Text(value, style: Theme.of(context).textTheme.bodyMedium),
          ],
        ),
      ],
    );
  }
}
