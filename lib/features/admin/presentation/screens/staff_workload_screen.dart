import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/routing/app_routes.dart';

import '../../../../../core/constants/app_colors.dart';
import '../widgets/workload_card.dart';

class StaffWorkloadScreen extends StatelessWidget {
  const StaffWorkloadScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.lightBlue,
      body: Center(
        child: SizedBox(
          width: 390,
          height: double.infinity,
          child: Column(
            children: [
              Container(
                height: 72,
                width: double.infinity,
                color: AppColors.lightBlue,
                padding: const EdgeInsets.symmetric(horizontal: 18),
                child: Row(
                  children: [
                    IconButton(
                      onPressed: () {
                        context.go(AppRoutes.assignTask);
                      },
                      icon: const Icon(
                        Icons.arrow_back,
                        color: AppColors.primaryBlue,
                      ),
                    ),
                    const Expanded(
                      child: Center(
                        child: Text(
                          'STAFF WORKLOAD',
                          style: TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.w700,
                            color: AppColors.textBlack,
                            letterSpacing: 1,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 48),
                  ],
                ),
              ),

              Expanded(
                child: Container(
                  width: double.infinity,
                  color: Colors.white,
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.fromLTRB(28, 30, 28, 30),
                    child: Column(
                      children: const [
                        WorkloadCard(
                          name: 'Mike R.',
                          role: 'Plumber',
                          inProgress: '2',
                          completed: '15',
                        ),
                        WorkloadCard(
                          name: 'Sarah L.',
                          role: 'General',
                          inProgress: '1',
                          completed: '8',
                        ),
                        WorkloadCard(
                          name: 'David W.',
                          role: 'Electrician',
                          inProgress: '6',
                          completed: '22',
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
