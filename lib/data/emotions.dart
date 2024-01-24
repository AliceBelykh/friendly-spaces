import 'package:friendly_spaces/my_components/my_svg_widget.dart';

final List<String> emotionsList = [
  "anger",
  "fear",
  "disgust",
  "joy",
  "sadness",
  "surprise"
];

final Map<String, MySvgWidget> emotionsMap = {
  for (var k in emotionsList)
    k: MySvgWidget(svgPath: "assets/emotion_icons/$k.svg", svgLabel: k)
};
