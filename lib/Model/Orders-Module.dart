class Orders {
  String _image;
  String _nameStore;
  bool _textChanger;
  int _textamount;
  String _orders;
  String _displaytime;

  Orders(this._image, this._nameStore, this._textChanger, this._textamount,
      this._orders, this._displaytime);

  String get image => _image;

  set image(String value) {
    _image = value;
  }

  String get namestore => _nameStore;

  set namestore(String value) {
    _nameStore = value;
  }

  bool get textChanger => _textChanger;

  set textChanger(bool value) {
    _textChanger = value;
  }

  int get amount => _textamount;

  set amount(int value) {
    _textamount = value;
  }

  String get orders => _orders;

  set orders(String value) {
    _orders = value;
  }

  String get displaytime => _displaytime;

  set displaytime(String value) {
    _displaytime = value;
  }

}
