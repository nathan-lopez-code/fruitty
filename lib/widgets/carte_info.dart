import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class InfoCard extends StatelessWidget {
  final String title;
  final String content;
  final IconData icon;
  final Color cardColor;

  const InfoCard({
    super.key,
    required this.title,
    required this.content,
    required this.icon,
    this.cardColor = Colors.white,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      color: cardColor,
      margin: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 10.0),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(
                  icon,
                  color: Colors.deepOrange,
                  size: 20,
                ),
                const SizedBox(width: 10),
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Poppins',
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Text(
              content,
              style: const TextStyle(
                fontSize: 14,
                color: Colors.black54,
                fontFamily: 'Poppins',
              ),
            ),
          ],
        ),
      ),
    );
  }
}