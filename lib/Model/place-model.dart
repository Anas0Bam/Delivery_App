class Place{

  String _image;
  String _name;
  String _rate;

  Place(this._image, this._name, this._rate);

  String get rate => _rate;

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
}