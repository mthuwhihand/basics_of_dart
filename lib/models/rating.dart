class Rating {
  final int user_id;
  final int movie_id;
  final double point;
  final String comment;

  Rating({
    // ignore: duplicate_ignore
    // ignore: non_constant_identifier_names
    required this.user_id,
    // ignore_for_file: non_constant_identifier_names
    required this.movie_id,
    required this.point,
    required this.comment,
  });

  factory Rating.fromJson(Map<String, dynamic> json) {
    return Rating(
      user_id: json['user_id'],
      movie_id: json['movie_id'],
      point: json['point'],
      comment: json['comment'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'user_id': user_id,
      'movie_id': movie_id,
      'point': point,
      'comment': comment,
    };
  }
}
