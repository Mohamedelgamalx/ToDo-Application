import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:todo_app/database/sqldb.dart';

class AddTask extends StatefulWidget {
  const AddTask({super.key});

  @override
  State<AddTask> createState() => _AddTaskState();
}

class _AddTaskState extends State<AddTask> {
  
  SqlDb sqldb = SqlDb();

  TextEditingController task = TextEditingController();
  TextEditingController date = TextEditingController();

  addData() async {
    int response = await sqldb.insertData('''
      INSERT INTO tasker ( `task` , `date` )
      VALUES   ( "${task.text}", "${date.text}")
      ''');
    if (response > 0) {
      setState(() {});
    }
  }

    @override
    Widget build(BuildContext context) {
      return FloatingActionButton(
        onPressed: () {
          showModalBottomSheet(
              isScrollControlled: true,
              context: context,
              builder: (BuildContext context) {
                return Padding(
                  padding: EdgeInsets.only(
                    bottom: MediaQuery
                        .of(context)
                        .viewInsets
                        .bottom,
                  ),
                  child: Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20)
                    ),
                    height: 240,
                    child: Column(
                      children: [
                        TextFormField(
                          controller: task,
                          textInputAction: TextInputAction.next,
                          decoration: const InputDecoration(
                            hintText: 'Task',
                          ),
                        ),
                        TextFormField(
                          controller: date,
                          decoration: const InputDecoration(
                              hintText: "No due date" //label text of field
                          ), //set it true, so that user will not able to edit text
                        ),
                        const SizedBox(height: 20,),
                        Row(
                          children: [
                            const SizedBox(width: 20,),
                            IconButton(
                                onPressed: () async {
                                  DateTime? chooseDate = await showDatePicker(
                                      context: context,
                                      initialDate: DateTime.now(),
                                      firstDate: DateTime(1920),
                                      lastDate: DateTime(2100)
                                  );
                                  if (chooseDate != null) {
                                    String sortDate = DateFormat('yyyy-MM-dd')
                                        .format(chooseDate);
                                    setState(() {
                                      date.text = sortDate;
                                    });
                                  }
                                },
                                icon: const Icon(Icons.calendar_month_outlined,
                                  color: Colors.blue,)
                            ),
                            const SizedBox(width: 170,),
                            ElevatedButton(onPressed: () {
                              Navigator.pop(context);
                            },
                              style: ElevatedButton.styleFrom(
                                  elevation: 0,
                                  backgroundColor: const Color(0xfffafafa)),
                              child: const Text('Cancel',
                                style: TextStyle(color: Colors.black),),
                            ),
                            ElevatedButton(onPressed: () {
                              addData();
                              Navigator.of(context).pop();
                            },
                              style: ElevatedButton.styleFrom(
                                  elevation: 0,
                                  backgroundColor: const Color(0xfffafafa)),
                              child: const Text(
                                'Save', style: TextStyle(color: Colors.blue),),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                );
              });
        },
        child: const Icon(Icons.add),
      );
    }
  }