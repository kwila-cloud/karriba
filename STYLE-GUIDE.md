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
  ```
  // GOOD
  Column(
    spacing: 10,
    children: [
      Text('Item 1'),
      Text('Item 2'),
    ],
  );

  // BAD
  Column(
    children: [
      Text('Item 1'),
      SizedBox(height: 10),
      Text('Item 2'),
    ],
  );
  ```
