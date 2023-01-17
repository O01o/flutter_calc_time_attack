void main() {
  List hoge = ["apple", "orange", "banana"];
  List hoge2 = List.unmodifiable(hoge);
  hoge[2] = "lemon";
  print(hoge);
  print(hoge2);

  return;
}