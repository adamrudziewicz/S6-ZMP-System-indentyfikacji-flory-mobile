class PlantPhoto {
  final String id;
  final String plantId;
  final String url;
  final String? description;
  final double? confidence;
  final DateTime? createdAt;
  
  PlantPhoto({
    required this.id,
    required this.plantId,
    required this.url,
    this.description,
    this.confidence,
    this.createdAt,
  });
}
