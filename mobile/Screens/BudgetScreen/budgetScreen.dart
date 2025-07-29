import 'package:flutter/material.dart';
import 'package:byte_blossoms/model/budgetModel.dart'; 
import 'package:byte_blossoms/services/budgetService.dart'; 

class ViewBudgetsBody extends StatefulWidget {
  final String userID;

  ViewBudgetsBody({required this.userID});

  @override
  _ViewBudgetsBodyState createState() => _ViewBudgetsBodyState();
}

class _ViewBudgetsBodyState extends State<ViewBudgetsBody> {
  List<BudgetDetails> _budgets = [];
  List<BudgetDetails> _filteredBudgets = [];
  bool _isLoading = true;
  String _errorMessage = '';
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _fetchBudgetsByUserID();
    _searchController.addListener(() {
      _filterBudgets(_searchController.text);
    });
  }

  Future<void> _fetchBudgetsByUserID() async {
    try {
      final BudgetService budgetService = BudgetService();
      final budgets = await budgetService.getBudgetDetailsByUserID(widget.userID);

      if (mounted) {
        setState(() {
          if (budgets.isEmpty) {
            _errorMessage = ' ';
          } else {
            _budgets = budgets;
            _filteredBudgets = budgets; 
          }
          _isLoading = false;
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _errorMessage = 'Failed to load budget updates: ${e.toString()}';
          _isLoading = false;
        });
      }
    }
  }

  void _filterBudgets(String query) {
    if (query.isEmpty) {
      setState(() {
        _filteredBudgets = _budgets;
      });
    } else {
      setState(() {
        _filteredBudgets = _budgets
            .where((budget) =>
                budget.title!.toLowerCase().contains(query.toLowerCase()) ||
                budget.societyName!.toLowerCase().contains(query.toLowerCase()))
            .toList();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return Center(child: CircularProgressIndicator());
    }

    return Column(
      children: [
        _buildSearchBar(),
        Expanded(
          child: _errorMessage.isNotEmpty
              ? Center(child: Text(_errorMessage, style: TextStyle(fontSize: 18.0)))
              : ListView.builder(
                  itemCount: _filteredBudgets.length,
                  itemBuilder: (context, index) {
                    final budget = _filteredBudgets[index];

                    return Card(
                      color: Colors.white,
                      child: Container(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Row(
                              children: <Widget>[
                                Expanded(
                                  child: Text(
                                    budget.title ?? 'No Title',
                                    style: TextStyle(
                                      fontSize: 16.0,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 5.0),
                            Padding(
                              padding: const EdgeInsets.only(left: 8.0),
                              child: Text(
                                budget.description ?? 'No Description',
                                style: TextStyle(
                                  color: Colors.black,
                                ),
                              ),
                            ),
                            SizedBox(height: 10.0),
                            Padding(
                              padding: const EdgeInsets.only(left: 8.0),
                              child: Text(
                                'Society: ${budget.societyName ?? 'No Society'}',
                                style: TextStyle(
                                  color: Color.fromARGB(255, 105, 105, 105),
                                  fontSize: 12.0,
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 8.0),
                              child: Text(
                                'Status: ${budget.status ?? 'No Status'}',
                                style: TextStyle(
                                  color: Color.fromARGB(255, 105, 105, 105),
                                  fontSize: 12.0,
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 8.0),
                              child: Text(
                                 'Created At: ${budget.createdAt.day}/${budget.createdAt.month}/${budget.createdAt.year}'
                                    ?? 'No Date',
                                style: TextStyle(
                                  color: Color.fromARGB(255, 105, 105, 105),
                                  fontSize: 12.0,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
        ),
      ],
    );
  }

  Widget _buildSearchBar() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextField(
        controller: _searchController,
        decoration: InputDecoration(
          hintText: 'Search budgets...',
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
            borderSide: BorderSide.none,
          ),
          filled: true,
          fillColor: const Color.fromARGB(255, 239, 239, 239),
          contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
          suffixIcon: Icon(Icons.search, color: Color.fromARGB(255, 248, 122, 12)),
        ),
      ),
    );
  }
}
