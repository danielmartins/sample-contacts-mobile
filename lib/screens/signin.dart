import 'package:agenda_app/services/authentication_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SignIn extends StatelessWidget {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  final Color primaryColor = Color(0xff18203d);
  final Color secondaryColor = Color(0xff232c51);

  final Color logoGreen = Color(0xff25bcbb);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        body: Container(
          margin: EdgeInsets.symmetric(horizontal: 30),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildTextField(emailController, Icons.account_circle, 'Email'),
              SizedBox(
                height: 30,
              ),
              _buildTextField(passwordController, Icons.lock, 'Password'),
              SizedBox(
                height: 30,
              ),
              Builder(
                  builder: (context) => MaterialButton(
                        elevation: 0,
                        minWidth: double.maxFinite,
                        height: 50,
                        onPressed: () async {
                          String message = await context
                              .read<AuthenticationService>()
                              .signIn(
                                  email: emailController.text.trim(),
                                  password: passwordController.text.trim());
                          if (message != 'Signed in') {
                            Scaffold.of(context)
                                .showSnackBar(SnackBar(content: Text(message)));
                          }
                        },
                        color: Color(0xff25bcbb),
                        child: Text('Login',
                            style:
                                TextStyle(color: Colors.white, fontSize: 16)),
                        textColor: Colors.white,
                      ))
            ],
          ),
        ));
  }

  _buildTextField(
      TextEditingController controller, IconData icon, String labelText) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
          color: secondaryColor, border: Border.all(color: Colors.blue)),
      child: TextField(
        controller: controller,
        style: TextStyle(color: Colors.white),
        decoration: InputDecoration(
            contentPadding: EdgeInsets.symmetric(horizontal: 10),
            labelText: labelText,
            labelStyle: TextStyle(color: Colors.white),
            icon: Icon(
              icon,
              color: Colors.white,
            ),
            // prefix: Icon(icon),
            border: InputBorder.none),
      ),
    );
  }
}
