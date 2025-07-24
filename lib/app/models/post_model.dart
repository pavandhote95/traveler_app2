// lib/models/api_post_model.dart
class ApiPostModel {
  final int id;
  final String question;
  final String location;
  final String status;
  final String image;
  final String userId;
  final String createdAt;

  ApiPostModel({
    required this.id,
    required this.question,
    required this.location,
    required this.status,
    required this.image,
    required this.userId,
    required this.createdAt,
  });

  factory ApiPostModel.fromJson(Map<String, dynamic> json) {
    return ApiPostModel(
      id: json['id'] ?? 0,
      question: json['question'] ?? '',
      location: json['location'] ?? '',
      status: json['status'] ?? '',
      image: json['image'] ?? '',
      userId: json['user_id'] ?? '',
      createdAt: json['created_at'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'question': question,
      'location': location,
      'status': status,
      'image': image,
      'user_id': userId,
      'created_at': createdAt,
    };
  }
}
