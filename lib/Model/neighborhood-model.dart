

class Neighborhood{

  String _street;
  String _neighborhood;

  Neighborhood(this._neighborhood,this._street);

  String get neighborhood => _neighborhood;

  set neighborhood(String value) {
    _neighborhood = value;
  }

  String get street => _street;

  set street(String value) {
    _street = value;
  }


}