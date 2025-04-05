import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:perfect_pay/common/models/transaction_model.dart';
import 'package:perfect_pay/common/widgets/transaction_item_widget.dart';
import 'package:perfect_pay/src/historyscreen/view/action_widget.dart';

class HistoryScreen extends StatefulWidget {
  const HistoryScreen({super.key});

  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  List<Transaction> _filteredTransactions = [];
  final TextEditingController _searchController = TextEditingController();

  final List<Transaction> transactions = [
    Transaction(
      id: '1',
      description: 'Sent to Alice',
      date: DateTime.now().subtract(const Duration(days: 1)),
      amount: 50.0,
      isSent: true,
    ),
    Transaction(
      id: '2',
      description: 'Received from Bob',
      date: DateTime.now().subtract(const Duration(days: 2)),
      amount: 75.0,
      isSent: false,
    ),
    Transaction(
      id: '3',
      description: 'Sent to Charlie',
      date: DateTime.now().subtract(const Duration(days: 3)),
      amount: 20.0,
      isSent: true,
    ),
    Transaction(
      id: '4',
      description: 'Received from Dave',
      date: DateTime.now().subtract(const Duration(days: 4)),
      amount: 100.0,
      isSent: false,
    ),
    Transaction(
      id: '5',
      description: 'Sent to Eve',
      date: DateTime.now().subtract(const Duration(days: 5)),
      amount: 40.0,
      isSent: true,
    ),
    Transaction(
      id: '6',
      description: 'Sent to Charlie',
      date: DateTime.now().subtract(const Duration(days: 3)),
      amount: 20.0,
      isSent: true,
    ),
    Transaction(
      id: '7',
      description: 'Received from Dave',
      date: DateTime.now().subtract(const Duration(days: 4)),
      amount: 100.0,
      isSent: false,
    ),
  ];

  bool _isSentFilter = false;
  bool _isReceivedFilter = false;

  @override
  void initState() {
    super.initState();
    _filteredTransactions = transactions;
    _searchController.addListener(_onSearchChanged);
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _onSearchChanged() {
    _filterTransactions();
  }

  void _filterTransactions() {
    String query = _searchController.text.toLowerCase();
    setState(() {
      _filteredTransactions = transactions.where((transaction) {
        bool matchesSearch =
            transaction.description.toLowerCase().contains(query);
        bool matchesFilter = true;

        if (_isSentFilter && !_isReceivedFilter) {
          matchesFilter = transaction.isSent;
        } else if (!_isSentFilter && _isReceivedFilter) {
          matchesFilter = !transaction.isSent;
        } else if (_isSentFilter && _isReceivedFilter) {
          matchesFilter = true;
        }

        return matchesSearch && matchesFilter;
      }).toList();
    });
  }

  void _showFilterOptions() {
    showModalBottomSheet(
      context: context,
      builder: (_) {
        return Padding(
          padding: EdgeInsets.all(16.w),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Filter Transactions',
                style: TextStyle(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 10.h),
              CheckboxListTile(
                title: Text('Sent'),
                value: _isSentFilter,
                onChanged: (value) {
                  setState(() {
                    _isSentFilter = value ?? false;
                  });
                  _filterTransactions();
                },
              ),
              CheckboxListTile(
                title: Text('Received'),
                value: _isReceivedFilter,
                onChanged: (value) {
                  setState(() {
                    _isReceivedFilter = value ?? false;
                  });
                  _filterTransactions();
                },
              ),
              SizedBox(height: 10.h),
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text('Apply Filters'),
                style: ElevatedButton.styleFrom(
                  minimumSize: Size(double.infinity, 40.h),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  // IconButton(
  // icon: Icon(Icons.filter_list),
  // onPressed: _showFilterOptions,
  // ),

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          // Search Input
          Row(
            children: [
              Expanded(
                child: Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
                  child: TextField(
                    controller: _searchController,
                    decoration: InputDecoration(
                      hintText: 'Search transactions',
                      prefixIcon: const Icon(Icons.search),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12.r),
                      ),
                      filled: true,
                      fillColor: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
          // Action Buttons
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: const ActionWidget(),
          ),
          // Transaction History List
          Expanded(
            child: _filteredTransactions.isEmpty
                ? Center(
                    child: Text(
                      'No transactions found.',
                      style: TextStyle(
                        fontSize: 16.sp,
                        color: Colors.grey,
                      ),
                    ),
                  )
                : ListView.builder(
                    itemCount: _filteredTransactions.length,
                    itemBuilder: (context, index) {
                      final transaction = _filteredTransactions[index];
                      return TransactionItem(transaction: transaction);
                    },
                  ),
          ),
        ],
      ),
    );
  }
}
