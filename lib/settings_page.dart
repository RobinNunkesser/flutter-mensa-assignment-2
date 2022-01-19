import 'package:flutter/material.dart';

class SettingsPage extends StatefulWidget {
  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  int _value = 1;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        for (int i = 1; i <= 5; i++)
          ListTile(
            title: Text(
              'Radio $i',
              style: Theme.of(context)
                  .textTheme
                  .subtitle1
                  ?.copyWith(color: Colors.black),
            ),
            leading: Radio(
              value: i,
              groupValue: _value,
              activeColor: Color(0xFF6200EE),
              onChanged:
              (int? value) {
                setState(() {
                  _value = value!;
                });
              },
            ),
          ),
      ],
    );
  }
}