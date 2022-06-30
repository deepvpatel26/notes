import 'package:flutter/material.dart';
import 'edittextwidget.dart';
import 'firebaseconnection.dart';
import 'main.dart';

// ignore: must_be_immutable
class AddData extends StatefulWidget {
  AddData({Key? key, required this.index}) : super(key: key);

  String? index;

  @override
  // ignore: library_private_types_in_public_api
  _AddDataState createState() => _AddDataState();
}

class _AddDataState extends State<AddData> {
  final _formKey = GlobalKey<FormState>();
  final _notesController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.only(left: 30),
                alignment: Alignment.centerLeft,
                child: IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: const Icon(Icons.arrow_back)),
              ),
              const Text(
                "Add",
                style: TextStyle(
                  fontSize: 50,
                  fontWeight: FontWeight.w300,
                ),
              ),
              Container(
                padding: const EdgeInsets.fromLTRB(30, 30, 30, 30),
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: <Widget>[
                      EditText(
                        edttxtlable: "Write something",
                        errorString: "*Write something",
                        txtedtcntroller: _notesController,
                      ),
                      InkWell(
                        onTap: () {
                          if (_formKey.currentState!.validate()) {
                            addData();
                          }
                        },
                        child: Container(
                          height: 45,
                          width: MediaQuery.of(context).size.width / 3,
                          decoration: BoxDecoration(
                              color: Colors.amber[200],
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(40))),
                          child: const Center(
                            child: Text(
                              'Add Note',
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 20,
                                  fontWeight: FontWeight.w300),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void addData() {
    FirebaseConnection()
        .saveToFirebase(_notesController.text, "${widget.index}")
        .whenComplete(() {
      ScaffoldMessenger.of(context).clearSnackBars();
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text("Data Submited")));
      Navigator.push(
        context,
        MaterialPageRoute(builder: (builder) => const HomePage()),
      );
    });
  }
}
