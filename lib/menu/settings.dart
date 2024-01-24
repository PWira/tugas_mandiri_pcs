import 'package:flutter/material.dart';

class Settings extends StatefulWidget {
  const Settings({super.key});

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  var mode;
  TextEditingController ipConnector = TextEditingController();
  TextEditingController formatHTTP = TextEditingController();

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
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // // Judul
            // TextFormField(
            //   controller: ipConnector,
            //   decoration: InputDecoration(
            //     border: OutlineInputBorder(
            //       borderRadius: BorderRadius.circular(10.0),
            //       borderSide: BorderSide(color: Colors.blue),
            //     ),
            //     focusedBorder: OutlineInputBorder(
            //       borderRadius: BorderRadius.circular(10.0),
            //       borderSide: BorderSide(color: Colors.blue),
            //     ),
            //     hintText: 'IP Website',
            //   ),
            // ),
            // SizedBox(height: 16.0),

            // TextFormField(
            //   controller: formatHTTP,
            //   decoration: InputDecoration(
            //     border: OutlineInputBorder(
            //       borderRadius: BorderRadius.circular(10.0),
            //       borderSide: BorderSide(color: Colors.blue),
            //     ),
            //     focusedBorder: OutlineInputBorder(
            //       borderRadius: BorderRadius.circular(10.0),
            //       borderSide: BorderSide(color: Colors.blue),
            //     ),
            //     hintText: 'HTTP FORMAT (Http/Https)',
            //   ),
            // ),
            // SizedBox(height: 16.0),
            
          ],
        ),
      ),
    );
  }
}