import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:task1/src/view/screens/login_screen.dart';
import 'package:task1/src/view/widgets/build_input_email.dart';
import 'package:task1/src/view/widgets/build_input_mobile.dart';
import 'package:task1/src/view/widgets/build_input_password.dart';
import 'package:task1/src/view/widgets/default_button.dart';
import '../../controller/colors.dart';
import '../../controller/utils.dart';
import 'home_page.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final loginFormKey = GlobalKey<FormState>();
  final mobileController = TextEditingController();
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  late Box box;

  @override
  void initState() {
    super.initState();
    box = Hive.box('myBox');
  }

  void addData() async {
    var checkName = await box.containsKey(
      nameController.text,
    );
    var checkMail = await box.containsKey(
      emailController.text,
    );
    if (!checkName && !checkMail) {
      Map userData = {
        "name": nameController.text,
        "email": emailController.text,
        "mobile": mobileController.text,
        "password": passwordController.text,
      };
      await box.put(nameController.text, userData);
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
          content: Text('User already exists'),
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
                        height: 15,
                      ),
                      BuildInputEmail(
                          inputController: emailController,
                          hintText: "Enter Email"),
                      const SizedBox(
                        height: 15,
                      ),
                      BuildInputMobile(
                          hintText: 'Enter mobile number',
                          imgPath: 'assets/login_screen/user_icon.svg',
                          inputController: mobileController),
                      const SizedBox(
                        height: 15,
                      ),
                      BuildInputPassword(
                          hintText: 'Enter 4 digit pin',
                          imgPath: 'assets/login_screen/lock_icon.svg',
                          inputController: passwordController),
                      const SizedBox(
                        height: 10,
                      ),
                      DefaultButton(
                          btnText: "Sign Up",
                          onTap: () async {
                            if (loginFormKey.currentState!.validate()) {
                              addData();
                            }
                          }),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("You have account?"),
                          TextButton(
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => LoginScreen()));
                              },
                              child: Text(
                                "Login",
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
