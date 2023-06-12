import 'package:flutter/material.dart';

class Category{

  String _name;
  String _icon;

  Category(this._name, this._icon);

  String get icon => _icon;

  set icon(String value) {
    _icon = value;
  }

  String get name => _name;

  set name(String value) {
    _name = value;
  }
}