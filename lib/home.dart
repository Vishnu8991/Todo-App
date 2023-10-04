import 'package:flutter/material.dart';
import 'package:todo/database/todo_db.dart';
import 'package:todo/models/todo_model.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => HomeState();
}

class HomeState extends State<Home> {
  List<Todo> todos = [];

  @override
  void initState() {
    super.initState();
    loadTodos();
  }

  void loadTodos() async {
    todos = await TodoDb.instance.getTask();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("ToDo App"),centerTitle: true,),
      body: todos.isEmpty ? Center(child: Text("No tasks")): ListView.builder(
        itemCount: todos.length,
        itemBuilder: (context, index){
          final todo = todos[index];
          return Padding(
      padding: const EdgeInsets.only(top: 10, left: 10, right: 10),
      child: Card(shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        child: ListTile(
          title: Text(todo.titles,style: TextStyle(fontSize: 18),),
          subtitle: Text(todo.subtitles),
          trailing: Wrap(children: [

            IconButton(onPressed: () => dialogBox(), 
            icon: Icon(Icons.edit)
            ),

            IconButton(onPressed: () async{
              await TodoDb.instance.deleteTask(todo);
                loadTodos();
            }, icon: Icon(Icons.delete, color: Colors.red)
            ),


          ],)
        ),
      ),
    );
      }),
      floatingActionButton: FloatingActionButton(
        onPressed: () => dialogBox(),
        child: Icon(Icons.add),
        backgroundColor: Colors.grey[400],
        ),
        
    );
  }


  final title = TextEditingController();
  final subtitle = TextEditingController();

  
  void dialogBox() {
    showDialog(context: context, builder: (context){
      return AlertDialog(
        content: Container(
          height: 202,
          child: Column(
            children: [
              TextField(
                controller: title,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: "Title",
                  fillColor: Colors.grey[800],
                  filled: true,
                ),
              ),
              SizedBox(height: 5,),
              TextField(
                maxLines: 2,
                controller: subtitle,
                decoration: InputDecoration(
                  fillColor: Colors.grey[800],
                  filled: true,
                  border: OutlineInputBorder(),
                  hintText: "Content",
                  
                ),
              ),
              SizedBox(height: 12,),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  ElevatedButton(
                    onPressed: (){
                      return edit();
                    }, 
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text("Cancel",style: TextStyle(fontSize: 16),),
                    )),

                  SizedBox(width: 5,),

                  ElevatedButton(
                    onPressed: (){
                      return show();
                    }, 
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text("Submit",style: TextStyle(fontSize: 16),),
                    )),
                    
                ],
              )
            ],
          ),
        ),
        backgroundColor: Colors.grey[700],
      );
    }
    );
  }
  
  void show() async{
    final name = title.text.trim();
    final sub = subtitle.text.trim();

    if(name != "" && sub != ""){
      final add = Todo(titles: name, subtitles: sub);
      await TodoDb.instance.addTask(add);
      Navigator.of(context).pop();
      title.clear();
      subtitle.clear();
      loadTodos();
    }
  }
  
  void edit() async{
    Navigator.of(context).pop();
    title.clear();
    subtitle.clear();
  }

}
