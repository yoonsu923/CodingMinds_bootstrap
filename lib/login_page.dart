import 'package:flutter/material.dart';
import 'package:untitled1111/todolist_page.dart';
import 'todolist_page.dart';
import 'signup_page.dart';
import 'forgetpassword_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';


class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}


class _LoginPageState extends State<LoginPage> {

  var emailController = TextEditingController();
  var passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
            children: [
              Expanded(
                flex:20,
                child: Image(
                  image: NetworkImage('https://wallpapers.com/images/featured/pinterest-background-urm1zdm2gj236gbq.jpg'),
                  fit: BoxFit.cover,
                ),
              ),
              Expanded(
                flex:30,
                child: Column(
                  children: [
                    Container(
                      margin: EdgeInsets.only(top:5,bottom:3),
                      child: Text('this is the Login Page',
                        style: TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.bold
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(left:35,right:35,bottom:6,top:6),
                      child: TextField(
                        controller: emailController,
                        obscureText: false,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Email',
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(left:35,right:35,bottom:6,top:6),
                      child: TextField(
                        controller: passwordController,
                        obscureText: true,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Password',
                        ),
                      ),
                    ),
                    // Container(
                    //   margin: EdgeInsets.only(top:10,bottom:20),
                    //   child: Text(
                    //       'Forget Password?',
                    //       style: TextStyle(
                    //           color: Colors.black
                    //       )
                    //   ),
                    // ),
                    SizedBox(height:7),

                    InkWell(
                      child: Text("Forget Password?"),
                      onTap: () {
                        Navigator.push(context,
                        MaterialPageRoute(builder: (context) => ForgetPasswordPage()),
                      );},
                    ),

                    SizedBox(height:7),


                    ElevatedButton(
                      child: Text("Login",
                          style: TextStyle(
                            fontSize: 15,
                          )),
                      onPressed: () {
                        Future<UserCredential> result = FirebaseAuth.instance.signInWithEmailAndPassword(email: emailController.text, password: passwordController.text);
                        result.then((value) {
                          print("successfully login");
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => TodolistPage()),
                          );
                        }).catchError((error) {
                          print("Failed to login up");
                          print(error.toString());
                        });
                      },
                    ),

                    SizedBox(width:5),

                    ElevatedButton(
                      child: Text("Create account?",
                          style: TextStyle(
                            fontSize:15,
                          )),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => SignupPage()),
                        );
                      },
                    )
                  ],
                ),
              ),
            ]
        )
    );
  }
}
