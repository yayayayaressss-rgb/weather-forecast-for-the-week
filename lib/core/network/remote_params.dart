abstract class Params {}

class ParamsName implements Params {
  final String name;

  ParamsName({required this.name});
}

class ParamsGeo implements Params {
  final double lat;
  final double lon;

  ParamsGeo({required this.lat, required this.lon});
}
