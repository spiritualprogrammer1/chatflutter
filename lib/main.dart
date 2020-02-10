import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _MyAppState();
  }
}

class _MyAppState extends State<MyApp> {
  bool _isLoggedIn = false;

  GoogleSignIn _googleSignIn = GoogleSignIn(scopes: ['email',
    'https://www.googleapis.com/auth/contacts.readonly',]);

  _login() async{
    try{
      await _googleSignIn.signIn();
      print('photo :');
      print(_googleSignIn.currentUser.photoUrl);
      setState(() {
        _isLoggedIn = true;

      });
    } catch (err){
      print(err);
    }
  }

  _logout(){
    _googleSignIn.signOut();
    setState(() {
      _isLoggedIn = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(
      home: Scaffold(
        body: Center(
            child: _isLoggedIn
                ? Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                _googleSignIn.currentUser.photoUrl != null ? Image.network(_googleSignIn.currentUser.photoUrl, height: 50.0, width: 50.0,) : Image.asset('assets/image/login.png',height: 80,width: 130,),
                Text(_googleSignIn.currentUser.displayName),
                Text(_googleSignIn.currentUser.id),
                Text(_googleSignIn.currentUser.email),

                OutlineButton( child: Text("Logout"), onPressed: (){
                  _logout();
                },)
              ],
            )
                : Center(
              child: OutlineButton(
                child: Text("Login with Google"),
                onPressed: () {
                  _login();
                },
              ),
            )),
      ),
    );
  }
}