import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:socialapp/resources/auth_methods.dart';
import 'package:socialapp/responsive/mobile_screen.dart';
import 'package:socialapp/responsive/responsive_screen.dart';
import 'package:socialapp/responsive/web_screen.dart';
import 'package:socialapp/screens/signup_screen.dart';
import 'package:socialapp/utils/colors.dart';
import 'package:socialapp/utils/utils.dart';

import '../widgets/text_field_input.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isLoading = false;
  String _warn = '';

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
  }

  void loginUser() async {
    setState(() {
      _isLoading = true;
    });
    String res = await AuthMethods().loginUser(
        email: _emailController.text, password: _passwordController.text);

    setState(() {
      switch (res) {
        case "user-not-found":
          _warn = "User not found.";
          break;
        case "invalid-email":
          _warn = "Invalid Email.";
          break;
        case "no_input":
          _warn = "Fill all the Fields.";
          break;
        case "wrong-password":
          _warn = "You entered wrong password.";
          break;
        default:
          break;
      }
    });

    print(res);

    if (res == 'success') {
      Navigator.push(
        context,
        PageRouteBuilder(
          pageBuilder: (_, __, ___) => ResponsiveLayout(
            mobileScreenLayout: MobileScreenLayout(),
            webScreenLayout: WebScreenLayout(),
          ),
          transitionDuration: Duration(milliseconds: 350),
          transitionsBuilder: (_, a, __, c) =>
              FadeTransition(opacity: a, child: c),
        ),
      );
    } else {
      // showSnackBar(_warn, context);
    }
    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: MediaQuery.of(context).size.width > webScreenSize
              ? EdgeInsets.symmetric(
                  horizontal: MediaQuery.of(context).size.width / 3)
              : const EdgeInsets.symmetric(horizontal: 32),
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Flexible(
                child: Container(),
                flex: 1,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Let's sign you in.",
                    style: GoogleFonts.montserrat(
                      fontSize: 36,
                      fontWeight: FontWeight.w700,
                      color: mainTextColor,
                    ),
                  ),
                  const SizedBox(
                    height: 14,
                  ),
                  Text(
                    "Welcome back.",
                    style: GoogleFonts.montserrat(
                      fontSize: 28,
                      fontWeight: FontWeight.w500,
                      color: lightTextColor,
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Text(
                    "You've been missed!",
                    style: GoogleFonts.montserrat(
                      fontSize: 28,
                      fontWeight: FontWeight.w500,
                      color: lightTextColor,
                    ),
                  ),
                ],
              ),
              Flexible(
                child: Container(),
                flex: 1,
              ),
              TextFieldInput(
                hintText: "Enter your email",
                textEditingController: _emailController,
                textInputType: TextInputType.emailAddress,
                bord: 10,
              ),
              const SizedBox(
                height: 14,
              ),
              TextFieldInput(
                hintText: "Enter your password",
                textEditingController: _passwordController,
                textInputType: TextInputType.text,
                bord: 10,
                isPass: true,
              ),
              Container(
                padding: EdgeInsets.symmetric(vertical: 8),
                child: _warn != ''
                    ? Text(
                        _warn,
                        style: TextStyle(
                          color: Color.fromARGB(255, 181, 104, 104),
                        ),
                      )
                    : const SizedBox(
                        height: 14,
                      ),
              ),
              Flexible(
                flex: 3,
                child: Container(),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    child: Text(
                      "Don't have an account?",
                      style: TextStyle(color: lightTextColor),
                    ),
                    // padding: EdgeInsets.symmetric(vertical: 8),
                  ),
                  GestureDetector(
                    onTap: () => Navigator.push(
                      context,
                      PageRouteBuilder(
                        pageBuilder: (_, __, ___) => SignupScreen(),
                        transitionDuration: Duration(milliseconds: 350),
                        transitionsBuilder: (_, a, __, c) =>
                            FadeTransition(opacity: a, child: c),
                      ),
                    ),
                    child: Container(
                      padding: EdgeInsets.symmetric(vertical: 24),
                      child: const Text(
                        " Sign up",
                        style: TextStyle(
                            color: Color.fromARGB(255, 187, 187, 191),
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ],
              ),
              InkWell(
                onTap: loginUser,
                child: Container(
                  width: double.infinity,
                  alignment: Alignment.center,
                  margin: EdgeInsets.only(bottom: 20),
                  padding: const EdgeInsets.symmetric(vertical: 22),
                  decoration: const ShapeDecoration(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                    ),
                    color: primaryColor,
                  ),
                  child: _isLoading
                      ? const CircularProgressIndicator(
                          color: Colors.black,
                        )
                      : const Text("Sign in"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
