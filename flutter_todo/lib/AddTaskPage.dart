import 'package:flutter/material.dart';
import 'package:flutter_todo/SQLiteHelper.dart';
import 'package:intl/intl.dart';

class AddTaskPage extends StatefulWidget {
  const AddTaskPage({super.key});

  @override
  State<AddTaskPage> createState() => _AddTaskPageState();
}

class _AddTaskPageState extends State<AddTaskPage> {
  final dbHelper = SQLiteHelper.instance;
  var dateTime;
    var  title = '';
   var text = '';

  final dateFormat = DateFormat('yyyy/MM/dd');
  String dateStr = "yyyy/MM/dd";


  @override
  void initState(){
    super.initState();
    dateTime = DateTime.now();

  }

  void _insert() async{
    Map<String,dynamic> row ={
      SQLiteHelper.title: title,
      SQLiteHelper.text: text,
      SQLiteHelper.date: dateStr
    };
    await dbHelper.insert(row);
    Navigator.pop(context);
  }

  _datePicker(BuildContext context) async{
    final DateTime? datePicked = await showDatePicker(context: context, initialDate: dateTime, firstDate: DateTime(2003), lastDate: DateTime(2024));
    if(datePicked != null && datePicked != dateTime){
      setState(() {
        dateTime = datePicked;
        dateStr = dateFormat.format(dateTime);
      });
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text("Add Task"),
      ),
      body: Container(
        padding: const EdgeInsets.all(8),
        child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const SizedBox(height: 30,),
             TextField(
              decoration: const InputDecoration(
                labelText: 'Task Title',
                hintText: 'Enter Task Title'
              ),
              onChanged: ((value){
                title = value;
              }),
            ) ,
            const SizedBox(height: 30,),
             TextField(
              decoration: const InputDecoration(
                  labelText: 'Task Detail',
                  hintText: 'Enter Task Detail'
              ),
               onChanged: ((value){
                 text = value;
               }),
            ) ,
            const SizedBox(height: 30,),
            const Align(
             alignment: Alignment.centerLeft,
             child: Text('End Date'),
            ),
            Text(dateStr,
            style: const TextStyle(fontSize: 24),),
            const SizedBox(height: 10,),
            ElevatedButton(onPressed:()=> _datePicker(context), child: const Text('Get end Date')),
            const SizedBox(height: 50),
            ElevatedButton(onPressed: _insert, child: const Text('Add Task'))


          ],
        ),
      ),
      )

    );
  }
}
