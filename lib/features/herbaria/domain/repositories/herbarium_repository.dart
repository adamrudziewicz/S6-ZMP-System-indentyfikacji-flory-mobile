import '../entities/herbarium.dart';

abstract class HerbariumRepository {
  Future<List<Herbarium>> getMyHerbaria();
  Future<List<Herbarium>> getPublicHerbaria();
  Future<Herbarium> getHerbarium(String herbariumId);
  Future<Herbarium> createHerbarium({
    required String name,
    String? description,
    bool isPublic = false,
  });
  Future<Herbarium> updateHerbarium(
    String herbariumId, {
    required String name,
    String? description,
    bool isPublic = false,
  });
  Future<void> deleteHerbarium(String herbariumId);
}
