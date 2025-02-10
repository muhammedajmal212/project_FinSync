import 'package:hive_flutter/hive_flutter.dart';
part 'category_model.g.dart';

@HiveType(typeId: 2)
enum CategoryType {
  @HiveField(0)
  income,

  @HiveField(1)
  expense;
}

@HiveType(typeId: 1)
class CategoryModel {
  @HiveField(0)

  final String name;
  @HiveField(1)

  final bool isdeleated;
  @HiveField(2)
  
  final CategoryType type;
  @HiveField(3)
  final String id;

  CategoryModel(
      {required this.name,
      this.isdeleated = false,
      required this.type,
       required this.id});
       
  @override
  bool operator ==(Object other) => other is CategoryModel && other.id == id;

  @override
  int get hashCode => id.hashCode;
}
