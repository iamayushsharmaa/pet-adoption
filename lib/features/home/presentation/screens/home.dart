import 'package:flutter/material.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Home',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              decoration: BoxDecoration(
                color:
                    Theme.of(context).inputDecorationTheme.fillColor ??
                    Theme.of(context).cardColor,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.grey.shade300),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: TextField(
                decoration: InputDecoration(
                  icon: const Icon(Icons.search, color: Colors.grey),
                  hintText: 'Search...',
                  border: InputBorder.none,
                ),
              ),
            ),

            const SizedBox(height: 20), // Spacer
            // You can add more widgets here...
          ],
        ),
      ),
    );
  }
}
