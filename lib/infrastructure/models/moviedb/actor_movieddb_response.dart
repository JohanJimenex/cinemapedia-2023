class ActorMovieDBResponse {
  final int id;
  final List<Cast> cast;

  ActorMovieDBResponse({
    required this.id,
    required this.cast,
  });

  factory ActorMovieDBResponse.fromJson(Map<String, dynamic> json) =>
      ActorMovieDBResponse(
        id: json["id"],
        cast: List<Cast>.from(json["cast"].map((x) => Cast.fromJson(x))),
      );
}

class Cast {
  final int id;
  final String name;
  final String? profilePath;
  final String? character;
  final int gender;
  final String? job;
  final bool adult;
  final String knownForDepartment;
  final String originalName;
  final double popularity;
  final int? castId;
  final String creditId;
  final int? order;
  final String? department;

  Cast({
    required this.adult,
    required this.gender,
    required this.id,
    required this.knownForDepartment,
    required this.name,
    required this.originalName,
    required this.popularity,
    required this.profilePath,
    this.castId,
    this.character,
    required this.creditId,
    this.order,
    this.department,
    this.job,
  });

  factory Cast.fromJson(Map<String, dynamic> json) => Cast(
        adult: json["adult"],
        gender: json["gender"],
        id: json["id"],
        knownForDepartment: json["known_for_department"],
        name: json["name"],
        originalName: json["original_name"],
        popularity: json["popularity"]?.toDouble(),
        profilePath: json["profile_path"],
        castId: json["cast_id"],
        character: json["character"],
        creditId: json["credit_id"],
        order: json["order"],
        department: json["department"],
        job: json["job"],
      );
}
