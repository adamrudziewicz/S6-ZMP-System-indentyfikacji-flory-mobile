class Herbarium {
  final String id;
  final String userId;
  final String name;
  final String? description;
  final bool isPublic;
  final int plantCount;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  Herbarium({
    required this.id,
    required this.userId,
    required this.name,
    this.description,
    required this.isPublic,
    this.plantCount = 0,
    this.createdAt,
    this.updatedAt,
  });
}
