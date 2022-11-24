import 'package:flutter/material.dart';
import 'package:mobigic_assignment/repo/models/alphabet_model.dart';
import 'package:mobigic_assignment/repo/models/grid_model.dart';

class GridScreen extends StatefulWidget {
  final GridModel gridModel;
  const GridScreen({Key? key, required this.gridModel}) : super(key: key);

  @override
  State<GridScreen> createState() => _GridScreenState();
}

class _GridScreenState extends State<GridScreen> {
  final TextEditingController _searchController = TextEditingController();

  List<AlphabetModel> _alphabets = [];

  @override
  void initState() {
    for (String element in (widget.gridModel.alphabets?.split("") ?? [])) {
      _alphabets.add(AlphabetModel(char: element, isSelected: false));
    }
    super.initState();

    /// Linear Search
    _search();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                color: Colors.white.withOpacity(0.1),
                child: TextField(
                  controller: _searchController,
                  cursorColor: Colors.white,
                  keyboardType: TextInputType.text,
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                    hintText: "Search",
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
              Expanded(
                child: GridView.count(
                  physics: const BouncingScrollPhysics(),
                  crossAxisCount: widget.gridModel.columns ?? 0,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                  children: _alphabets.map(_textWidget).toList(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _textWidget(AlphabetModel alphabetModel) {
    return Container(
      color: alphabetModel.isSelected ? Colors.white : Colors.white.withOpacity(0.15),
      child: Center(
        child: Text(
          alphabetModel.char,
          style: TextStyle(
            color: alphabetModel.isSelected ? Colors.black : Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  void _search() {
    _searchController.addListener(
      () {
        var searched = _alphabets.map((e) {
          if (e.char == _searchController.text) {
            e.isSelected = true;
          } else {
            e.isSelected = false;
          }
          return e;
        }).toList();
        setState(() => _alphabets = searched);
      },
    );
  }
}
