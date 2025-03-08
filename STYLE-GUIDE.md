- Prefer expression function bodies in Dart rather than function that have a single `return` line.
  ```
  // GOOD
  int addOne(int x) => x + 1;

  // BAD
  int addOne(int x) {
      return x + 1;
  }
  ```

- Use the `spacing` parameter for `Column` and `Row` widgets, instead of `SizedBox`.
