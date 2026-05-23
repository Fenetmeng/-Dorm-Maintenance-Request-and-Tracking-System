class FeedbackModel {
  final int? id;
  final int requestId;
  final String requestTitle;
  final String userName;
  final String userEmail;
  final int rating;
  final String comment;
  final String createdAt;

  const FeedbackModel({
    this.id,
    required this.requestId,
    required this.requestTitle,
    required this.userName,
    required this.userEmail,
    required this.rating,
    required this.comment,
    required this.createdAt,
  });

  factory FeedbackModel.fromMap(Map<String, dynamic> map) {
    return FeedbackModel(
      id: map['id'] as int?,
      requestId: map['requestId'] as int,
      requestTitle: map['requestTitle'] as String? ?? 'Maintenance Request',
      userName: map['userName'] as String? ?? 'User',
      userEmail: map['userEmail'] as String? ?? '',
      rating: map['rating'] as int,
      comment: map['comment'] as String,
      createdAt: map['createdAt'] as String,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'requestId': requestId,
      'requestTitle': requestTitle,
      'userName': userName,
      'userEmail': userEmail,
      'rating': rating,
      'comment': comment,
      'createdAt': createdAt,
    };
  }

  FeedbackModel copyWith({
    int? id,
    int? requestId,
    String? requestTitle,
    String? userName,
    String? userEmail,
    int? rating,
    String? comment,
    String? createdAt,
  }) {
    return FeedbackModel(
      id: id ?? this.id,
      requestId: requestId ?? this.requestId,
      requestTitle: requestTitle ?? this.requestTitle,
      userName: userName ?? this.userName,
      userEmail: userEmail ?? this.userEmail,
      rating: rating ?? this.rating,
      comment: comment ?? this.comment,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}