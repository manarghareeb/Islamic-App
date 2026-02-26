import 'package:hive/hive.dart';

import '../models/tasbih_model.dart';

abstract class TasbihLocalDataSource {
  Future<List<TasbihModel>> getAllTasbih();
  Future<void> addTasbih(TasbihModel tasbih);
  Future<void> updateTasbih(TasbihModel tasbih);
}

class TasbihLocalDataSourceImpl implements TasbihLocalDataSource {
  final Box<TasbihModel> box;

  TasbihLocalDataSourceImpl(this.box);

  @override
  Future<List<TasbihModel>> getAllTasbih() async {
    return box.values.toList();
  }

  @override
  Future<void> addTasbih(TasbihModel tasbih) async {
    await box.add(tasbih);
  }

  @override
  Future<void> updateTasbih(TasbihModel tasbih) async {
    await tasbih.save();
  }
}
