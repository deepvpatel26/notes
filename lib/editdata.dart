import 'package:flutter/material.dart';
import 'edittextwidget.dart';
import 'firebaseconnection.dart';
import 'main.dart';

class EditData extends StatefulWidget {
  EditData({Key? key, required this.notes, required this.index})
      : super(key: key);
  String? notes;

  String? index;
  @override
  _EditDataState createState() => _EditDataState();
}

class _EditDataState extends State<EditData> {
  final _formKey = GlobalKey<FormState>();
  final _notesController = TextEditingController();

  initialvalue() {
    _notesController.text = "${widget.notes}";
  }

  @override
  void initState() {
    super.initState();
    initialvalue();
  }

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
                  padding: EdgeInsets.only(left: 30),
                  alignment: Alignment.centerLeft,
                  child: IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: Icon(Icons.arrow_back))),
              const Text(
                "Edit",
                style: TextStyle(
                  fontSize: 50,
                  fontWeight: FontWeight.w300,
                ),
              ),
              Container(
                padding: EdgeInsets.fromLTRB(30, 30, 30, 30),
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
                        onTap: () async {
                          if (_formKey.currentState!.validate()) {
                            editData();
                          }
                        },
                        child: Container(
                          height: 45,
                          width: MediaQuery.of(context).size.width / 3,
                          decoration: BoxDecoration(
                              color: Colors.amber[200],
                              borderRadius:
                                  BorderRadius.all(Radius.circular(40))),
                          child: const Center(
                            child: Text(
                              'Update',
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

  void editData() {
    FirebaseConnection()
        .updateData(_notesController.text, "${widget.index}")
        .whenComplete(() {
      ScaffoldMessenger.of(context).clearSnackBars();
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text("Data Updated")));
      Navigator.push(
        context,
        MaterialPageRoute(builder: (builder) => HomePage()),
      );
    });
  }
}
