import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> with SingleTickerProviderStateMixin{
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this,);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Expense Tracker"),
        centerTitle: true,
        bottom: TabBar(
          controller: _tabController,
          tabs: [
          Tab(text: "Earning", icon: Icon(Icons.arrow_upward),),
          Tab(text: "Expenses", icon: Icon(Icons.arrow_downward),),
        ]),
      ),
    );
  }
}
