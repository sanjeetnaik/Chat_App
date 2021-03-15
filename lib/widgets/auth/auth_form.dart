import 'package:chat_application_1441/pickers/user_image_picker.dart';
import 'package:flutter/material.dart';
import 'dart:io';

class AuthForm extends StatefulWidget {
  AuthForm(this.submitFn, this.isloading);

  final bool isloading;
  final void Function(
    String email,
    String password,
    String username,
    bool isLogin,
    BuildContext ctx,
  ) submitFn;

  @override
  _AuthFormState createState() => _AuthFormState();
}

class _AuthFormState extends State<AuthForm> {
  final _formkey = GlobalKey<FormState>();
  var _isLogin = true;
  var _useremail;
  var _username;
  var _userpassword;

  void _trysubmit() {
    final isValid = _formkey.currentState.validate();
    print(_userpassword);
    print(_useremail);
    print(_username);

    FocusScope.of(context).unfocus();

    if (isValid) {
      if (_isLogin == true) {
        _formkey.currentState.save();
        widget.submitFn(
          _useremail.trim(),
          _userpassword.trim(),
          _username,
          _isLogin,
          context,
        );
      } else {
        _formkey.currentState.save();
        widget.submitFn(
          _useremail.trim(),
          _userpassword.trim(),
          _username.trim(),
          _isLogin,
          context,
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Card(
        margin: EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(16),
            child: Form(
              key: _formkey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextFormField(
                    validator: (value) {
                      if (value.isEmpty || !value.contains('@')) {
                        return ('Please enter a valid email address');
                      }
                      return null;
                    },
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      labelText: 'Email Address',
                    ),
                    onSaved: (value) {
                      _useremail = value;
                    },
                  ),
                  if (!_isLogin)
                    TextFormField(
                      validator: (value) {
                        if (value.isEmpty) {
                          return ('Please enter a valid username');
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        labelText: 'Username',
                      ),
                      onSaved: (value) {
                        _username = value;
                      },
                    ),
                  // if (!_isLogin)
                  //   // TextFormField(
                  //   //   validator: (value) {
                  //   //     if (value.isEmpty) {
                  //   //       return ('Please enter a valid username');
                  //   //     }
                  //   //     return null;
                  //   //   },
                  //   //   decoration: InputDecoration(
                  //   //     labelText: 'Username',
                  //   //   ),
                  //   //   onSaved: (value) {
                  //   //     _username = value;
                  //   //   },
                  //   // ),
                  //   DropdownButton(items: null, onChanged: null,hint: Text(''),),
                  TextFormField(
                    validator: (value) {
                      if (value.isEmpty || value.length < 7) {
                        return ('Please enter a valid password');
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      labelText: 'Password',
                    ),
                    obscureText: true,
                    onSaved: (value) {
                      _userpassword = value;
                    },
                  ),
                  SizedBox(
                    height: 12,
                  ),
                  if (widget.isloading == true) CircularProgressIndicator(),
                  if (!widget.isloading)
                    RaisedButton(
                      onPressed: _trysubmit,
                      child: Text(_isLogin ? 'Log In' : 'Sign Up'),
                    ),
                  if (!widget.isloading)
                    FlatButton(
                        textColor: Theme.of(context).primaryColor,
                        onPressed: () {
                          setState(() {
                            _isLogin = !_isLogin;
                          });
                        },
                        child: Text(_isLogin
                            ? 'Create new account'
                            : 'I already have an account!')),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
