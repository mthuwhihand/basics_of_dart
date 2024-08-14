class Like {
  final int user_id;
  final int movie_id;

  Like(
      {
      // ignore: duplicate_ignore
      // ignore: non_constant_identifier_names
      required this.user_id,
      // ignore_for_file: non_constant_identifier_names
      required this.movie_id});

  factory Like.fromJson(Map<String, dynamic> json) {
    return Like(
      user_id: json['user_id'],
      movie_id: json['movie_id'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'user_id': user_id,
      'movie_id': movie_id,
    };
  }
}
