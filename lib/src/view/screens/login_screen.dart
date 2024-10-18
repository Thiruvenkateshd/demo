import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:task1/src/view/screens/home_page.dart';
import 'package:task1/src/view/screens/signup_screen.dart';
import 'package:task1/src/view/widgets/build_input_email.dart';
import 'package:task1/src/view/widgets/build_input_password.dart';
import 'package:task1/src/view/widgets/default_button.dart';
import '../../controller/colors.dart';
import '../../controller/utils.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final loginFormKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final passwordController = TextEditingController();
  late Box box;

  @override
  void initState() {
    super.initState();
    box = Hive.box('myBox');
  }

  void checkLogin() async {
    var userdata = await box.get(
      nameController.text,
    );
    if (userdata != null && passwordController.text == userdata['password']) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Welcome'),
        ),
      );
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => MovieListPage()));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('User not available'),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Form(
            key: loginFormKey,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            child: Container(
              color: whiteColor,
              child: Column(
                children: [
                  SizedBox(
                    height: screenWidth > 375 ? 180 : 120,
                  ),
                  Image.asset(
                    'assets/login_screen/login.jpg',
                    width: 200,
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  const Text(
                    'Welcome,',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  const Text('Lets get start now!'),
                  const SizedBox(
                    height: 50,
                  ),
                  Container(
                    padding: const EdgeInsets.fromLTRB(30, 50, 30, 20),
                    decoration: const BoxDecoration(
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(30),
                            topRight: Radius.circular(30))),
                    child: Column(children: [
                      BuildInputEmail(
                          inputController: nameController,
                          hintText: "Enter User Name"),
                      const SizedBox(
                        height: 20,
                      ),
                      BuildInputPassword(
                          hintText: 'Enter 4 digit pin',
                          imgPath: 'assets/login_screen/lock_icon.svg',
                          inputController: passwordController),
                      const SizedBox(
                        height: 10,
                      ),
                      DefaultButton(
                          btnText: "Login",
                          onTap: () {
                            checkLogin();
                          }),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("Don't have an account?"),
                          TextButton(
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => SignupScreen()));
                              },
                              child: Text(
                                "signup",
                                style: TextStyle(color: blueColor),
                              ))
                        ],
                      )
                    ]),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
