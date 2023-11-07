


import 'package:flutter/material.dart';
import 'package:flutter_todo/AddTaskPage.dart';
import 'package:flutter_todo/SQLiteHelper.dart';
import 'dart:developer';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});


  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final dbHelper = SQLiteHelper.instance;
  var dataList;
  var listData;

  @override
  void initState() {
    super.initState();
    initializeData();
  }
  Future<void> initializeData() async {
    dataList = await dbHelper.getDataList();
    log('dataList: $dataList');
    setState(() {
      listData = dataList;
    });
  }
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(

        backgroundColor: Theme.of(context).colorScheme.inversePrimary,

        title: const Text('Task'),
      ),
      body: ListView.builder(itemCount: listData.length,
      itemBuilder: (context,index){
        return ListTile(
          title: Text(listData[index]['title'],style: TextStyle(fontSize: 24),),
          subtitle: Text(listData[index]['date']),
        );
      },),
      floatingActionButton: FloatingActionButton(
        onPressed: ()async{
          Navigator.push (
            context,
            MaterialPageRoute (
              builder: (BuildContext context) => const AddTaskPage(),
            ),
          ).then((value){
            initializeData();
          });
        },
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
