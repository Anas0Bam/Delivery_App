

class Neighborhood{

  String _street;
  String _neighborhood;
  double _lat;
  double _lng;




  Neighborhood(this._neighborhood,this._street,this._lat,this._lng);

  String get neighborhood => _neighborhood;

  set neighborhood(String value) {
    _neighborhood = value;
  }

  String get street => _street;

  set street(String value) {
    _street = value;
  }

  double get lng => _lng;

  set lng(double value) {
    _lng = value;
  }

  double get lat => _lat;

  set lat(double value) {
    _lat = value;
  }
}