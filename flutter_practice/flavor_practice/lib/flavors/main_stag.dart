import 'package:flavor_practice/flavors/flavor_config.dart';
import 'package:flavor_practice/main_common.dart';

void main(){
  mainCommon(flavor: Flavor.stag, name: "staging", apiUrl: "https://uselessfacts.jsph.pl/api/v2/facts/random");
}