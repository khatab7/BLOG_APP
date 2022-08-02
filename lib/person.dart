class Post {
  int? id;
  String? title;
  String? body;
  final String userId;

  Post({
    required this.id,
    required this.title,
    required this.body,
    required this.userId,
  });

  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
      title: json['title'],
      id: json['id'],
      body: json['body'],
      userId: json['userId'].toString(),
    );
  }
}
