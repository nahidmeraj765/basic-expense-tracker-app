import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  List<Map<String, dynamic>> _earnings = [];
  List<Map<String, dynamic>> _expenses = [];

  double get _totalExpenses =>
      _expenses.fold(0, (sum, item) => sum + item['amount']);
  double get _totalEarnings =>
      _earnings.fold(0, (sum, item) => sum + item['amount']);
  double get _totalBalance => _totalEarnings - _totalExpenses;

  void addEntry(String title, double amount, DateTime date, bool isEarning) {
    setState(() {
      if (isEarning) {
        _earnings.add({"title": title, "amount": amount, "date": date});
      } else {
        _expenses.add({"title": title, "amount": amount, "date": date});
      }
    });
  }

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  void _FABOptions(context) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.all(20.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                  showForm(isEarning: true);
                },
                style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
                child: Text(
                  "Add Earning",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                  showForm(isEarning: false);
                },
                style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                child: Text(
                  "Add Expense",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  void showForm({required isEarning}) {
    TextEditingController _titleController = TextEditingController();
    TextEditingController _amountController = TextEditingController();
    DateTime _entryDate = DateTime.now();

    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              Text(
                isEarning ? "Add Earning" : "Add Expense",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: isEarning ? Colors.green : Colors.red,
                ),
              ),
              SizedBox(height: 20),
              TextField(
                controller: _titleController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5),
                  ),
                  hintText: isEarning
                      ? "Enter Earning Title"
                      : "Enter Expense Title",
                  hintStyle: TextStyle(
                    color: isEarning ? Colors.green : Colors.red,
                  ),
                ),
              ),
              SizedBox(height: 20),
              TextField(
                controller: _amountController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5),
                  ),
                  hintText: isEarning
                      ? "Enter Earning Amount"
                      : "Enter Expense Amount",
                  hintStyle: TextStyle(
                    color: isEarning ? Colors.green : Colors.red,
                  ),
                ),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  if (_titleController.text.isNotEmpty &&
                      _amountController.text.isNotEmpty) {
                    addEntry(
                      _titleController.text,
                      double.parse(_amountController.text),
                      _entryDate,
                      isEarning,
                    );
                    Navigator.pop(context);
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: isEarning ? Colors.green : Colors.red,
                ),
                child: Text(
                  isEarning ? "Add Earning" : "Add Expense",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Expense Tracker"),
        centerTitle: true,
        bottom: TabBar(
          controller: _tabController,
          labelColor: Colors.white,
          unselectedLabelColor: Colors.white70,
          tabs: [
            Tab(
              text: "Earning",
              icon: Icon(Icons.arrow_upward, color: Colors.green),
            ),
            Tab(
              text: "Expenses",
              icon: Icon(Icons.arrow_downward, color: Colors.red),
            ),
          ],
        ),
      ),
      backgroundColor: Colors.teal[50],
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Row(
              children: [
                _buildSummaryCard(
                  title: "Earnings",
                  value: _totalEarnings,
                  color: Colors.green,
                ),
                _buildSummaryCard(
                  title: "Expenses",
                  value: _totalExpenses,
                  color: Colors.red,
                ),
                _buildSummaryCard(
                  title: "Balances",
                  value: _totalBalance,
                  color: Colors.blue,
                ),
              ],
            ),
            SizedBox(height: 10),
            Expanded(
              child: TabBarView(
                controller: _tabController,
                children: [
                  _buildList(_earnings, Colors.green, true),
                  _buildList(_expenses, Colors.red, false),
                ],
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _FABOptions(context);
        },
        child: Icon(Icons.add),
      ),
    );
  }
}

Widget _buildSummaryCard({
  required String title,
  required double value,
  required Color color,
}) {
  return Expanded(
    child: Card(
      color: color,
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Text(
              title,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
                color: Colors.white,
              ),
            ),
            SizedBox(height: 10),
            Text(
              value.toString(),
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    ),
  );
}

Widget _buildList(
  List<Map<String, dynamic>> items,
  Color color,
  bool isEarning,
) {
  return ListView.builder(
    itemCount: items.length,
    itemBuilder: (context, index) {
      return Card(
        child: ListTile(
          leading: CircleAvatar(
            backgroundColor: Colors.greenAccent,
            child: Icon(isEarning ? Icons.arrow_upward : Icons.arrow_downward),
          ),
          title: Text(items[index]['title']),
          subtitle: Text(DateFormat('dd/MM/yyyy').format(items[index]['date'])),
          trailing: Text(
            "৳ ${items[index]['amount'].toStringAsFixed(2)}",
            style: TextStyle(color: color, fontWeight: FontWeight.bold),
          ),
        ),
      );
    },
  );
}
