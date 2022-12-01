import 'dart:math';

import 'package:flutter/material.dart';
import 'package:mobigic_assignment/repo/models/alphabet_model.dart';
import 'package:mobigic_assignment/repo/models/grid_model.dart';
import 'package:mobigic_assignment/screens/dfs.dart';

class GridScreen extends StatefulWidget {
  final GridModel gridModel;
  const GridScreen({Key? key, required this.gridModel}) : super(key: key);

  @override
  State<GridScreen> createState() => _GridScreenState();
}

class _GridScreenState extends State<GridScreen> {
  final TextEditingController _searchController = TextEditingController();

  List<AlphabetModel> _alphabets = [];
  List<List<String>> grid = [];
  List<String> selected = [];

  @override
  void initState() {
    grid = convertGrid(widget.gridModel.alphabets ?? '');
    for (String element in (widget.gridModel.alphabets?.split("") ?? [])) {
      _alphabets.add(AlphabetModel(char: element, isSelected: false));
    }

    String word = '';
    _searchController.addListener(
      () {
        word = _searchController.text;
        if (word.isNotEmpty) {
          DFS().patternSearch(
            grid,
            word,
            widget.gridModel.rows ?? 0,
            widget.gridModel.columns ?? 0,
          );
        }
        var searched = _alphabets.map((e) {
          if (word.contains(e.char)) {
            e.isSelected = true;
            selected.add(e.char);
          } else {
            e.isSelected = false;
            selected.remove(e.char);
          }
          return e;
        }).toList();
        setState(() => _alphabets = searched);
      },
    );

    super.initState();
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

  List<List<String>> convertGrid(String str) {
    int l = str.length;
    int k = 0, row, column;
    row = sqrt(l).floor();
    column = sqrt(l).ceil();
    if (row * column < l) {
      row = column;
    }
    List<List<String>> s = List.generate(row, (index) => List.generate(column, (j) => ""));
    for (int i = 0; i < row; i++) {
      for (int j = 0; j < column; j++) {
        s[i][j] = str[k];
        k++;
      }
    }

    /// Print the grid
    for (int i = 0; i < row; i++) {
      for (int j = 0; j < column; j++) {
        if (s[i][j] == '\0') {
          break;
        }
        print(s[i][j]);
      }
      print("");
    }
    return s;
  }
}
