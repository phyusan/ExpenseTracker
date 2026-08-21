import 'package:expense_tracker/controller/add_transaction_controller.dart';
import 'package:expense_tracker/database/app_database.dart';
import 'package:expense_tracker/helper/app_constant.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class AddExpenseScreen extends StatelessWidget {
  const AddExpenseScreen({super.key, required this.db});
  final AppDatabase db;

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(AddTransactionController(db: db));
    return Scaffold(
      backgroundColor: MyColor.colorPageBackground,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 16),
                _buildTopBar(context, controller),
                const SizedBox(height: 24),
                _buildGreeting(),
                const SizedBox(height: 24),
                _buildBalanceCard(controller),
                const SizedBox(height: 16),
                _buildPeriodSummary(controller),
                const SizedBox(height: 24),
                _buildActivityHeader(context, controller),
                const SizedBox(height: 16),
                _buildTransactionList(controller),
                const SizedBox(height: 30),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTopBar(BuildContext context, AddTransactionController controller) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Text(
          'pocketwise',
          style: TextStyle(
            color: MyColor.colorDarkBase,
            fontSize: FontSize.textSizeExtraLarge,
            fontWeight: FontWeight.w800,
          ),
        ),
        GestureDetector(
          onTap: () => _showAddTransactionSheet(context, controller),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
            decoration: BoxDecoration(
              color: MyColor.colorPrimaryGreenTint,
              borderRadius: BorderRadius.circular(10),
            ),
            child: const Row(
              children: [
                Icon(Icons.add, color: MyColor.colorPrimaryGreen, size: 20),
                SizedBox(width: 4),
                Text(
                  'Add',
                  style: TextStyle(
                    color: MyColor.colorPrimaryGreen,
                    fontSize: FontSize.textSizeNormal,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildGreeting() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          DateFormat('EEEE, MMMM d, yyyy').format(DateTime.now()),
          style: const TextStyle(
            color: MyColor.colorNeutral500,
            fontSize: FontSize.textSizeSmall,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 6),
        const Text(
          'Good morning, Phyu',
          style: TextStyle(
            color: MyColor.colorDarkBase,
            fontSize: FontSize.textSizeExtraXLarge,
            fontWeight: FontWeight.w800,
          ),
        ),
      ],
    );
  }

  Widget _buildBalanceCard(AddTransactionController controller) {
    final balance = controller.balance;
    final growth = controller.totalOutcome > 0
        ? ((controller.totalIncome - controller.totalOutcome) /
                controller.totalOutcome) *
            100
        : 100.0;
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: MyColor.colorDarkBase,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Available balance',
            style: TextStyle(
              color: Colors.white70,
              fontSize: FontSize.textSizeNormal,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            '\$${_formatNumber(balance)}',
            style: const TextStyle(
              color: MyColor.colorWhite,
              fontSize: 36,
              fontWeight: FontWeight.w800,
            ),
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: MyColor.colorPrimaryGreenTint,
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Text(
                  growth >= 0 ? '+${growth.toStringAsFixed(1)}%' : '${growth.toStringAsFixed(1)}%',
                  style: const TextStyle(
                    color: MyColor.colorPrimaryGreen,
                    fontSize: FontSize.textSizeSmall,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              const SizedBox(width: 8),
              const Text(
                'from last month',
                style: TextStyle(
                  color: Colors.white70,
                  fontSize: FontSize.textSizeSmall,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildPeriodSummary(AddTransactionController controller) {
    return Obx(() {
      final today = controller.todayTransactions;
      final week = controller.weekTransactions;
      final month = controller.monthTransactions;
      return Row(
        children: [
          Expanded(
            child: _buildPeriodCard(
              label: 'Today',
              icon: Icons.today,
              income: controller.incomeOf(today),
              outcome: controller.outcomeOf(today),
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: _buildPeriodCard(
              label: 'This Week',
              icon: Icons.calendar_view_week,
              income: controller.incomeOf(week),
              outcome: controller.outcomeOf(week),
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: _buildPeriodCard(
              label: 'This Month',
              icon: Icons.calendar_month,
              income: controller.incomeOf(month),
              outcome: controller.outcomeOf(month),
            ),
          ),
        ],
      );
    });
  }

  Widget _buildPeriodCard({
    required String label,
    required IconData icon,
    required double income,
    required double outcome,
  }) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: MyColor.colorWhite,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: MyColor.colorDivider),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: MyColor.colorPrimaryGreen, size: 20),
          const SizedBox(height: 10),
          Text(
            label,
            style: const TextStyle(
              color: MyColor.colorNeutral500,
              fontSize: FontSize.textSizeSmall,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            '+${_formatNumber(income)}',
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              color: MyColor.colorPrimaryGreen,
              fontSize: FontSize.textSizeExtraSmall,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 2),
          Text(
            '-${_formatNumber(outcome)}',
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              color: MyColor.colorTextRed,
              fontSize: FontSize.textSizeExtraSmall,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActivityHeader(
      BuildContext context, AddTransactionController controller) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Activity history',
          style: TextStyle(
            color: MyColor.colorDarkBase,
            fontSize: FontSize.textSizeExtraNormal,
            fontWeight: FontWeight.w700,
          ),
        ),
        const SizedBox(height: 16),
        const Text(
          'Transactions',
          style: TextStyle(
            color: MyColor.colorDarkBase,
            fontSize: FontSize.textSizeExtraLarge,
            fontWeight: FontWeight.w800,
          ),
        ),
        const SizedBox(height: 4),
        const Text(
          'Review every income and expense in one place.',
          style: TextStyle(
            color: MyColor.colorNeutral500,
            fontSize: FontSize.textSizeSmall,
          ),
        ),
        const SizedBox(height: 16),
        GestureDetector(
          onTap: () => _showAddTransactionSheet(context, controller),
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 14),
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [MyColor.colorPrimaryGreen, MyColor.colorPrimaryGreenHover],
              ),
              borderRadius: BorderRadius.circular(14),
            ),
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.add, color: MyColor.colorWhite, size: 20),
                SizedBox(width: 6),
                Text(
                  'Add transaction',
                  style: TextStyle(
                    color: MyColor.colorWhite,
                    fontSize: FontSize.textSizeNormal,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 16),
        Container(
          height: 48,
          padding: const EdgeInsets.symmetric(horizontal: 14),
          decoration: BoxDecoration(
            color: MyColor.colorWhite,
            borderRadius: BorderRadius.circular(14),
            border: Border.all(color: MyColor.colorDivider),
          ),
          child: Obx(
            () => TextField(
              controller: controller.searchController.value,
              onChanged: (_) => controller.transactions.refresh(),
              style: const TextStyle(fontSize: FontSize.textSizeNormal),
              decoration: const InputDecoration(
                hintText: 'Search transactions',
                hintStyle: TextStyle(
                  color: MyColor.colorNeutral400,
                  fontSize: FontSize.textSizeNormal,
                ),
                prefixIcon: Icon(Icons.search, color: MyColor.colorNeutral400),
                border: InputBorder.none,
              ),
            ),
          ),
        ),
        const SizedBox(height: 20),
        const Text(
          'This month',
          style: TextStyle(
            color: MyColor.colorDarkBase,
            fontSize: FontSize.textSizeExtraNormal,
            fontWeight: FontWeight.w700,
          ),
        ),
      ],
    );
  }

  Widget _buildTransactionList(AddTransactionController controller) {
    return Obx(() {
      final list = controller.filteredTransactions;
      if (controller.isLoading.value) {
        return const Padding(
          padding: EdgeInsets.symmetric(vertical: 40),
          child: Center(
            child: CircularProgressIndicator(color: MyColor.colorPrimaryGreen),
          ),
        );
      }
      if (list.isEmpty) {
        return const Padding(
          padding: EdgeInsets.symmetric(vertical: 40),
          child: Column(
            children: [
              Icon(Icons.receipt_long,
                  size: 48, color: MyColor.colorNeutral300),
              SizedBox(height: 12),
              Text(
                'No transactions yet',
                style: TextStyle(
                  color: MyColor.colorNeutral500,
                  fontSize: FontSize.textSizeNormal,
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(height: 4),
              Text(
                'Tap "Add transaction" to get started',
                style: TextStyle(
                  color: MyColor.colorNeutral400,
                  fontSize: FontSize.textSizeSmall,
                ),
              ),
            ],
          ),
        );
      }
      return Column(
        children: list
            .map((t) => _buildTransactionTile(controller, t))
            .toList(),
      );
    });
  }

  Widget _buildTransactionTile(
      AddTransactionController controller, dynamic t) {
    final isIncome = (t.incomeAmount ?? '').isNotEmpty;
    final amount =
        double.tryParse(isIncome ? t.incomeAmount ?? '' : t.outcomeAmount ?? '') ??
            0;
    final time = t.createdAt != null
        ? DateFormat('hh:mm a').format(
            DateTime.fromMillisecondsSinceEpoch(t.createdAt!))
        : '';
    final categoryIcon = _categoryIcon(t.category);
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Container(
            width: 46,
            height: 46,
            decoration: BoxDecoration(
              color: MyColor.colorPrimaryGreenTint,
              borderRadius: BorderRadius.circular(14),
            ),
            child: Icon(categoryIcon, color: MyColor.colorPrimaryGreen, size: 22),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  t.name ?? '',
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    color: MyColor.colorDarkBase,
                    fontSize: FontSize.textSizeNormal,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  '${t.category ?? 'Other'} • $time',
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    color: MyColor.colorNeutral400,
                    fontSize: FontSize.textSizeSmall,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 8),
          Text(
            '${isIncome ? '+' : '-'}\$${_formatNumber(amount)}',
            style: TextStyle(
              color: isIncome ? MyColor.colorPrimaryGreen : MyColor.colorTextRed,
              fontSize: FontSize.textSizeNormal,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(width: 4),
          PopupMenuButton<String>(
            color: MyColor.colorWhite,
            icon: const Icon(Icons.more_vert, color: MyColor.colorNeutral400),
            onSelected: (value) {
              if (value == 'delete') {
                controller.deleteTransaction(t);
              }
            },
            itemBuilder: (_) => const [
              PopupMenuItem(
                value: 'delete',
                child: Text('Delete',
                    style: TextStyle(color: MyColor.colorTextRed)),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void _showAddTransactionSheet(
      BuildContext context, AddTransactionController controller) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: MyColor.colorWhite,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (ctx) => _AddTransactionSheet(controller: controller),
    );
  }

  IconData _categoryIcon(String? category) {
    switch (category?.toLowerCase()) {
      case 'transport':
        return Icons.directions_bus;
      case 'house':
      case 'home':
        return Icons.home;
      case 'breakfast':
        return Icons.free_breakfast;
      case 'lunch':
        return Icons.lunch_dining;
      case 'dinner':
        return Icons.dinner_dining;
      case 'health':
        return Icons.favorite;
      case 'clothing':
        return Icons.checkroom;
      case 'cosmetic':
        return Icons.brush;
      default:
        return Icons.receipt_long;
    }
  }

  String _formatNumber(double value) {
    final formatted = value.toStringAsFixed(2);
    final parts = formatted.split('.');
    final buffer = StringBuffer();
    for (var i = 0; i < parts[0].length; i++) {
      buffer.write(parts[0][i]);
      final remaining = parts[0].length - i - 1;
      if (remaining > 0 && remaining % 3 == 0) {
        buffer.write(',');
      }
    }
    return '$buffer.${parts[1]}';
  }
}

class _AddTransactionSheet extends StatefulWidget {
  const _AddTransactionSheet({required this.controller});
  final AddTransactionController controller;

  @override
  State<_AddTransactionSheet> createState() => _AddTransactionSheetState();
}

class _AddTransactionSheetState extends State<_AddTransactionSheet> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _amountController = TextEditingController();
  bool _isIncome = false;
  String _category = 'Food';

  static const _categories = [
    'Food',
    'Breakfast',
    'Lunch',
    'Dinner',
    'Transport',
    'House',
    'Health',
    'Shopping',
    'Other',
  ];

  @override
  void dispose() {
    _nameController.dispose();
    _amountController.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;
    await widget.controller.addTransaction(
      name: _nameController.text.trim(),
      amount: _amountController.text.trim(),
      isIncome: _isIncome,
      category: _category,
    );
    if (mounted) Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        left: 20,
        right: 20,
        top: 20,
        bottom: MediaQuery.viewInsetsOf(context).bottom + 20,
      ),
      child: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Container(
                  width: 40,
                  height: 4,
                  decoration: BoxDecoration(
                    color: MyColor.colorNeutral300,
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              const Text(
                'Add Transaction',
                style: TextStyle(
                  color: MyColor.colorDarkBase,
                  fontSize: FontSize.textSizeExtraLarge,
                  fontWeight: FontWeight.w800,
                ),
              ),
              const SizedBox(height: 16),
              Container(
                height: 48,
                decoration: BoxDecoration(
                  color: MyColor.colorPageBackground,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: _buildTypeButton('Expense', !_isIncome, () {
                        setState(() => _isIncome = false);
                      }),
                    ),
                    Expanded(
                      child: _buildTypeButton('Income', _isIncome, () {
                        setState(() => _isIncome = true);
                      }),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _nameController,
                style: const TextStyle(color: MyColor.colorDarkBase),
                decoration: _inputDecoration('Transaction name'),
                validator: (v) =>
                    (v == null || v.trim().isEmpty) ? 'Enter a name' : null,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _amountController,
                keyboardType: TextInputType.number,
                style: const TextStyle(color: MyColor.colorDarkBase),
                decoration: _inputDecoration('Amount'),
                validator: (v) =>
                    (v == null || v.trim().isEmpty) ? 'Enter an amount' : null,
              ),
              const SizedBox(height: 16),
              DropdownButtonFormField<String>(
                initialValue: _category,
                decoration: _inputDecoration('Category'),
                dropdownColor: MyColor.colorWhite,
                items: _categories
                    .map((c) => DropdownMenuItem(value: c, child: Text(c)))
                    .toList(),
                onChanged: (v) => setState(() => _category = v ?? 'Food'),
              ),
              const SizedBox(height: 24),
              GestureDetector(
                onTap: _submit,
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [
                        MyColor.colorPrimaryGreen,
                        MyColor.colorPrimaryGreenHover,
                      ],
                    ),
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: const Center(
                    child: Text(
                      'Add',
                      style: TextStyle(
                        color: MyColor.colorWhite,
                        fontSize: FontSize.textSizeNormal,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTypeButton(String label, bool selected, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        margin: const EdgeInsets.all(4),
        decoration: BoxDecoration(
          color: selected ? MyColor.colorDarkBase : Colors.transparent,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Center(
          child: Text(
            label,
            style: TextStyle(
              color: selected ? MyColor.colorWhite : MyColor.colorNeutral500,
              fontSize: FontSize.textSizeNormal,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
    );
  }

  InputDecoration _inputDecoration(String label) {
    return InputDecoration(
      labelText: label,
      labelStyle: const TextStyle(
        color: MyColor.colorNeutral400,
        fontSize: FontSize.textSizeSmall,
      ),
      filled: true,
      fillColor: MyColor.colorPageBackground,
      contentPadding:
          const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide.none,
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide.none,
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide:
            const BorderSide(color: MyColor.colorPrimaryGreen, width: 1.5),
      ),
    );
  }
}
