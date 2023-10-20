import 'package:flutter/material.dart';
import '../database/sqldb.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  SqlDb sqldb = SqlDb();
  List tasks = [];

  final Map<int, String> _months = {
    1: "Jan", 2: "Feb", 3: "Mar", 4: "Apr", 5: "May", 6: "Jun",
    7: "Jul", 8: "Aug", 9: "Sep", 10: "Oct", 11: "Nov", 12: "Dec",
  };

  final Map<int, String> _weekdays = {
    1: "Monday", 2: "Tuesday", 3: "Wednesday", 4: "Thursday",
    5: "Friday", 6: "Saturday", 7: "Sunday",
  };

  bool choosing = false;

  DateTime date = DateTime.now();

  Future readData() async {
    List<Map> response = await sqldb.readData("SELECT * FROM tasker");
    tasks.addAll(response);
    if (mounted){
      setState(() {
      });
    }
    return response;
  }

  @override
  void initState() {
    readData();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          color: Colors.blue,
          height: 100,
          width: double.infinity,
          child: Row(
            children: [
              const SizedBox(width: 25,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('${date.day}',style: const TextStyle(
                    fontSize: 40,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                  ),
                  const SizedBox(width: 5,),
                  Column(
                    children: [
                      const SizedBox(height: 27,),
                      Text(_months[date.month]!.toUpperCase(),style: const TextStyle(
                        fontSize: 20,
                        color: Colors.white,
                      )
                      ),
                      Text('${date.year}',style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ))
                    ],
                  ),
                  const SizedBox(width: 130,),
                  Text('${_weekdays[date.weekday]}',style: const TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                  ),
                ],
              ),
            ],
          ),
        ),
        Expanded(
          child: ListView.builder(
            itemCount: tasks.length,
            shrinkWrap: true,
            itemBuilder: (context, index){
              return Card(
                margin: const EdgeInsets.all(1),
                elevation: 0,
                child: ListTile(
                  title: Text("${tasks[index]['task']}", style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),),
                  subtitle: Text("${tasks[index]['date']}"),
                  trailing: IconButton(
                    onPressed: () async {
                      int response = await sqldb.deleteData(
                          "DELETE FROM tasker WHERE id = ${tasks[index]['id']}" );
                      if (response > 0){
                        tasks.removeWhere((element) => element['id'] == tasks[index]['id']);
                        setState(() {
                        });
                      }
                    },
                    icon: const Icon(Icons.delete,
                      color: Colors.redAccent,),
                  ),
                  leading: Transform.scale(
                    scale: 1.8,
                    child: Checkbox(
                      shape: const CircleBorder(),
                      value: choosing,
                      onChanged: (value) {
                        setState(() {
                          choosing = value!;
                        });
                      },
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}