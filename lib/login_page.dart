
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'auth_service.dart';


class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);
  @override
  LoginPageState createState() => LoginPageState();
}

class LoginPageState extends State<LoginPage> {
  final _loginformKey = GlobalKey<FormState>();
  String loginemail = "";
  String loginpassword = "";
  bool showHide = true;

  final _lemailController = TextEditingController();
  final _lpasswordController = TextEditingController();
  bool gbtnprogress = false;


  togglepsd() {
    setState(() {
      showHide = !showHide;
    });
  }

  FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  AuthClass authclass = AuthClass();

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        //
        return false;
      },
      child: Scaffold(
        body: SafeArea(
          child: Center(
            child: ListView(
              shrinkWrap: true,
              children: <Widget>[
                Image.asset('asset/logo.png',
                  height: 150,
                  width: 150,),
                Container(
                  width: MediaQuery.of(context).size.width * 0.5,
                  child: Container(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: const [
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Padding(
                            padding: EdgeInsets.only(left: 30),
                            child:
                            Icon(
                              Icons.person_outline,
                              size: 90,
                              color: Color(0xFF00abff),
                              // Colors.black87.withOpacity(0.4),
                            ),
                          ),
                        ),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Padding(
                            padding: EdgeInsets.only(left: 0, top: 30),
                            child: Text(
                              "Sign in",
                              style: TextStyle(
                                  color: Color(0xFF00abff),
                                  //Colors.black87.withOpacity(0.4),
                                  fontSize: 30,
                                  fontWeight: FontWeight.w300),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: Container(
                    // height: MediaQuery.of(context).size.height / 2,
                    //width: MediaQuery.of(context).size.width,
                    padding: const EdgeInsets.fromLTRB(30, 30, 30, 30),
                    decoration: BoxDecoration(
                        color: Colors.grey[200],
                        borderRadius: const BorderRadius.all(Radius.circular(50)),
                        boxShadow: [
                          BoxShadow(
                            //color: Colors.black.withOpacity(0.15),
                            color: Colors.black87.withOpacity(0.3),
                            blurRadius: 14,
                            offset: const Offset(5, 5),
                          ),
                        ]),
                    child: Form(
                      key: _loginformKey,
                      child: Column(
                        children: <Widget>[


                          InkWell(
                            onTap: () async {
                                setState(() {
                                  gbtnprogress = true;
                                });
                                await authclass
                                    .googleSignin(context)
                                    .whenComplete(() {
                                  setState(() {
                                    gbtnprogress = false;
                                  });
                                }).onError((error, stackTrace) {
                                  setState(() {
                                    gbtnprogress = true;
                                  });
                                });

                            },
                            child: Container(
                              height: 45,
                              width: 215,
                              decoration: BoxDecoration(
                                borderRadius:
                                const BorderRadius.all(const Radius.circular(50)),
                                border: Border.all(
                                    color: Colors.black87.withOpacity(0.1)),
                              ),
                              padding: const EdgeInsets.only(right: 7),
                              child: gbtnprogress
                                  ? const Center(
                                  child:  CircularProgressIndicator(
                                    color: Colors.black87,
                                  ))
                                  : Row(
                                mainAxisAlignment:
                                MainAxisAlignment.center,
                                children: [
                                                                    Image.asset(
                                    'asset/google.png',
                                    height: 30,
                                    width: 30,
                                  ),
                                  const Padding(
                                    padding:
                                    EdgeInsets.only(left: 5),
                                    child: Text(
                                      'Continue with google',
                                      style: TextStyle(
                                          color: Colors.black87,
                                          fontSize: 15,
                                          fontWeight: FontWeight.w300),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),

                          const SizedBox(
                            height: 10,
                          ),

                        ],
                      ),
                    ),
                  ),
                ),

                const SizedBox(
                  height: 15,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}