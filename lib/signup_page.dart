import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';


class SignupPage extends StatefulWidget {
  @override
  _SignupPageState createState() => _SignupPageState();
}


class _SignupPageState extends State<SignupPage> {
  var emailController = TextEditingController();
  var passwordController = TextEditingController();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
        ),
        body: Column(
            children: [
              Expanded(
                flex:20,
                child: Image(
                  image: NetworkImage('https://www.rastanley.com.au/img/products/new/S/67276_S.jpg'),
                  fit: BoxFit.cover,
                ),
              ),
              Expanded(
                flex:30,
                child: Column(
                  children: [
                    Container(
                      margin: EdgeInsets.only(top:10,bottom:5),
                      child: Text('Sign up',
                        style: TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.bold
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(left:35,right:35,bottom:7,top:7),
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
                      margin: EdgeInsets.only(left:35,right:35,bottom:7,top:7),
                      child: TextField(
                        controller: passwordController,
                        obscureText: true,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Password',
                        ),
                      ),
                    ),
                    SizedBox(width:5),
                    ElevatedButton(
                      child: Text("Signup",
                          style: TextStyle(
                            fontSize:15,
                          )),
                      onPressed: () {
                        Future<UserCredential> result = FirebaseAuth.instance.createUserWithEmailAndPassword(email: emailController.text,password:passwordController.text);
                        result.then((value) {
                          print("successfully signed up");
                          Navigator.pop(context);
                        }).catchError((error) {
                          print("Failed to sign up");
                          print(error.toString());
                        });
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
