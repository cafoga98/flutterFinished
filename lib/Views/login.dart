import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:my_first_project/Utils/firebaseController.dart' as firebaseController;


class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  bool LogButton = false;
  bool eyePass = false;

  TextEditingController _textEditingControllerEmail = new TextEditingController();
  TextEditingController _textEditingControllerPassword = new TextEditingController();

  final scaffoldKey = GlobalKey<ScaffoldState>();
  final snackBar = SnackBar(content: Text('Yay! A SnackBar!'));

  showSnackBar(String message) {
    setState(() {
      scaffoldKey.currentState.showSnackBar(SnackBar(
        content: Text(message),
      ));
    });
  }


  @override
  void initState() {
    initializeApp();
  }
  void initializeApp() async {
    await Firebase.initializeApp();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: scaffoldKey,
        body: SingleChildScrollView(
          child: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('assets/img/backbit.png'),
                    fit: BoxFit.cover,
                    colorFilter: ColorFilter.mode(Colors.white60, BlendMode.hardLight)
                )
            ),
            child: Column(
              children: [
                Container(
                  padding: EdgeInsets.only(
                      top: 40,
                      left: 25,
                      right: 25
                  ),
                  height: MediaQuery.of(context).size.height/1.4,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                            color: Colors.black45,
                            spreadRadius: 9,
                            blurRadius: 12
                        )
                      ],
                      borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(120),
                          bottomRight: Radius.circular(120)
                      )
                  ),
                  child: Container(
                    height: 100,
                    width: 100,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text('Welcome To',
                            style: GoogleFonts.signika(
                                fontSize: 20,
                                color: Color(0xFF636363),
                                fontWeight: FontWeight.normal
                            )),
                        Image.asset(
                          'assets/img/BitLogo.png',
                          alignment: Alignment.center,
                          width: 157,
                          height: 63,
                          fit: BoxFit.contain,
                        ),
                        Text('Please login to continue',
                          style: GoogleFonts.signika(
                              fontSize: 20,
                              color: Color(0xFF636363),
                              fontWeight: FontWeight.normal
                          ),
                        ),

                        Container(
                          height: MediaQuery.of(context).size.height/17,
                        ),

                        //Username Field
                        Center(
                          child: Container(
                            padding: EdgeInsets.only(
                                left: 15,
                                right: 15
                            ),
                            margin: EdgeInsets.all(10),
                            width: MediaQuery.of(context).size.width,
                            height: MediaQuery.of(context).size.height/15,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.all(Radius.circular(90)),
                              boxShadow: [
                                BoxShadow(
                                    color: Colors.black12,
                                    spreadRadius: 2,
                                    blurRadius: 5
                                )
                              ],
                            ),
                            child: TextField(
                              controller: _textEditingControllerEmail,
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: 'Username',
                                hintStyle: GoogleFonts.signika(
                                    fontSize: 18,
                                    color: Colors.black45,
                                    fontWeight: FontWeight.normal
                                ),
                                icon: Icon(Icons.person),
                              ),
                            ),
                          ),
                        ),

                        //Password Field
                        Center(
                          child: Container(
                            padding: EdgeInsets.only(
                                left: 15,
                                right: 15
                            ),
                            margin: EdgeInsets.all(10),
                            width: MediaQuery.of(context).size.width,
                            height: MediaQuery.of(context).size.height/15,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.all(Radius.circular(90)),
                              boxShadow: [
                                BoxShadow(
                                    color: Colors.black12,
                                    spreadRadius: 2,
                                    blurRadius: 5
                                )
                              ],
                            ),
                            child: TextField(
                              obscureText: eyePass == false ? true : false,
                              controller: _textEditingControllerPassword,
                              decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText: 'Password',
                                  hintStyle: GoogleFonts.signika(
                                      fontSize: 18,
                                      color: Colors.black45,
                                      fontWeight: FontWeight.normal
                                  ),
                                  icon: Icon(Icons.lock),
                                  suffixIcon: IconButton(
                                    icon: Icon( eyePass == false ? Icons.remove_red_eye : Icons.remove_red_eye_outlined),
                                    onPressed: (){
                                      setState(() {
                                        eyePass = !eyePass;
                                      });
                                    },
                                  )
                              ),
                            ),
                          ),
                        ),

                        Padding(
                            padding: EdgeInsets.all(15),
                            child: InkWell(
                                onTap: () => showSnackBar("Comunicarse con soporte +57 (300)574-0000"),
                                child: Align(
                                  alignment: Alignment.centerRight,
                                  child: Text('Forgot Password ?',
                                      textAlign: TextAlign.left,
                                      style: GoogleFonts.signika(
                                          fontSize: 18,
                                          color: Color(0xFF636363),
                                          fontWeight: FontWeight.normal
                                      )),
                                )
                            )
                        ),

                        //Login Button
                        Center(
                          child: InkWell(
                              onTap: () {
                                print('Presionando...');
                                setState(() {
                                  LogButton = !LogButton;

                                  if(_textEditingControllerEmail.text.isEmpty||_textEditingControllerPassword.text.isEmpty){
                                    firebaseController.showMaterialDialog(context: context, message: 'Please fill in the fields before continuing');
                                    LogButton = !LogButton;
                                  }else{
                                    LogButton = !LogButton;
                                    firebaseController.signIn(email: _textEditingControllerEmail.text, password: _textEditingControllerPassword.text, context: context);
                                    firebaseController.stateChanges(context);
                                  }
                                });
                              },
                              hoverColor: Colors.red,
                              focusColor: Colors.red,
                              child: Container(
                                padding: EdgeInsets.only(
                                    left: 15,
                                    right: 15
                                ),
                                margin: EdgeInsets.all(10),
                                width: MediaQuery.of(context).size.width,
                                height: MediaQuery.of(context).size.height/15,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.all(Radius.circular(90)),
                                  boxShadow: [
                                    BoxShadow(
                                        color: Colors.black26,
                                        spreadRadius: 1,
                                        blurRadius: 12
                                    )
                                  ],
                                ),
                                child: Center(
                                    child: LogButton != true ? Text("Login",
                                        style: GoogleFonts.signika(
                                            fontSize: 18,
                                            color: Colors.black45,
                                            fontWeight: FontWeight.bold
                                        )) : CircularProgressIndicator()),
                              )
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                Container(
                    margin: EdgeInsets.only(top: MediaQuery.of(context).size.height/50),
                    child: Text("Or",
                      style: GoogleFonts.signika(
                          fontSize: 25,
                          color: Color(0xFF000000),
                          fontWeight: FontWeight.bold
                      ),)),

                //Text SIGN UP
                Center(
                  child: InkWell(
                      onTap: () {
                        Navigator.pushNamed(context, '/register');
                      },
                      hoverColor: Colors.red,
                      focusColor: Colors.red,
                      child: Container(
                        padding: EdgeInsets.only(
                            left: 15,
                            right: 15
                        ),
                        margin: EdgeInsets.only(
                            left: 10,
                            right: 10,
                            top: MediaQuery.of(context).size.height/30
                        ),
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height/15,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.all(Radius.circular(90)),
                          boxShadow: [
                            BoxShadow(
                                color: Colors.black26,
                                spreadRadius: 1,
                                blurRadius: 12
                            )
                          ],
                        ),
                        child: Center(
                            child: Text("Sign Up",
                                style: GoogleFonts.signika(
                                    fontSize: 18,
                                    color: Colors.black45,
                                    fontWeight: FontWeight.bold
                                )) ),
                      )
                  ),
                ),
              ],
            ),
          ),
        )
    );
  }
}
