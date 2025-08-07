class Quote {
  final String id;
  final String text;
  final String author;
  final String? imageUrl;
  final String category;
  final DateTime createdAt;
  final bool isDaily;
  final DateTime? dailyDate;
  final int likes;
  final int shares;

  Quote({
    required this.id,
    required this.text,
    required this.author,
    this.imageUrl,
    required this.category,
    required this.createdAt,
    this.isDaily = false,
    this.dailyDate,
    this.likes = 0,
    this.shares = 0,
  });

  Quote copyWith({
    String? id,
    String? text,
    String? author,
    String? imageUrl,
    String? category,
    DateTime? createdAt,
    bool? isDaily,
    DateTime? dailyDate,
    int? likes,
    int? shares,
  }) {
    return Quote(
      id: id ?? this.id,
      text: text ?? this.text,
      author: author ?? this.author,
      imageUrl: imageUrl ?? this.imageUrl,
      category: category ?? this.category,
      createdAt: createdAt ?? this.createdAt,
      isDaily: isDaily ?? this.isDaily,
      dailyDate: dailyDate ?? this.dailyDate,
      likes: likes ?? this.likes,
      shares: shares ?? this.shares,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is Quote && other.id == id;
  }

  @override
  int get hashCode => id.hashCode;

  @override
  String toString() {
    return 'Quote(id: $id, text: $text, author: $author, category: $category)';
  }
} 