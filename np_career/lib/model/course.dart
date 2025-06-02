class Course {
  final int id;
  final String title;
  final String description;
  final String youtubeLink;
  final double price;
  final String? thumbnail;
  final bool isActive;
  final int categoryId;

  Course({
    required this.id,
    required this.title,
    required this.description,
    required this.youtubeLink,
    required this.price,
    this.thumbnail,
    required this.isActive,
    required this.categoryId,
  });

  factory Course.fromMap(Map<String, dynamic> map) {
    return Course(
      id: map['id'],
      title: map['title'],
      description: map['description'],
      youtubeLink: map['youtube_link'],
      price: map['price'] is String
          ? double.tryParse(map['price']) ?? 0.0
          : (map['price'] as num).toDouble(),
      thumbnail: map['thumbnail'],
      isActive: map['is_active'] == 1 || map['is_active'] == true,
      categoryId: map['category_id'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'youtube_link': youtubeLink,
      'price': price,
      'thumbnail': thumbnail,
      'is_active': isActive,
      'category_id': categoryId,
    };
  }
}
