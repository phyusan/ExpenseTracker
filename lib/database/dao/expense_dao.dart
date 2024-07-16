import 'package:expense_tracker/database/table/table_name.dart';
import 'package:floor/floor.dart';
import '../../model/fcm_model.dart';

@dao
abstract class ExpenseDao {
  @Insert(onConflict: OnConflictStrategy.replace)
  Future<void> insertAccount(FcmModel person);
  @Query('SELECT * FROM ${TableName.account}')
  Future<List<FcmModel>> findAllPersons();

  @Query("SELECT * FROM ${TableName.account} WHERE id = :id")
  Future<List<FcmModel>?> getNotiById(int id);

  // @Query("SELECT * FROM ${TableName.notiMaster} WHERE isRead = 1")
  // Future<List<FcmModel>?> getUnreadNotis();

  // @Query("UPDATE ${TableName.notiMaster} SET isNew = 0 WHERE id = :id")
  // Future<void> updateNotiIsNew(int id);

  // @Query("UPDATE ${TableName.notiMaster} SET isRead = 0")
  // Future<void> updateAllNotiIsRead();

  // @Query("SELECT * FROM ${TableName.account} ORDER BY id DESC")
  // Future<List<FcmModel>> getAllNotisList();

  @Query("DELETE FROM ${TableName.account}")
  Future<void> clearDB();

  // @Query(
  //     "DELETE FROM ${TableName.notiMaster} WHERE invoiceNo = :invoiceNo AND type = :type")
  // Future<void> deleteNotiWithInvoiceAndType(String invoiceNo, String type);

  // @Query("SELECT * FROM ${TableName.notiMaster} ORDER BY id DESC LIMIT 1")
  // Future<FcmModel?> getLastRecordNoti();

  // @Query(
  //     "SELECT COUNT(${TableName.notiMaster}.id) FROM ${TableName.notiMaster} WHERE isRead = 1")
  // Future<List<int>> getNotiCount();
}
