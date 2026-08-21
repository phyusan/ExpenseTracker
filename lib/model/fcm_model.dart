import 'package:expense_tracker/database/table/table_name.dart';
import 'package:floor/floor.dart';

@Entity(tableName: TableName.account)
class FcmModel {
  FcmModel({
    this.id,
    this.name,
    this.phone,
    this.incomeAmount,
    this.outcomeAmount,
    this.PhotoURL,
    this.isRead,
    this.isNew,
    this.category,
    this.createdAt,
  });
  @PrimaryKey(autoGenerate: true)
  int? id;
  String? name;
  int? phone;
  String? incomeAmount;
  String? outcomeAmount;

  String? PhotoURL;
  int? isRead;
  bool? isNew = false;
  String? category;
  int? createdAt;

  FcmModel.fromJson(Map<String, dynamic> json) {
    id = json['id'] as int?;
    name = json['name'] as String?;
    phone = json['phone'] as int?;
    incomeAmount = json['incomeAmount'] as String?;
    outcomeAmount = json['outcomeAmount'] as String?;

    PhotoURL = json['PhotoURL'] as String?;
    isRead = json['isRead'] as int?;
    isNew = json['isNew'] as bool?;
    category = json['category'] as String?;
    createdAt = json['createdAt'] as int?;
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['phone'] = phone;
    data['incomeAmount'] = incomeAmount;
    data['outcomeAmount'] = outcomeAmount;

    data['PhotoURL'] = PhotoURL;
    data['isRead'] = isRead;
    data['isNew'] = isNew;
    data['category'] = category;
    data['createdAt'] = createdAt;
    return data;
  }
}
