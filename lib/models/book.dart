class Book {
  final String id;
  final String title;
  final String author;
  final int year;

  Book({
    required this.id,
    required this.title,
    required this.author,
    required this.year,
  });

  factory Book.fromJson(Map<String, dynamic> json) => Book(
        id: json['id'] as String,
        title: json['title'] as String,
        author: json['author'] as String,
        year: json['year'] as int,
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'author': author,
        'year': year,
      };

  Book copyWith({String? title, String? author, int? year}) => Book(
        id: id,
        title: title ?? this.title,
        author: author ?? this.author,
        year: year ?? this.year,
      );
}
