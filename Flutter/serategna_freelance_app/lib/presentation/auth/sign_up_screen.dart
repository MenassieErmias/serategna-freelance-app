import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:serategna_freelance_app/presentation/auth/login_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:serategna_freelance_app/data_layer/models/user_model.dart';
import 'package:serategna_freelance_app/bloc/user_bloc/bloc.dart';
import '../commons/dialog.dart';

class SignUpPage extends StatefulWidget {
  static const String routeName = "/register";
  final Function toggleView;
  SignUpPage({this.toggleView});

  @override
  _SignUpPage createState() => _SignUpPage();
}

class _SignUpPage extends State<SignUpPage> {
  bool loading = false;
  bool _showPassword = false;
  String email = "";
  String password = "";
  String _error = '';
  bool _isLoading = false;
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _formKey = new GlobalKey<FormState>();

  bool _isCompany = false;
  AccountType selectedAccount;
  List<AccountType> accountTypes = [
    const AccountType(accountIcon: Icon(Icons.home), accountName: 'Employer'),
    const AccountType(
        accountIcon: Icon(Icons.person), accountName: 'Freelancer'),
  ];

  String _currentFullName;
  String _currentPhoneNumber;
  String _currentRole;

  @override
  Widget build(BuildContext context) {
    bool isKeyboardShowing = MediaQuery.of(context).viewInsets.vertical > 0;

    void _showError(String error) {
      Scaffold.of(context).showSnackBar(SnackBar(
        content: Text(error),
        backgroundColor: Theme.of(context).errorColor,
      ));
    }

    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: BlocListener<UserBloc, UserState>(
        listener: (context, state) {
          if (state is UserRegisterSucessState)
            Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => LoginPage()),
                (route) => false);
          if (state is UserFailureState) {
            ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(content: Text('${state.message}')));
          }
        },
        child: SingleChildScrollView(
          child: Container(
            height: MediaQuery.of(context).size.height + 400,
            decoration: BoxDecoration(),
            child: Column(children: [
              logo(isKeyboardShowing),
              Align(
                  alignment: isKeyboardShowing
                      ? Alignment.center
                      : Alignment.bottomCenter,
                  child: Form(
                    key: _formKey,
                    child: Container(
                      padding: EdgeInsets.symmetric(
                          horizontal: MediaQuery.of(context).size.height * 0.02,
                          vertical: MediaQuery.of(context).size.height * 0.05),
                      height: MediaQuery.of(context).size.height + 200,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          _buildEmailTextField(),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.015,
                          ),
                          _buildPasswordTextField(),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.015,
                          ),
                          _buildNameTextField(),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.015,
                          ),
                          _buildPhoneTextField(),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.015,
                          ),
                          _buildChooseAccountType(),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.015,
                          ),
                          _submitButton(context),
                          _createAccountLabel(),
                        ],
                      ),
                    ),
                  )),
            ]),
          ),
        ),
      ),
    );
  }

  Widget logo(isKeyboardShowing) {
    return ClipPath(
      child: Container(
          decoration: BoxDecoration(
              color: Color(0xFF1f40b7),
              gradient: LinearGradient(
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                  colors: [Colors.green[400], Colors.green])),
          width: double.infinity,
          height: isKeyboardShowing
              ? MediaQuery.of(context).size.height * 0.04
              : MediaQuery.of(context).size.height * 0.17,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: isKeyboardShowing
                    ? MediaQuery.of(context).size.height * 0.0
                    : MediaQuery.of(context).size.height * 0.04,
              ),
              SizedBox(
                height: isKeyboardShowing
                    ? MediaQuery.of(context).size.height * 0.0
                    : MediaQuery.of(context).size.height * 0.06,
                width: MediaQuery.of(context).size.width * 0.7,
                // child: Image.asset(
                //   "assets/images/logo2.png",
                // ),
              ),
              Text(
                'Register',
                style: TextStyle(
                    fontSize: isKeyboardShowing ? 0 : 30.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
            ],
          )),
    );
  }

  Widget _createAccountLabel() {
    return InkWell(
      onTap: () {
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (_) => LoginPage()));
      },
      child: Container(
        margin: EdgeInsets.symmetric(
            vertical: MediaQuery.of(context).size.height * 0.02),
        padding: EdgeInsets.all(MediaQuery.of(context).size.height * 0.005),
        alignment: Alignment.bottomCenter,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Already have an account ?',
              style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600),
            ),
            SizedBox(
              width: 10,
            ),
            Text(
              'Login',
              style: TextStyle(
                  color: Color(0xff4064f3),
                  fontSize: 13,
                  fontWeight: FontWeight.w600),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEmailTextField() {
    return TextFormField(
      key: ValueKey('email'),
      controller: _emailController,
      onChanged: (value) {
        setState(() => email = value);
      },
      validator: (value) =>
          !isEmail(value) ? "Please fill in a valid email address" : null,
      keyboardType: TextInputType.emailAddress,
      decoration: InputDecoration(
        labelText: 'Email',
        floatingLabelBehavior: FloatingLabelBehavior.auto,
        // alignLabelWithHint: true,
        prefixIcon: Icon(
          Icons.alternate_email,
          color: Theme.of(context).iconTheme.color,
        ),
        // hintText: 'Enter your email',
        border: InputBorder.none,
        filled: true,
        fillColor: Color(0xfff3f3f4),
      ),
    );
  }

  Widget _buildPasswordTextField() {
    return TextFormField(
      key: ValueKey('password'),
      controller: _passwordController,
      validator: (value) => value.length <= 6
          ? "Password must be 6 or more characters in length"
          : null,
      obscureText: !this._showPassword,
      onChanged: (value) {
        setState(() => password = value);
      },
      keyboardType: TextInputType.text,
      decoration: InputDecoration(
        labelText: 'Password',
        focusColor: Color(0xff4064f3),
        border: InputBorder.none,
        filled: true,
        fillColor: Color(0xfff3f3f4),
        prefixIcon: Icon(
          Icons.security,
          color: Theme.of(context).iconTheme.color,
        ),
        suffixIcon: IconButton(
          icon: this._showPassword
              ? FaIcon(FontAwesomeIcons.eye)
              : FaIcon(FontAwesomeIcons.eyeSlash),
          color: Theme.of(context).iconTheme.color,
          onPressed: () {
            setState(() => this._showPassword = !this._showPassword);
          },
        ),
      ),
    );
  }

  Widget _buildNameTextField() {
    return TextFormField(
      key: ValueKey('Full Name'),
      validator: (val) => val.isEmpty ? 'Please Enter Full Name' : null,
      onChanged: (val) => setState(() => _currentFullName = val),
      keyboardType: TextInputType.text,
      decoration: InputDecoration(
        labelText: 'Full Name',
        focusColor: Color(0xff4064f3),
        border: InputBorder.none,
        filled: true,
        fillColor: Color(0xfff3f3f4),
        prefixIcon: Icon(
          Icons.person,
          color: Theme.of(context).iconTheme.color,
        ),
      ),
    );
  }

  Widget _buildPhoneTextField() {
    return TextFormField(
      key: ValueKey('Phone Number'),
      validator: (val) => val.isEmpty ? 'Please Enter Phone Number' : null,
      onChanged: (val) => setState(() => _currentPhoneNumber = val),
      keyboardType: TextInputType.number,
      decoration: InputDecoration(
        labelText: 'Phone Number',
        focusColor: Color(0xff4064f3),
        border: InputBorder.none,
        filled: true,
        fillColor: Color(0xfff3f3f4),
        prefixIcon: Icon(
          Icons.phone,
          color: Theme.of(context).iconTheme.color,
        ),
      ),
    );
  }

  Widget _buildChooseAccountType() {
    return DropdownButton<AccountType>(
      hint: Text('Select Account Type'),
      value: selectedAccount,
      onChanged: (AccountType value) {
        if (value.accountName == 'Employer') {
          _isCompany = true;
          _currentRole = 'Employer';
        } else if (value.accountName == 'Freelancer') {
          _isCompany = true;
          _currentRole = 'Freelancer';
        }
        setState(() {
          selectedAccount = value;
        });
      },
      items: accountTypes.map((AccountType accountType) {
        return DropdownMenuItem(
          value: accountType,
          child: Row(
            children: <Widget>[
              accountType.accountIcon,
              SizedBox(
                width: 20.0,
              ),
              Text(accountType.accountName)
            ],
          ),
        );
      }).toList(),
    );
  }

  Widget _submitButton(ctx) {
    return InkWell(
      key: ValueKey('button'),
      onTap: () {
        final form = _formKey.currentState;
        if (form.validate()) {
          print('validated');
          form.save();
          BlocProvider.of<UserBloc>(ctx).add(RegisterButtonPressed(
              user: UserModel(
                  fullName: _currentFullName,
                  phoneNumber: _currentPhoneNumber,
                  password: password,
                  email: email,
                  role: _currentRole)));
          print("event added");
        }
      },
      child: Container(
        width: MediaQuery.of(context).size.width,
        padding: EdgeInsets.symmetric(vertical: 15),
        alignment: Alignment.center,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(5)),
            boxShadow: <BoxShadow>[
              BoxShadow(
                  color: Colors.grey.shade200,
                  offset: Offset(2, 4),
                  blurRadius: 5,
                  spreadRadius: 2)
            ],
            gradient: LinearGradient(
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
                colors: [Colors.green, Colors.cyan])),
        child: _isLoading == true
            ? DialogBox().loading(context)
            : Text('SignUp',
                style: TextStyle(color: Colors.white, fontSize: 18.0)),
      ),
    );
  }

  void handleSubmit() async {
    final form = _formKey.currentState;
    if (form.validate()) {
      print('validated');
      form.save();
      BlocProvider.of<UserBloc>(context).add(RegisterButtonPressed(
          user: UserModel(
              fullName: _currentFullName,
              phoneNumber: _currentPhoneNumber,
              password: password,
              email: email,
              role: _currentRole)));
      print("event added");
      // try {
      //   setState(() {
      //     _isLoading = true;
      //   });

      //   if (!_isCompany) {
      //     setState(() {
      //       _isLoading = false;
      //     });
      //   }
      // DialogBox().information(
      //     context, 'SignUp Success', 'You have Successfuly Logged in');
      // } catch (err) {
      //   print('error');
      //   print(err);
      // }
    }
  }

  bool isEmail(String value) {
    String regex =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regExp = new RegExp(regex);
    return value.isNotEmpty && regExp.hasMatch(value);
  }

  Widget errormessage() {
    Text(
      _error,
      style: TextStyle(color: Colors.red, fontSize: 12.0),
    );
  }
}

class AccountType {
  const AccountType({this.accountIcon, this.accountName});
  final Icon accountIcon;
  final String accountName;
}
