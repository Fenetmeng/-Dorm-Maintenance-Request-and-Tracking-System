import 'package:flutter/material.dart';

class AdminStatCard extends StatelessWidget {
  final String number;
  final String label;
  final Color numberColor;

  const AdminStatCard({
    super.key,
    required this.number,
    required this.label,
    required this.numberColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 92,
      height: 72,
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: const Color(0xFFE5E5E5),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            number,
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w700,
              color: numberColor,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            label,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 10,
              color: Color(0xFF333333),
            ),
          ),
        ],
      ),
    );
  }
}