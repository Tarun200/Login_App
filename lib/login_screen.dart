import 'package:flutter/material.dart';
import 'signup_screen.dart';
import 'auth.dart';
import 'package:provider/provider.dart';
import 'home_screen.dart';
class LoginScreen extends StatefulWidget {
  static const routeName = '/login';
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey();
  Map<String, String> _authData = {
    'email' : '',
    'passsword' : ''
  };
  void _showErrorMessage(String msg)
  {
    showDialog(
        context: context,
        builder: (ctx) =>AlertDialog(
          title: Text("Error!!"),
          content: Text(msg),
          actions: [
            RaisedButton(
                onPressed: (){
                  Navigator.of(ctx).pop();
                },
              child: Text("Okiee"),
            ),
          ],
        ),
    );
  }
 Future<void> _submit() async
  {
    if(!_formKey.currentState.validate())
      {
        return;
      }
    _formKey.currentState.save();
    try{
      await Provider.of<Authentication>(context,listen: false).logIn(
          _authData['email'],
          _authData['password']
      );
      Navigator.of(context).pushReplacementNamed(HomeScreen.routeName);

    }
    catch(error)
    {
      var errorMessage = 'Sorry Authentication Failed!!';
      _showErrorMessage(errorMessage);
    }


  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Login Screen"),
        actions: [
          FlatButton(
              onPressed: (){
                Navigator.of(context).pushReplacementNamed(SignupScreen.routeName);
              },
              child: Row(
                children: [
                  Text(
                    "SignUp",
                  ),

                  Icon(Icons.person_add),
                ],
              ),
            textColor: Colors.white,
          ),
        ],
      ),
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Colors.amberAccent,
                  Colors.teal,
                ],
              ),

            ),
          ),
          Center(
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.0),
              ),
              child: Container(
                height: 260,
                width: 300,
                padding: EdgeInsets.all(15),
                child: Form(
                  key: _formKey,
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        TextFormField(
                          decoration: InputDecoration(
                            labelText: "Email",
                            hintText: "Enter your E-mailID",
                          ),
                          keyboardType: TextInputType.emailAddress,
                          validator: (value) {
                            if (value.isEmpty || !value.contains('@')) {
                              return "Invalid E-mail";
                            }
                            return null;
                          },
                          onSaved: (value)
                            {
                              _authData['email'] = value;

                            },
                        ),
                        TextFormField(
                          decoration: InputDecoration(
                            labelText: "Password",
                            hintText: "Enter your password",

                          ),
                          obscureText: true,
                          validator: (value)
                          {
                            if(value.isEmpty || value.length<=5)
                              {
                                return "Invalid password";
                              }
                            return null;
                            },
                          onSaved: (value)
                          {
                            _authData['password'] = value;

                          },
                        ),
                        SizedBox(
                          height: 35,
                        ),
                        RaisedButton(
                            onPressed: (){
                              _submit();

                            },
                            child: Text(
                            "Submit",
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(32),
                          ),
                        ),
                      ],

                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
