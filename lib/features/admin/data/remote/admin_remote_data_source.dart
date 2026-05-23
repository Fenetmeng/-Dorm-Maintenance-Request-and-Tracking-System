import '../../domain/models/staff_model.dart';

class AdminRemoteDataSource {
  Future<List<StaffModel>> fetchStaffFromNetwork() async {
    await Future.delayed(const Duration(milliseconds: 400));

    return const [
      StaffModel(
        name: 'Mike R.',
        role: 'Plumber',
        phone: '+251 911 111 111',
      ),
      StaffModel(
        name: 'Sarah L.',
        role: 'General',
        phone: '+251 922 222 222',
      ),
      StaffModel(
        name: 'David W.',
        role: 'Electrician',
        phone: '+251 933 333 333',
      ),
    ];
  }
}