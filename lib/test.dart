import 'dart:math';
import 'dart:convert';
void main() {
  int x0 = 120;
  int y0 = 120;
  int x1 = 360;
  int y1 = 240;

  double rad0 = 360 * atan2(0, 0) / (2 * pi);
  double rad90 = 360 * atan2(1, 0) / (2 * pi);
  double rad180 = 360 * atan2(0, -1) / (2 * pi);
  double rad270 = 360 * atan2(-1, 1) / (2 * pi);

  double rad = 360 * atan2(y1-y0, x1-x0) / (2 * pi);

  print("$rad, $rad0, $rad90, $rad180, $rad270");
  String sampleData = """[
    { "issue": "以下の式を計算しなさい。", "formula": "f(x) = 2x + 3, x = 3", "a": "3", "b": "11", "c": "9", "d": "8"},
    { "issue": "以下の式を計算しなさい。", "formula": "f(x) = 2x + 3, x = 3", "a": "3", "b": "11", "c": "9", "d": "8"},
    { "issue": "以下の式を計算しなさい。", "formula": "f(x) = 2x + 3, x = 3", "a": "3", "b": "11", "c": "9", "d": "8"},
    { "issue": "以下の式を計算しなさい。", "formula": "f(x) = 2x + 3, x = 3", "a": "3", "b": "11", "c": "9", "d": "8"}
    ]""";
  var data = json.decode(sampleData);
  data.forEach((element) => { print(element["issue"]) });

  Map<String, dynamic> map = {
    "data0": "aiueo",
    "data1": 3,
    "data2": true
  };

  print(map);
  print(map.runtimeType);

}