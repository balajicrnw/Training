import 'ui_factory.dart';
import '../products/button/my_button.dart';
import '../products/button/dark_button.dart';
import '../products/text/my_text.dart';
import '../products/text/dark_text.dart';

class DarkFactory implements UIFactory {
  @override
  MyButton createButton() => DarkButton();

  @override
  MyText createText() => DarkText();
}
