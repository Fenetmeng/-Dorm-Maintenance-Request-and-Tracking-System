class AssignmentModel {
  final int? id;
  final int requestId;
  final String staffName;
  final String staffRole;
  final String status;
  final String assignedDate;

  const AssignmentModel({
    this.id,
    required this.requestId,
    required this.staffName,
    required this.staffRole,
    required this.status,
    required this.assignedDate,
  });

  factory AssignmentModel.fromMap(Map<String, dynamic> map) {
    return AssignmentModel(
      id: map['id'] as int?,
      requestId: map['requestId'] as int,
      staffName: map['staffName'] as String,
      staffRole: map['staffRole'] as String,
      status: map['status'] as String,
      assignedDate: map['assignedDate'] as String,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'requestId': requestId,
      'staffName': staffName,
      'staffRole': staffRole,
      'status': status,
      'assignedDate': assignedDate,
    };
  }

  AssignmentModel copyWith({
    int? id,
    int? requestId,
    String? staffName,
    String? staffRole,
    String? status,
    String? assignedDate,
  }) {
    return AssignmentModel(
      id: id ?? this.id,
      requestId: requestId ?? this.requestId,
      staffName: staffName ?? this.staffName,
      staffRole: staffRole ?? this.staffRole,
      status: status ?? this.status,
      assignedDate: assignedDate ?? this.assignedDate,
    );
  }
}