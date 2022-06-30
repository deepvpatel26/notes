import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'adddata.dart';
import 'editdata.dart';
import 'firebaseconnection.dart';
import 'login_page.dart';
import 'firebase_options.dart';
import 'package:google_sign_in/google_sign_in.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    name: 'notes_fsm',
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const LoginPage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List datalist = [];

  @override
  void initState() {
    super.initState();
    fetchdataList();
  }

  fetchdataList() async {
    dynamic result = await FirebaseConnection().getData();

    if (result == null) {
      debugPrint("Unable to fetch data");
    } else {
      setState(() {
        datalist = result;
      });
      debugPrint("---------->>>>>>>>>>>>>>$datalist");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      backgroundColor: Colors.grey,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Image.asset('asset/logo.png' ,
                  width: 100,
                  height: 50),
              Container(
                padding: const EdgeInsets.all(35),
                child: const Text(
                  "Notes",
                  style: TextStyle(
                    fontSize: 40,
                    fontWeight: FontWeight.w300,
                  ),
                ),
              ),
              Container(
                height: MediaQuery.of(context).size.height,
                child: ListView.builder(
                    padding: const EdgeInsets.all(20),
                    itemCount: datalist.length,
                    itemBuilder: (context, index) {
                      return Card(
                        margin: const EdgeInsets.all(15),
                        elevation: 5,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: ListTile(
                          contentPadding: const EdgeInsets.all(20),
                          leading: const CircleAvatar(
                            backgroundColor: Colors.black,
                            backgroundImage: AssetImage("asset/icon.png"),
                          ),
                          trailing: Column(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              SizedBox(
                                height: 35,
                                child: IconButton(
                                  onPressed: () {
                                    FirebaseConnection()
                                        .deleteData(datalist[index]['index'])
                                        .whenComplete(() {
                                      fetchdataList();
                                      ScaffoldMessenger.of(context)
                                          .clearSnackBars();
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(const SnackBar(
                                              content: Text("Data Deleted")));
                                    });
                                  },
                                  icon: const Icon(Icons.delete),
                                  iconSize: 30,
                                ),
                              ),
                              SizedBox(
                                height: 35,
                                child: IconButton(
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (builder) => EditData(
                                                index: "$index",
                                                notes: datalist[index]['notes'],
                                              )),
                                    );
                                  },
                                  icon: const Icon(Icons.edit),
                                  iconSize: 30,
                                ),
                              )
                            ],
                          ),
                          title: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                datalist[index]['notes'],
                                style: const TextStyle(
                                    fontSize: 35,
                                    color: Colors.black,
                                    fontWeight: FontWeight.w300),
                              ),
                            ],
                          ),
                        ),
                      );
                    }),
              )
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.amber[200],
        onPressed: () {
          ScaffoldMessenger.of(context).clearSnackBars();
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (builder) => AddData(
                      index: datalist.length.toString(),
                    )),
          );
        },
        child: const Text(
          "+",
          style: TextStyle(color: Colors.black, fontSize: 25),
        ),
      ),
    );
  }
}
