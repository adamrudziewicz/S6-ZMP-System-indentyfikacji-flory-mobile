import 'dart:convert';
import 'package:hive/hive.dart';
import '../models/herbarium_response.dart';

abstract class HerbariumLocalDataSource {
  Future<List<HerbariumResponse>> getCachedHerbaria();
  Future<void> cacheHerbaria(List<HerbariumResponse> herbaria);
  Future<void> cacheHerbarium(HerbariumResponse herbarium);
  
  Future<void> addHerbariumToSyncQueue(Map<String, dynamic> requestJson);
  Future<List<Map<String, dynamic>>> getSyncQueue();
  Future<void> clearSyncQueue();
}

const String _herbariaBox = 'herbaria_cache';
const String _syncQueueBox = 'herbaria_sync_queue';

class HerbariumLocalDataSourceImpl implements HerbariumLocalDataSource {
  Future<Box> get _cacheBox async => await Hive.openBox(_herbariaBox);
  Future<Box> get _queueBox async => await Hive.openBox(_syncQueueBox);

  @override
  Future<List<HerbariumResponse>> getCachedHerbaria() async {
    final box = await _cacheBox;
    final String? jsonString = box.get('all_herbaria');
    if (jsonString != null) {
      final List<dynamic> jsonList = jsonDecode(jsonString);
      return jsonList.map((e) => HerbariumResponse.fromJson(e)).toList();
    }
    return [];
  }

  @override
  Future<void> cacheHerbaria(List<HerbariumResponse> herbaria) async {
    final box = await _cacheBox;
    final jsonList = herbaria.map((e) => e.toJson()).toList();
    await box.put('all_herbaria', jsonEncode(jsonList));
  }

  @override
  Future<void> cacheHerbarium(HerbariumResponse herbarium) async {
    final herbaria = await getCachedHerbaria();
    herbaria.add(herbarium);
    await cacheHerbaria(herbaria);
  }

  @override
  Future<void> addHerbariumToSyncQueue(Map<String, dynamic> requestJson) async {
    final box = await _queueBox;
    await box.add(jsonEncode(requestJson));
  }

  @override
  Future<List<Map<String, dynamic>>> getSyncQueue() async {
    final box = await _queueBox;
    final List<Map<String, dynamic>> queue = [];
    for (var value in box.values) {
      queue.add(jsonDecode(value as String));
    }
    return queue;
  }

  @override
  Future<void> clearSyncQueue() async {
    final box = await _queueBox;
    await box.clear();
  }
}
