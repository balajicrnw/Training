import 'package:flavor_practice/flavors/flavor_config.dart';
import 'package:flavor_practice/main_common.dart';

void main() {
  mainCommon(
    flavor: Flavor.prod,
    name: "Production",
    apiUrl: "https://official-joke-api.appspot.com/random_joke",
  );
}
