import 'package:flutter/material.dart';

class WorkloadCard extends StatelessWidget {
  final String name;
  final String role;
  final String inProgress;
  final String completed;

  const WorkloadCard({
    super.key,
    required this.name,
    required this.role,
    required this.inProgress,
    required this.completed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 18),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: const Color(0xFFE5E7EB)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 8,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: Text(
              '$name  |  $role',
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w700,
                color: Color(0xFF222222),
              ),
            ),
          ),
          const Icon(
            Icons.chevron_right,
            color: Color(0xFF999999),
          ),
          const SizedBox(width: 8),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                '$inProgress In Progress',
                style: const TextStyle(
                  fontSize: 10,
                  color: Color(0xFFF59E0B),
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 6),
              Text(
                '$completed Completed',
                style: const TextStyle(
                  fontSize: 10,
                  color: Color(0xFF22C55E),
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}