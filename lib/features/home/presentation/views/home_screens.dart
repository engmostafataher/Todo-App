import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sqflite/sqflite.dart';
import 'package:todo_app/features/home/presentation/views/widgets/body_archive.dart';
import 'package:todo_app/features/home/presentation/views/widgets/body_done.dart';
import 'package:todo_app/features/home/presentation/views/widgets/body_home_screen.dart';
import 'package:todo_app/features/home/presentation/views/widgets/text_forms.dart';

class HomeScreens extends StatefulWidget {
  const HomeScreens({super.key});

  @override
  State<HomeScreens> createState() => _HomeScreensState();
}

class _HomeScreensState extends State<HomeScreens> {
  final ControllerTitle = TextEditingController();
  final ControllerData = TextEditingController();

  final ControllerTime = TextEditingController();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    createDatabasa();
  }

  final scaffoldKey = GlobalKey<ScaffoldState>();
  List<Widget> screens = [
    const BodyHomeScreen(),
    const BodyDone(),
    const BodyArchive()
  ];
  List<String> appbars = ['Task', 'Done', 'Archive'];
  int x = 0;
  bool isSheetOpen = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        backgroundColor: Color(0xff808000),
        centerTitle: true,
        title: Text(
          appbars[x],
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
      ),
      body: screens[x],
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(left: 5, right: 5),
        child: ClipRRect(
          borderRadius: BorderRadius.vertical(top: Radius.circular(15)),
          child: CurvedNavigationBar(
            color: Color(0xff808000),
            backgroundColor: Colors.white,
            items: <Widget>[
              Icon(
                Icons.task,
                size: 20,
                color: Colors.white,
              ),
              Icon(
                Icons.done,
                size: 20,
                color: Colors.white,
              ),
              Icon(
                Icons.archive,
                size: 20,
                color: Colors.white,
              ),
            ],
            index: x,
            onTap: (index) {
              setState(() {
                x = index;
              });
              //Handle button tap
            },
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            isSheetOpen = !isSheetOpen;
          });
          if (isSheetOpen == true) {
            // insertDatabasa();
            scaffoldKey.currentState!.showBottomSheet(
              (context) => Padding(
                padding: const EdgeInsets.symmetric(horizontal: 5),
                child: Container(
                    width: double.infinity,
                    height: 500,
                    decoration: BoxDecoration(
                        color: Color(0xff808000),
                        borderRadius:
                            BorderRadius.vertical(top: Radius.circular(20))),
                    child: Column(
                      children: [
                      TextForms(nameController: ControllerTitle, keyboardText: TextInputType.text, labelTexts: 'Title',hintTexts: 'Please add title',),
                        Container(
                          margin: EdgeInsets.only(left: 10, right: 10, top: 20),
                          child: TextFormField(
                            onTap: () {
                              showDatePicker(
                                      context: context,
                                      firstDate: DateTime.now(),
                                      lastDate: DateTime(2025),
                                      initialDate: DateTime.now())
                                  .then((onValue) {
                                DateFormat.yMd().format((onValue!));
                                setState(() {
                                  ControllerData.text = onValue.toString();
                                });
                              });
                            },
                            controller: ControllerData,
                            cursorColor: Colors.white,
                            keyboardType: TextInputType.none,
                            decoration: InputDecoration(
                              focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Colors.white, width: 2.0)),
                              enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Colors.white, width: 2.0)),
                              labelText: 'Please Click To Choose Day',
                              labelStyle: TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(left: 10, right: 10, top: 20),
                          child: TextFormField(
                            onTap: () {
                              showTimePicker(
                                      context: context,
                                      initialTime: TimeOfDay.now())
                                  .then((Value) {
                                DateFormat('hh:mm:a').format(DateTime(
                                  Value!.hour,
                                  Value!.minute,
                                ));
                                // DateFormat.Hms().format( (!onValue));
                                setState(() {
                                  ControllerTime.text = Value.toString();
                                });
                              });
                            },
                            controller: ControllerTime,
                            cursorColor: Colors.white,
                            keyboardType: TextInputType.none,
                            decoration: InputDecoration(
                              focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Colors.white, width: 2.0)),
                              enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Colors.white, width: 2.0)),
                              labelText: 'Please Click To Choose Time',
                              labelStyle: TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                      ],
                    )),
              ),
            );
          } else {
            Navigator.pop(context);
            ControllerTitle == null;
            ControllerData == null;
            ControllerTime == null;
          }
        },
        child: isSheetOpen
            ? Icon(
                Icons.edit,
                color: Colors.white,
              )
            : Icon(
                Icons.add,
                color: Colors.white,
              ),
      ),
    );
  }
}

Database? dataBasa;
void createDatabasa() async {
  dataBasa = await openDatabase('todo.db', version: 1, onCreate: (db, version) {
    print('databasa create');
    db.execute(
        'CREATE TABLE testtodo (id INTEGER PRIMARY KEY, title TEXT, data TEXT, time TEXT, status TEXT)');
  }, onOpen: (db) {
    print('databasa open');
  });
}

void insertDatabasa(String title, String data, String time) {
  dataBasa!.rawInsert(
      'INSERT INTO todo(title,data,time,status) VALUES($title, $data,$time, "Done")');
}




  // Container(
  //                         margin: EdgeInsets.only(left: 10, right: 10, top: 20),
  //                         child: TextFormField(
  //                           controller: ControllerTitle,
  //                           cursorColor: Colors.white,
  //                           keyboardType: TextInputType.text,
  //                           decoration: InputDecoration(
  //                               focusedBorder: OutlineInputBorder(
  //                                   borderSide: BorderSide(
  //                                       color: Colors.white, width: 2.0)),
  //                               enabledBorder: OutlineInputBorder(
  //                                   borderSide: BorderSide(
  //                                       color: Colors.white, width: 2.0)),
  //                               labelText: 'Title',
  //                               labelStyle: TextStyle(color: Colors.white),
  //                               hintText: 'Please add title',
  //                               hintStyle: TextStyle(color: Colors.white)),
  //                         ),
  //                       ),