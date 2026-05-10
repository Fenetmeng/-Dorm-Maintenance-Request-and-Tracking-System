import 'package:flutter/material.dart';

class FeedbackCard extends StatelessWidget {
  final String studentName;
  final String requestTitle;
  final String comment;
  final int rating;

  const FeedbackCard({
    super.key,
    required this.studentName,
    required this.requestTitle,
    required this.comment,
    required this.rating,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 18),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: const Color(0xFFE5E7EB)),
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 8,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const CircleAvatar(
                radius: 18,
                backgroundColor: Color(0xFFEAF3FF),
                child: Icon(
                  Icons.person,
                  size: 20,
                  color: Color(0xFF4285F4),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  studentName,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF222222),
                  ),
                ),
              ),
              Row(
                children: List.generate(
                  5,
                  (index) => Icon(
                    index < rating ? Icons.star : Icons.star_border,
                    size: 16,
                    color: const Color(0xFFF2B705),
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 10),

          Text(
            requestTitle,
            style: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: Color(0xFF4285F4),
            ),
          ),

          const SizedBox(height: 8),

          Text(
            comment,
            style: const TextStyle(
              fontSize: 12,
              height: 1.4,
              color: Color(0xFF555555),
            ),
          ),
        ],
      ),
    );
  }
}