import 'ui_factory.dart';
import '../products/button/my_button.dart';
import '../products/button/light_button.dart';
import '../products/text/my_text.dart';
import '../products/text/light_text.dart';

class LightFactory implements UIFactory {
  @override
  MyButton createButton() => LightButton();

  @override
  MyText createText() => LightText();
}
