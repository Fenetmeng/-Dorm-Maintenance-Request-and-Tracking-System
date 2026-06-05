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
import '../../features/feedback/presentation/screens/feedback_screen.dart';
import 'app_routes.dart';

final GoRouter appRouter = GoRouter(
  initialLocation: AppRoutes.welcome,
  routes: [
    GoRoute(
      path: AppRoutes.welcome,
      builder: (context, state) => const WelcomeScreen(),
    ),
    GoRoute(
      path: AppRoutes.login,
      builder: (context, state) => const LoginScreen(),
    ),
    GoRoute(
      path: AppRoutes.signup,
      builder: (context, state) => const SignupScreen(),
    ),
    GoRoute(
      path: AppRoutes.forgotPassword,
      builder: (context, state) => const ForgotPasswordScreen(),
    ),
    GoRoute(
      path: AppRoutes.home,
      builder: (context, state) => const HomeScreen(),
    ),
    GoRoute(
      path: AppRoutes.newRequest,
      builder: (context, state) => const NewRequestScreen(),
    ),
    GoRoute(
      path: AppRoutes.requests,
      builder: (context, state) => const RequestListScreen(),
    ),
    GoRoute(
      path: AppRoutes.requestDetails,
      builder: (context, state) => const RequestDetailsScreen(),
    ),
    GoRoute(
      path: AppRoutes.editRequest,
      builder: (context, state) => const EditRequestScreen(),
    ),
    GoRoute(
      path: AppRoutes.profile,
      builder: (context, state) => const ProfileScreen(),
    ),
    GoRoute(
      path: AppRoutes.adminOverview,
      builder: (context, state) => const AdminOverviewScreen(),
    ),
    GoRoute(
      path: AppRoutes.adminRequests,
      builder: (context, state) => const AllRequestsScreen(),
    ),
    GoRoute(
      path: AppRoutes.assignTask,
      builder: (context, state) => const AssignTaskScreen(),
    ),
    GoRoute(
      path: AppRoutes.staffWorkload,
      builder: (context, state) => const StaffWorkloadScreen(),
    ),
    GoRoute(
      path: AppRoutes.allFeedback,
      builder: (context, state) => const AllFeedbackScreen(),
    ),
    GoRoute(
      path: AppRoutes.feedback,
      builder: (context, state) => const FeedbackScreen(),
    ),
  ],
);
