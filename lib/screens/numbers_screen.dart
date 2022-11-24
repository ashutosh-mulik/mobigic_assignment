import 'package:flutter/material.dart';
import 'package:mobigic_assignment/repo/models/grid_model.dart';
import 'package:mobigic_assignment/screens/grid_screen.dart';

class NumbersScreen extends StatefulWidget {
  const NumbersScreen({Key? key}) : super(key: key);

  @override
  State<NumbersScreen> createState() => _NumbersScreenState();
}

class _NumbersScreenState extends State<NumbersScreen> {
  final GlobalKey _formKey = GlobalKey();
  final TextEditingController _rowController = TextEditingController();
  final TextEditingController _columnController = TextEditingController();
  final TextEditingController _alphabetController = TextEditingController();
  final GridModel _gridModel = GridModel();
  bool _isEnable = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                color: Colors.white.withOpacity(0.1),
                child: TextField(
                  controller: _rowController,
                  cursorColor: Colors.white,
                  keyboardType: TextInputType.number,
                  onChanged: (value) => _checkInputs(),
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                    hintText: "Rows (m)",
                    hintStyle: TextStyle(
                      color: Colors.white30,
                    ),
                  ),
                  style: const TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                color: Colors.white.withOpacity(0.1),
                child: TextField(
                  controller: _columnController,
                  cursorColor: Colors.white,
                  keyboardType: TextInputType.number,
                  onChanged: (value) => _checkInputs(),
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                    hintText: "Column (n)",
                    hintStyle: TextStyle(
                      color: Colors.white30,
                    ),
                  ),
                  style: const TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                color: Colors.white.withOpacity(0.1),
                child: TextField(
                  controller: _alphabetController,
                  keyboardType: TextInputType.text,
                  onChanged: (value) => _checkInputs(),
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: "Enter ${_calculateGridSize()} Alphabets",
                    hintStyle: const TextStyle(
                      color: Colors.white30,
                    ),
                  ),
                  style: const TextStyle(
                    color: Colors.white,
                  ),
                  cursorColor: Colors.white,
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    "${_alphabetController.text.length}/${_calculateGridSize()}",
                    style: const TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 40,
              ),
              GestureDetector(
                onTap: () {
                  if (_isEnable) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => GridScreen(
                          gridModel: _gridModel,
                        ),
                      ),
                    );
                  }
                },
                child: Container(
                  height: 45,
                  decoration: BoxDecoration(
                    color: _isEnable ? Colors.white : Colors.white30,
                  ),
                  child: const Center(
                    child: Text(
                      "Continue",
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

  void _checkInputs() {
    /// All fields should not be empty.
    if (_rowController.text.isEmpty || _columnController.text.isEmpty || _alphabetController.text.isEmpty) {
      setState(() => _isEnable = false);
      return;
    }

    int row = int.tryParse(_rowController.text) ?? 0;
    int column = int.tryParse(_columnController.text) ?? 0;

    /// n*m alphabets should be their.
    if (_alphabetController.text.length != (row * column)) {
      setState(() => _isEnable = false);
      return;
    }

    /// Remove space from text
    if (_alphabetController.text.contains(" ")) {
      _alphabetController.text = _alphabetController.text.replaceAll(" ", "");
      _alphabetController.selection = TextSelection.fromPosition(TextPosition(offset: _alphabetController.text.length));
    }

    setState(() => _isEnable = true);
    _gridModel.rows = row;
    _gridModel.columns = column;
    _gridModel.alphabets = _alphabetController.text;
  }

  String _calculateGridSize() {
    int row = int.tryParse(_rowController.text) ?? 0;
    int column = int.tryParse(_columnController.text) ?? 0;
    return (row * column).toStringAsFixed(0);
  }
}
