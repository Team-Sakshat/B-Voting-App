import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:project1/pages/home.dart';
import 'package:project1/pages/register_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController aadhar = TextEditingController();
  TextEditingController pass = TextEditingController();
  static final _formKey = GlobalKey<FormState>();

  bool _passwordVisible = false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _passwordVisible = false;
  }

  InputBorder InputFormfieldBorder = OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(15)),
    borderSide: BorderSide(color: Colors.white, width: 1.0),
  );
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Color(0xffF5F9FF),
      body: Padding(
        padding: EdgeInsets.fromLTRB(30, 0, 30, 0),
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 20,
                ),
                Center(
                  child: Image.asset(
                    "assets/logo.png",
                    height: 200,
                    width: 200,
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  'Getting Started.!',
                  style: TextStyle(
                      fontFamily: "Jost",
                      color: Color(0xff202244),
                      fontSize: 20,
                      fontWeight: FontWeight.w700),
                ),
                SizedBox(
                  height: 30,
                ),
                Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(15)),
                  child: TextFormField(
                    style: TextStyle(color: Color(0xff505050)),
                    controller: aadhar,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Please enter the aadhar";
                      } else if (aadhar.text.length != 12) {
                        return "Please enter 12 digit aadhar";
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.mail_outline),
                      prefixIconColor: Color(0xff545454),
                      // filled: true,
                      // fillColor: Color(0xffffffff),
                      enabledBorder: InputFormfieldBorder,
                      focusedBorder: InputFormfieldBorder,
                      errorBorder: InputFormfieldBorder,
                      focusedErrorBorder: InputFormfieldBorder,
                      border: InputFormfieldBorder,
                      hintText: "Aadhar Number",
                      hintStyle: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 15,
                          fontWeight: FontWeight.w400,
                          color: Color(0xff505050)),
                      contentPadding:
                          EdgeInsets.symmetric(horizontal: 0, vertical: 18),
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(15)),
                  child: TextFormField(
                    obscureText: !_passwordVisible,
                    style: TextStyle(color: Color(0xff505050)),
                    controller: pass,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Please enter the password";
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.mail_outline),
                      prefixIconColor: Color(0xff545454),
                      // filled: true,
                      // fillColor: Color(0xffffffff),
                      enabledBorder: InputFormfieldBorder,
                      focusedBorder: InputFormfieldBorder,
                      errorBorder: InputFormfieldBorder,
                      focusedErrorBorder: InputFormfieldBorder,
                      border: InputFormfieldBorder,
                      hintText: "Password",

                      hintStyle: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 15,
                        fontWeight: FontWeight.w400,
                        color: Color(0xff505050),
                      ),

                      suffixIcon: IconButton(
                        icon: Icon(
                          // Based on passwordVisible state choose the icon
                          _passwordVisible
                              ? Icons.visibility
                              : Icons.visibility_off,
                          color: Theme.of(context).primaryColorDark,
                        ),
                        onPressed: () {
                          // Update the state i.e. toogle the state of passwordVisible variable
                          setState(() {
                            _passwordVisible = !_passwordVisible;
                          });
                        },
                      ),

                      contentPadding:
                          EdgeInsets.symmetric(horizontal: 0, vertical: 18),
                    ),
                  ),
                ),
                SizedBox(
                  height: 60,
                ),
                Container(
                  width: width * 0.8,
                  height: height * 0.07,
                  child: ElevatedButton(
                      style: ButtonStyle(
                          backgroundColor:
                              MaterialStatePropertyAll(Color(0xff6979F8))),
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          print(aadhar.text);
                          print(pass.text);
                          String res = await login(
                              aadhar.text.toString(), pass.text.toString());
                          if (res == "Success") {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Home()));
                          } else {
                            print("Failex");
                          }
                        }
                      },
                      child: Row(
                        children: [
                          SizedBox(
                            width: width * 0.2,
                          ),
                          Text(
                            'Sign In',
                            style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w600,
                                color: Colors.white),
                          ),
                          SizedBox(
                            width: width * 0.155,
                          ),
                          CircleAvatar(
                              backgroundColor: Colors.white,
                              child: Icon(Icons.arrow_forward)),
                        ],
                      )),
                ),
                Row(
                  children: [
                    Text(
                      "Didn't have an account ? ",
                      style: TextStyle(
                        fontSize: 15,
                      ),
                    ),
                    SizedBox(
                      width: 15,
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                maintainState: true,
                                builder: (context) => RegisterScreen()));
                      },
                      child: Text(
                        "Register",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 15),
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  login(String AadharNumber, String password) async {
    try {
      Response response = await http.post(
          Uri.parse("https://votingapp-qa3x.onrender.com/user/login"),
          headers: {
            'Content-Type': "application/json",
          },
          body: jsonEncode({
            "AadharNumber": AadharNumber,
            "password": password,
          }));
      if (response.statusCode == 200) {
        var jsonData = jsonDecode(response.body.toString());
        print(jsonData);
        print(response.statusCode);
        print(jsonData['token']);
        print("Successfull");
        return "Success";
      } else {
        print("nahi hua");
        return "Failed";
      }
    } catch (e) {
      print(e.toString());
    }
  }
}
