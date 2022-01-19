import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

String statusKey = 'status';

class SettingsPage extends StatefulWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  int _value = 0;
  final List<String> _radioOptions = ["Student", "Employee", "Pupil", "Other"];
  late SharedPreferences prefs;

  @override
  void initState() {
    readStatus();
    super.initState();
  }

  readStatus() async{
    prefs = await SharedPreferences.getInstance();
    setState(() {
      _value = prefs.getInt(statusKey) ?? 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        for (int i = 0; i < _radioOptions.length; i++)
          ListTile(
            title: Text(
              _radioOptions[i],
              style: Theme.of(context)
                  .textTheme
                  .subtitle1
                  ?.copyWith(color: Colors.black),
            ),
            leading: Radio(
              value: i,
              groupValue: _value,
              activeColor: const Color(0xFF6200EE),
              onChanged:
              (int? value) async {
                setState(() {
                  _value = value!;
                });
                await prefs.setInt(statusKey, _value);
              },
            ),
          ),
      ],
    );
  }
}