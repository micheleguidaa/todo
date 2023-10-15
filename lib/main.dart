import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget{
  const MyHomePage({super.key});

  @override
  State<StatefulWidget> createState() => MyHomePageState();
}

class MyHomePageState extends State<StatefulWidget>{
  List task = [];
  final nameTask = TextEditingController();

  void deleteTask(int index){
    setState(() {
      task.removeAt(index);
    });
  }

  void saveTask(){
    setState(() {
      task.add([nameTask.text,false]);
       nameTask.clear();
    });
    Navigator.of(context).pop();
  }


  void createTask(){
    showDialog(context: context, builder: (context) {
       return AlertDialog(
        titlePadding: const EdgeInsets.only(left:17,top:20,bottom: 8),
        title: const Text("Add Task:",style: TextStyle(color: Colors.white),),
        backgroundColor: Colors.deepPurple,
        actions: [
           Padding(
            padding: EdgeInsets.only(left:8,top:8),
            child: TextField(
              controller: nameTask,
              style: const TextStyle(color: Colors.white),
              decoration: const InputDecoration(
                hintText: "name task",
                hintStyle: TextStyle(color: Colors.grey),
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
            TextButton(onPressed: () => cancelTask(),child: const Text("CANCEL",style: TextStyle(color: Colors.white),)),
            TextButton(onPressed: ()=>saveTask(),child: const Text("SAVE",style: TextStyle(color: Colors.white),)),
            ],
          )
        ],
       );
    },);
  }

  void cancelTask(){
    Navigator.of(context).pop();
    nameTask.clear();
  }

  @override
  Widget build(BuildContext context) {
   return Scaffold(
    appBar: AppBar(
      title: const Text("TO DO"),
      centerTitle: true,
      backgroundColor: Colors.deepPurple,
      elevation: 0,
    ),
    body: Container(
      color: Colors.black87,
      child: ListView(
          children: [
            const SizedBox(height: 10),
            for(int i=0;i<task.length;i++)
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Slidable(
                endActionPane: ActionPane(
                  motion: StretchMotion(),
                   children: [
                    SlidableAction(
                      icon: Icons.delete,
                      onPressed: (context) => deleteTask(i),
                      backgroundColor: Colors.red.shade400,
                      borderRadius: BorderRadius.circular(20),
                      ),
                   ]),
                child: Container(
                  height: 50,
                  width: double.infinity,
                  decoration: BoxDecoration(color: Colors.deepPurple,borderRadius: BorderRadius.circular(20)),
                  child: Row(
                    children: [
                      Checkbox(value: task[i][1], onChanged: (value) {
                        setState(() {
                          task[i][1] = !task[i][1];
                        });
                      },),
                      Text(task[i][0],style:  TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      decoration: task[i][1] ? TextDecoration.lineThrough : TextDecoration.none,
                      decorationThickness: 2,
                      decorationColor: Colors.black,
                      ),
                      ),
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
    ),
    floatingActionButton: FloatingActionButton(onPressed: createTask,backgroundColor: Colors.deepPurple,child: const Icon(Icons.add),),
      );
  }
}
