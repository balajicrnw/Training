class Cart {
  final List<String> items = [];

  void addItem(String item) {
    items.add(item);
  }

  void removeItem(String item) {
    items.remove(item);
  }
}