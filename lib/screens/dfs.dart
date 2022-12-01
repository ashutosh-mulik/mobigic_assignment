class DFS {
  // Rows and columns in the given grid
  int R = 0, C = 0;

  // For searching in all 8 direction
  List<int> x = [-1, -1, -1, 0, 0, 1, 1, 1];
  List<int> y = [-1, 0, 1, -1, 1, -1, 0, 1];

  // This function searches in all
  // 8-direction from point
  // (row, col) in grid[][]
  bool search2D(List<List<String>> grid, int row, int col, String word) {
    // If first character of word
    // doesn't match with
    // given starting point in grid.
    if (grid[row][col] != word.split("")[0]) return false;

    int len = word.split("").length;

    // Search word in all 8 directions
    // starting from (row, col)
    for (int dir = 0; dir < 8; dir++) {
      // Initialize starting point
      // for current direction
      int k, rd = row + x[dir], cd = col + y[dir];

      // First character is already checked,
      // match remaining characters
      for (k = 1; k < len; k++) {
        // If out of bound break
        if (rd >= R || rd < 0 || cd >= C || cd < 0) break;

        // If not matched, break
        if (grid[rd][cd] != word.split("")[k]) break;

        // Moving in particular direction
        rd += x[dir];
        cd += y[dir];
      }

      // If all character matched,
      // then value of must
      // be equal to length of word
      if (k == len) return true;
    }
    return false;
  }

  // Searches given word in a given
  // matrix in all 8 directions
  void patternSearch(List<List<String>> grid, String word, int row, int col) {
    R = row;
    C = col;
    // Consider every point as starting
    // point and search given word
    for (int row = 0; row < R; row++) {
      for (int col = 0; col < C; col++) {
        if (grid[row][col] == word.split("")[0] && search2D(grid, row, col, word)) {
          print("pattern found at $row $col");
        }
      }
    }
  }
}
