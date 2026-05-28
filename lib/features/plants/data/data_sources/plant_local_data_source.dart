import 'dart:convert';
import 'package:hive/hive.dart';
import '../models/plant_response.dart';

abstract class PlantLocalDataSource {
  Future<List<PlantResponse>> getCachedPlants(String herbariumId);
  Future<void> cachePlants(String herbariumId, List<PlantResponse> plants);
}

const String _plantsBox = 'plants_cache';

class PlantLocalDataSourceImpl implements PlantLocalDataSource {
  Future<Box> get _cacheBox async => await Hive.openBox(_plantsBox);

  @override
  Future<List<PlantResponse>> getCachedPlants(String herbariumId) async {
    final box = await _cacheBox;
    final String? jsonString = box.get('plants_$herbariumId');
    if (jsonString != null) {
      final List<dynamic> jsonList = jsonDecode(jsonString);
      return jsonList.map((e) => PlantResponse.fromJson(e)).toList();
    }
    return [];
  }

  @override
  Future<void> cachePlants(String herbariumId, List<PlantResponse> plants) async {
    final box = await _cacheBox;
    final jsonList = plants.map((e) => e.toJson()).toList();
    await box.put('plants_$herbariumId', jsonEncode(jsonList));
  }
}
