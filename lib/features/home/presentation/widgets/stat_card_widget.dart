import 'package:flutter/material.dart';

class StatCardWidget extends StatelessWidget {
  final String number;
  final String label;
  final Color numberColor;

  const StatCardWidget({
    super.key,
    required this.number,
    required this.label,
    required this.numberColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 92,
      height: 95,
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.06),
            blurRadius: 10,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            number,
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: numberColor,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            label,
            textAlign: TextAlign.center,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              fontSize: 11,
              color: Color(0xFF444444),
              height: 1.1,
            ),
          ),
        ],
      ),
    );
  }
}