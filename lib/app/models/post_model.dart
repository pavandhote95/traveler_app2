// lib/app/modules/community/models/post_model.dart

class PostModel {
  final String username;
  final String userImage;
  final String location;
  final String time;
  final String postText;
  final String postImage;
  final int likes;
  final String commentUser;
  final String commentUserImage; // ✅ This must exist!
  final String commentText;

  PostModel({
    required this.username,
    required this.userImage,
    required this.location,
    required this.time,
    required this.postText,
    required this.postImage,
    required this.likes,
    required this.commentUser,
    required this.commentUserImage, // ✅ Make sure this matches the key
    required this.commentText,
  });
}
