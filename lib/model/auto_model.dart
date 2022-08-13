import 'dart:async';
import 'package:flutter/material.dart';

abstract class Model<T extends StatefulWidget> extends State<T> {
  List<StreamController> stream = [];

  Function(dynamic events) onDataChange = (event) {};

  registerModel(List<Models> listModel) {
    for (var i in listModel) {
      stream.add(i.listen());

      i.listen().stream.listen((event) {
        i.getFunction();
      });
    }
  }

  @override
  void initState() {
    _checkStream();
    registerModel([]);

    super.initState();
  }

  @override
  void dispose() {
    _checkStream();

    super.dispose();
  }

  _checkStream() {
    for (var i in stream) {
      i.close();
    }
  }
}

abstract class Models<T> {
  StreamController<T> stream = StreamController<T>();
  T getModel() {
    return T as T;
  }

  getData();

  getFunction();

  StreamController<T> listen();
}
