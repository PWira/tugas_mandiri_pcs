import 'package:flutter/material.dart';
import 'package:toggle_switch/toggle_switch.dart';

class Settings extends StatefulWidget {
  const Settings({super.key});

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  var mode;

  @override
  void initState() {
    mode = 0;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Settings'),
      ),
      body: Container(
        padding: EdgeInsets.only(top: 15),
        color: mode == 0 ? Colors.white : Colors.black,
        child: ListView(
          children: [
            Card(
              margin:
                  const EdgeInsets.only(left: 35, right: 35, bottom: 10),
              color: Colors.white70,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
              ),
              child: ListTile(
                leading: mode == 0 ? Icon(
                  Icons.light_mode,
                  color: Colors.black54,
                )
                :
                Icon(
                  Icons.dark_mode_sharp,
                  color: Colors.black54,
                ),
                title: mode == 0
                    ? Text(
                        'Light Mode',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: mode == 0 ? Colors.black : Colors.white,
                        ),
                      )
                    : Text(
                        'Dark Mode',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: mode == 0 ? Colors.black : Colors.white,
                        ),
                      ),
                trailing: ToggleSwitch(
                  minWidth: 90.0,
                  cornerRadius: 20.0,
                  activeBgColors: [
                    [Colors.lightBlue[500]!],
                    [Colors.black]
                  ],
                  activeFgColor: Colors.white,
                  inactiveFgColor: Colors.white,
                  initialLabelIndex: mode,
                  totalSwitches: 2,
                  labels: ['Light', 'Dark'],
                  radiusStyle: true,
                  onToggle: (index) {
                    setState(() {
                      mode = index;
                    });
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}