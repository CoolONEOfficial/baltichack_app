import 'package:flutter/material.dart';

class Place {
  final String name;
  final String description;
  final TimeOfDay open;
  final TimeOfDay close;
  final String videoUrl;

  Place(this.name, this.description, this.open, this.close, this.videoUrl);
}