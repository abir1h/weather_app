class ImageAssets {
  const ImageAssets._();

  //:::::::::::::::::: IMAGE SETS ::::::::::::::::::
  static String get weather => 'Animation - 1727236586949'.json;
  static String get splashAnitmation => 'Animation - 1727236939848'.json;
  static String get loader => 'Animation - 1727282930219'.json;
  static String get sunset => 'Animation - 1727285179658'.json;
  static String get locationIcon => 'location'.svg;
  static String get object => 'object'.png;



}

extension on String {
  String get png => 'assets/images/$this.png';
  String get jpg => 'assets/images/$this.jpg';
  String get svg => 'assets/images/$this.svg';
  String get json => 'assets/animations/$this.json';
}
