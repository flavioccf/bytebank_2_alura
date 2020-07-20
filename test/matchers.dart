import 'package:bytebank_2/screens/dashboard.dart';
import 'package:flutter/material.dart';

bool featureItemMatcher(Widget widget, String name, IconData icon, String key) {
  if (widget is FeatureItem) {
    return widget.name == name && widget.icon == icon && widget.key == Key(key);
  }
  return false;
}
