import '../products/button/my_button.dart';
import '../products/text/my_text.dart';

abstract class UIFactory {
  MyButton createButton();
  MyText createText();
}
