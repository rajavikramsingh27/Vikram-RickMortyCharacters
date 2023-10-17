

import 'package:flutter/material.dart';

class LoaderApp {
  static Widget loader() {
    return const Center(
      child:  CircularProgressIndicator(
        color: Colors.green,
      ),
    );
  }
}