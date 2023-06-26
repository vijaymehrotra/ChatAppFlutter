import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:social_media_buttons/social_media_buttons.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:xhat_app/Wigets/login_text_field.dart';
import 'package:xhat_app/services/auth_service.dart';
import 'package:xhat_app/utils/spaces.dart';
import 'package:xhat_app/chat_page.dart';
import 'package:xhat_app/utils/textfield_styles.dart';

class LoginPage extends StatelessWidget {
  LoginPage({super.key});

  final _formkey = GlobalKey<FormState>();
  final String _mainurl = 'https://www.google.com/';

  Future<void> loginUser(BuildContext context) async{
    if (_formkey.currentState != null && _formkey.currentState!.validate()) {
      print(userNameController.text);
      print(passwordController.text);

      await context.read<AuthService>().loginUser(userNameController.text);

      Navigator.pushReplacementNamed(
        context,
        '/chat',
        arguments: '${userNameController.text}',
      );
      print('Login SuccessFul');
    } else
      print("Login Failed!!");
  }

  final userNameController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                "Let's sign you in",
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 30,
                    color: Colors.black,
                    letterSpacing: 0.5,
                    fontWeight: FontWeight.bold),
              ),
              Text(
                'Welcome back! \nYou\'ve been missed!!!',
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 20,
                    color: Colors.blueGrey),
              ),
              Image.asset(
                'images/javanese-cat.png',
                height: 200,
              ),
              Form(
                key: _formkey,
                child: Column(
                  children: [
                    LoginTextField(
                      validator: (value) {
                        if (value != null &&
                            value.isNotEmpty &&
                            value.length < 5) {
                          return "Your userName dhould be more than 5 characters";
                        } else if (value != null && value.isEmpty) {
                          return "Please type your username";
                        }
                        return null;
                      },
                      controller: userNameController,
                      hintText: 'Add your UserName',
                    ),
                    verticalSpacing(24),
                    LoginTextField(
                      controller: passwordController,
                      hintText: 'Add your PassWord',
                      hasAsterics: true,
                    ),
                    verticalSpacing(24),
                  ],
                ),
              ),
              ElevatedButton(
                  onPressed: ()async {
                    await loginUser(context);
                  },
                  child: Text(
                    'Login',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.w300),
                  )),
              GestureDetector(
                onTap: () async {
                  print("Linked Clickesd");
                  if (!await launchUrl(Uri.parse(_mainurl))) {
                    throw Exception('Could not launch this!!');
                  }
                },
                child: Column(
                  children: [
                    Text('Find us on the URL!'),
                    Text(_mainurl),
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SocialMediaButton.linkedin(
                    size: 20,
                    color: Colors.blue,
                    url: "https://twitter.com/i/flow/login",
                  ),
                  SocialMediaButton.twitter(
                      size: 20,
                      color: Colors.blue,
                      url: "https://www.linkedin.com/feed/"),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
