import 'package:flutter/material.dart';

class Editor extends StatelessWidget {
  final TextEditingController _controller;
  final String label;
  final String hint;
  final IconData icon;
  final TextInputType inputType;

  const Editor(this._controller,
      {this.label, this.hint, this.icon, this.inputType});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: TextField(
        controller: _controller,
        style: TextStyle(
          fontSize: 20.0,
        ),
        decoration: InputDecoration(
          labelText: label,
          hintText: hint,
          icon: icon != null ? Icon(icon) : null,
        ),
        keyboardType: inputType != null ? inputType : null,
      ),
    );
  }
}
