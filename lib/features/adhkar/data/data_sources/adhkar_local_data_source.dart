import 'dart:convert';
import 'package:flutter/services.dart';
import '../models/adhkar_category_model.dart';

abstract class AdhkarLocalDataSource {
  Future<List<AdhkarCategoryModel>> getAllAdhkar();
}

class AdhkarLocalDataSourceImpl implements AdhkarLocalDataSource {
  @override
  Future<List<AdhkarCategoryModel>> getAllAdhkar() async {
    final String response = await rootBundle.loadString('assets/json/adhkar.json');
    final List<dynamic> data = json.decode(response);
    return data.map((e) => AdhkarCategoryModel.fromJson(e)).toList();
  }
}