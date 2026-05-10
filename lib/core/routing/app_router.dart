import 'package:go_router/go_router.dart';

import '../../features/auth/presentation/screens/welcome_screen.dart';
import '../../features/auth/presentation/screens/login_screen.dart';
import '../../features/auth/presentation/screens/signup_screen.dart';
import '../../features/auth/presentation/screens/forgot_password_screen.dart';
import '../../features/home/presentation/screens/home_screen.dart';
import '../../features/requests/presentation/screens/new_request_screen.dart';
import '../../features/requests/presentation/screens/request_list_screen.dart';
import '../../features/requests/presentation/screens/request_details_screen.dart';
import '../../features/requests/presentation/screens/edit_request_screen.dart';
import '../../features/profile/presentation/screens/profile_screen.dart';
import '../../features/admin/presentation/screens/admin_overview_screen.dart';
import '../../features/admin/presentation/screens/all_requests_screen.dart';
import '../../features/admin/presentation/screens/assign_task_screen.dart';
import '../../features/admin/presentation/screens/staff_workload_screen.dart';
import '../../features/admin/presentation/screens/all_feedback_screen.dart';
import '../../features/admin/presentation/screens/feedback_screen.dart';

final GoRouter appRouter = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const WelcomeScreen(),
    ),
    GoRoute(
      path: '/login',
      builder: (context, state) => const LoginScreen(),
    ),
    GoRoute(
      path: '/signup',
      builder: (context, state) => const SignupScreen(),
    ),
    GoRoute(
      path: '/forgot-password',
      builder: (context, state) => const ForgotPasswordScreen(),
    ),
    GoRoute(
      path: '/home',
      builder: (context, state) => const HomeScreen(),
    ),
    GoRoute(
      path: '/new-request',
      builder: (context, state) => const NewRequestScreen(),
    ),
    GoRoute(
     path: '/requests',
     builder: (context, state) => const RequestListScreen(),
),
    GoRoute(
     path: '/request-details',
     builder: (context, state) => const RequestDetailsScreen(),
),
    GoRoute(
     path: '/edit-request',
     builder: (context, state) => const EditRequestScreen(),
),
    GoRoute(
     path: '/profile',
     builder: (context, state) => const ProfileScreen(),
),
    GoRoute(
     path: '/admin-overview',
     builder: (context, state) => const AdminOverviewScreen(),
),
    GoRoute(
     path: '/admin-requests',
     builder: (context, state) => const AllRequestsScreen(),
),
    GoRoute(
     path: '/assign-task',
     builder: (context, state) => const AssignTaskScreen(),
),
    GoRoute(
     path: '/staff-workload',
     builder: (context, state) => const StaffWorkloadScreen(),
),
    GoRoute(
    path: '/all-feedback',
    builder: (context, state) => const AllFeedbackScreen(),
),
    GoRoute(
    path: '/feedback',
    builder: (context, state) => const FeedbackScreen(),
),
  ],
);