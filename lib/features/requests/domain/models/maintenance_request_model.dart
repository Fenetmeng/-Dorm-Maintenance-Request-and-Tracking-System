class MaintenanceRequestModel {
  final int? id;
  final String title;
  final String category;
  final String location;
  final String roomNumber;
  final String description;
  final String status;
  final String dateRequested;
  final String userEmail;
  final String? imagePath;

  const MaintenanceRequestModel({
    this.id,
    required this.title,
    required this.category,
    required this.location,
    required this.roomNumber,
    required this.description,
    this.status = 'Pending',
    required this.dateRequested,
    required this.userEmail,
    this.imagePath,
  });

  factory MaintenanceRequestModel.fromMap(Map<String, dynamic> map) {
    return MaintenanceRequestModel(
      id: map['id'] as int?,
      title: map['title'] as String,
      category: map['category'] as String,
      location: map['location'] as String,
      roomNumber: map['roomNumber'] as String,
      description: map['description'] as String,
      status: map['status'] as String,
      dateRequested: map['dateRequested'] as String,
      userEmail: map['userEmail'] as String,
      imagePath: map['imagePath'] as String?,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'category': category,
      'location': location,
      'roomNumber': roomNumber,
      'description': description,
      'status': status,
      'dateRequested': dateRequested,
      'userEmail': userEmail,
      'imagePath': imagePath,
    };
  }

  MaintenanceRequestModel copyWith({
    int? id,
    String? title,
    String? category,
    String? location,
    String? roomNumber,
    String? description,
    String? status,
    String? dateRequested,
    String? userEmail,
    String? imagePath,
  }) {
    return MaintenanceRequestModel(
      id: id ?? this.id,
      title: title ?? this.title,
      category: category ?? this.category,
      location: location ?? this.location,
      roomNumber: roomNumber ?? this.roomNumber,
      description: description ?? this.description,
      status: status ?? this.status,
      dateRequested: dateRequested ?? this.dateRequested,
      userEmail: userEmail ?? this.userEmail,
      imagePath: imagePath ?? this.imagePath,
    );
  }
}