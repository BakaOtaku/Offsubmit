import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController _downloadLink = TextEditingController();
  TextEditingController _password = TextEditingController();
  TextEditingController _subId = TextEditingController();
  // TextEditingController _controller = TextEditingController();
  // TextEditingController _controller = TextEditingController();
  // TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Exam"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              TextFormField(
                controller: _downloadLink,
              ),
              RaisedButton(
                onPressed: () {},
                child: Text("Download"),
              ),
              SizedBox(
                height: 20,
              ),
              RaisedButton(
                onPressed: () {},
                child: Text("Choose File"),
              ),
              TextFormField(
                controller: _password,
              ),
              RaisedButton(
                onPressed: () {},
                child: Text("Decrypt"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
