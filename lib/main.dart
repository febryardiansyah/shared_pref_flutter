import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';


void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
          primaryColor: Colors.pink
      ),
      home: HomeSweet(),
    );
  }
}
class HomeSweet extends StatefulWidget {
  @override
  _HomeSweetState createState() => _HomeSweetState();
}

class _HomeSweetState extends State<HomeSweet> {
  String nama = '';
  String nim = '';

  bool _data = false;

  TextEditingController nameCtrl = TextEditingController();
  TextEditingController nimCtrl = TextEditingController();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Shared Preferences'),
      ),
      body: ListView(
        padding: EdgeInsets.all(10),
        children: <Widget>[
          Padding(
            padding: EdgeInsets.all(10),
            child: TextField(
              controller: nameCtrl,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Nama',
                hintText: 'Masukan Nama',
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(10),
            child: TextField(
              controller: nimCtrl,
              decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'NIM',
                  hintText: 'Masukan NIM'
              ),
            ),
          ),
          RaisedButton(
            padding: EdgeInsets.all(10),
            child: Text('set'),
            onPressed: (){
              setIntoSharedPref();
            },
          ),
          RaisedButton(
            padding: EdgeInsets.all(10),
            child: Text('Get'),
            onPressed: (){
              getSharedPref();
            },
          ),
          _data?showData():Center()
        ],
      ),
    );
  }
  Widget showData(){
    return Card(
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Center(child: Text('Data Yang Dimasukan')),
            Divider(),
            Text('Nama Anda :\t$nama'),
            Divider(),
            Text('NIM anda :\t$nim'),
          ],
        ),
      ),
    );
  }
  void setIntoSharedPref()async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _data = false;
    });

    await prefs.setString('Nama', nameCtrl.text);
    await prefs.setString('NIM', nimCtrl.text);
    nameCtrl.clear();
    nimCtrl.clear();
  }
  void getSharedPref()async{
    setState(() {
      _data = true;
    });
    SharedPreferences prefs = await SharedPreferences.getInstance();

    setState(() {
      nama = prefs.getString('Nama');
      nim = prefs.getString('NIM');
    });
  }
}


