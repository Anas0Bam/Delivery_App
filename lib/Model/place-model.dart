class Place{

  String _image;
  String _name;
  String _type;
  String _coordinates;
  String _nieprhood;
  String _lat;
  String _lng;
  String _rate;

  Place(this._image, this._name, this._rate,this._type,this._nieprhood ,this._coordinates,this._lat,this._lng);

  String get rate => _rate;


  String get coordinates => _coordinates;

  set coordinates(String value) {
    _coordinates = value;
  }

  set rate(String value) {
    _rate = value;
  }

  String get name => _name;

  set name(String value) {
    _name = value;
  }

  String get image => _image;

  set image(String value) {
    _image = value;
  }

  String get lng => _lng;

  set lng(String value) {
    _lng = value;
  }

  String get lat => _lat;

  set lat(String value) {
    _lat = value;
  }

  String get type => _type;

  set type(String value) {
    _type = value;
  }

  String get nieprhood => _nieprhood;

  set nieprhood(String value) {
    _nieprhood = value;
  }
}