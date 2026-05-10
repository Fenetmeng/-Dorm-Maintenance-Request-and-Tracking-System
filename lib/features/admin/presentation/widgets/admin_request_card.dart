import 'package:flutter/material.dart';

class AdminRequestCard extends StatelessWidget {
  final String title;
  final String student;
  final String location;
  final String status;
  final String assignedTo;
  final VoidCallback? onTap;

  const AdminRequestCard({
    super.key,
    required this.title,
    required this.student,
    required this.location,
    required this.status,
    required this.assignedTo,
    this.onTap,
  });

  Color get statusColor {
    if (status.toLowerCase().contains('progress')) {
      return const Color(0xFFF59E0B);
    }
    if (status.toLowerCase().contains('completed')) {
      return const Color(0xFF22C55E);
    }
    return const Color(0xFFF2B705);
  }

  Color get statusBg {
    if (status.toLowerCase().contains('completed')) {
      return const Color(0xFFDFF8E8);
    }
    return const Color(0xFFFFF6D8);
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(14),
        margin: const EdgeInsets.only(bottom: 18),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: const Color(0xFFE5E7EB)),
        ),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                      color: Color(0xFF222222),
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    '$student • $location',
                    style: const TextStyle(
                      fontSize: 11,
                      color: Color(0xFF777777),
                    ),
                  ),
                ],
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: statusBg,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    status,
                    style: TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.w600,
                      color: statusColor,
                    ),
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  assignedTo,
                  style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.w600,
                    color: assignedTo.toLowerCase() == 'unassigned'
                        ? Colors.red
                        : const Color(0xFF3B82F6),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}