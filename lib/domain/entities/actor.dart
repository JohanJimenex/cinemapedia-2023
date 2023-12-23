class Actor {
  final int id;
  final String name;
  final String profilePath;
  final String? character;
  final String gender;
  final String? roll;

  Actor({
    required this.id,
    required this.name,
    required this.profilePath,
    this.character,
    required this.gender,
    required this.roll,
  });
}
