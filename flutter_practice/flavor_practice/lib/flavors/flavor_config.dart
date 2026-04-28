enum Flavor { dev, stag, prod }

class FlavorConfig {
  final Flavor flavor;
  final String name;
  final String? apiUrl;

  static FlavorConfig? _instance;

  FlavorConfig._({required this.flavor, required this.name, this.apiUrl});

  factory FlavorConfig({
    required Flavor flavor,
    required String name,
    String? apiUrl,
  }) {
    _instance ??= FlavorConfig._(flavor: flavor, name: name, apiUrl: apiUrl);
    return _instance!;
  }

  static FlavorConfig get instance {
    if (_instance == null) {
      throw Exception("not initialized");
    }
    return _instance!;
  }

  static bool isDev() => instance.flavor == Flavor.dev;

  static bool isStage() => instance.flavor == Flavor.stag;

  static bool isProd() => instance.flavor == Flavor.prod;
}
