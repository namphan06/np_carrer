class ImgCloudinary {
  final String name;
  final String id;
  final String extension;
  final int size;
  final String url;
  final String createdAt;

  const ImgCloudinary({
    required this.name,
    required this.id,
    required this.extension,
    required this.size,
    required this.url,
    required this.createdAt,
  });

  factory ImgCloudinary.fromMap(Map<String, dynamic> data) {
    return ImgCloudinary(
      name: data['name'] ?? '',
      id: data['id'] ?? '',
      extension: data['extension'] ?? '',
      size: data['size'] is int
          ? data['size']
          : int.tryParse(data['size'].toString()) ?? 0,
      url: data['url'] ?? '',
      createdAt: data['created_at'] ?? '',
    );
  }

  Map<String, dynamic> toJson() => {
        'name': name,
        'id': id,
        'extension': extension,
        'size': size,
        'url': url,
        'created_at': createdAt,
      };
}
