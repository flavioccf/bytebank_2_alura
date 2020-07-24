import 'package:bytebank_2/screens/dashboard.dart';
import 'package:flutter/material.dart';

bool featureItemMatcher(Widget widget, String name, IconData icon, String key) {
  if (widget is FeatureItem) {
    return widget.name == name && widget.icon == icon && widget.key == Key(key);
  }
  return false;
}

bool textFieldByLabelTextMatcher(Widget widget, String labelText) {
  if (widget is TextField) {
    return widget.decoration.labelText == labelText;
  }
  return false;
}
