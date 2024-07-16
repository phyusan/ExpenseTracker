class ExpenseModel {
  final int id;
  final String name;
  final String icon;
  final int amount;
  final bool isDelete;
  final bool isShow;
  ExpenseModel(
      {required this.id,
      required this.name,
      required this.icon,
      required this.amount,
      required this.isDelete,
      required this.isShow});
}
