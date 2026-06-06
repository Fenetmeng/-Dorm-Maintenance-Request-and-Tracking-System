import 'package:flutter_test/flutter_test.dart';
import 'package:dormitory_app/features/requests/domain/models/maintenance_request_model.dart';

void main() {
  group('MaintenanceRequestModel Unit Test', () {
    test('should convert model to map correctly', () {
      final request = MaintenanceRequestModel(
        id: 1,
        title: 'Plumbing Issue',
        category: 'Plumbing',
        location: 'Gibe Hall',
        roomNumber: '204',
        description: 'Water leakage problem',
        status: 'Pending',
        dateRequested: '2026-01-01',
        userEmail: 'user@gmail.com',
        imagePath: 'http://localhost:3000/uploads/photo.jpg',
      );

      final map = request.toMap();

      expect(map['id'], 1);
      expect(map['title'], 'Plumbing Issue');
      expect(map['category'], 'Plumbing');
      expect(map['location'], 'Gibe Hall');
      expect(map['roomNumber'], '204');
      expect(map['description'], 'Water leakage problem');
      expect(map['status'], 'Pending');
      expect(map['userEmail'], 'user@gmail.com');
      expect(map['imagePath'], 'http://localhost:3000/uploads/photo.jpg');
    });

    test('should create model from map correctly', () {
      final map = {
        'id': 2,
        'title': 'Electricity Issue',
        'category': 'Electricity',
        'location': 'Tana Hall',
        'roomNumber': '110',
        'description': 'Light is not working',
        'status': 'Completed',
        'dateRequested': '2026-01-02',
        'userEmail': 'student@gmail.com',
        'imagePath': null,
      };

      final request = MaintenanceRequestModel.fromMap(map);

      expect(request.id, 2);
      expect(request.title, 'Electricity Issue');
      expect(request.category, 'Electricity');
      expect(request.location, 'Tana Hall');
      expect(request.roomNumber, '110');
      expect(request.description, 'Light is not working');
      expect(request.status, 'Completed');
      expect(request.userEmail, 'student@gmail.com');
      expect(request.imagePath, null);
    });
  });
}