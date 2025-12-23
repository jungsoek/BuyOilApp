class Config {
  static late final Config instance;
  final bool isDebugMode;

  Config({ required this.isDebugMode }) {
    instance = this;
  }
}