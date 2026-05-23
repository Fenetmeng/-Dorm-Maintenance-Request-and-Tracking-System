class StaffModel {
  final int? id;
  final String name;
  final String role;
  final String phone;

  const StaffModel({
    this.id,
    required this.name,
    required this.role,
    required this.phone,
  });

  factory StaffModel.fromMap(Map<String, dynamic> map) {
    return StaffModel(
      id: map['id'] as int?,
      name: map['name'] as String,
      role: map['role'] as String,
      phone: map['phone'] as String,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'role': role,
      'phone': phone,
    };
  }

  StaffModel copyWith({
    int? id,
    String? name,
    String? role,
    String? phone,
  }) {
    return StaffModel(
      id: id ?? this.id,
      name: name ?? this.name,
      role: role ?? this.role,
      phone: phone ?? this.phone,
    );
  }
}