import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:socialapp/resources/auth_methods.dart';
import 'package:socialapp/responsive/mobile_screen.dart';
import 'package:socialapp/responsive/web_screen.dart';
import 'package:socialapp/screens/login_screen.dart';
import 'package:socialapp/utils/colors.dart';
import 'package:socialapp/utils/utils.dart';
import '../responsive/responsive_screen.dart';
import '../widgets/text_field_input.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _bioController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  String _warn = '';
  bool _isLoading = false;
  Uint8List? _image;

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _usernameController.dispose();
  }

  void signUpUser() async {
    setState(() {
      _isLoading = true;
    });

    // String res = "plss";
    String res = await AuthMethods().signUpUser(
      email: _emailController.text,
      password: _passwordController.text,
      bio: _bioController.text,
      username: _usernameController.text,
      file: _image,
    );

    setState(() {
      switch (res) {
        case "invalid-email":
          _warn = "The email is invalid.";
          break;
        case "email-already-in-use":
          _warn = "The email address is already in use by another account.";
          break;
        case "weak-password":
          _warn = "Password should be at least 6 characters.";
          break;
        default:break;
      }
    });

    if (res == 'success') {
      setState(() {
        _isLoading = false;
      });
      // ignore: use_build_context_synchronously
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => const ResponsiveLayout(
            mobileScreenLayout: MobileScreenLayout(),
            webScreenLayout: WebScreenLayout(),
          ),
        ),
      );
    } else {
      setState(() {
        _isLoading = false;
      });
    showSnackBar(res, context);
    }
  }

  seleteImage() async {
    Uint8List im = await pickImage(ImageSource.gallery, isPost: false);
    setState(() {
      _image = im;
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
            mainAxisSize: MainAxisSize.max,
            children: [
              Flexible(
                child: Container(),
                flex: 1,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Text(
                  //   "Let's sign up",
                  //   style: GoogleFonts.montserrat(
                  //     fontSize: 36,
                  //     fontWeight: FontWeight.w700,
                  //     color: mainTextColor,
                  //   ),
                  // ),
                  // const SizedBox(
                  //   height: 14,
                  // ),
                  Text(
                    "Sign up",
                    style: GoogleFonts.montserrat(
                      fontSize: 28,
                      fontWeight: FontWeight.w500,
                      color: mainTextColor,
                    ),
                  ),
                ],
              ),
              Flexible(
                child: Container(),
                flex: 1,
              ),

              // AVATAR

              Stack(
                children: [
                  _image != null
                      ? CircleAvatar(
                          radius: 64,
                          backgroundImage: MemoryImage(_image!),
                          backgroundColor: Colors.white,
                        )
                      : const CircleAvatar(
                          radius: 64,
                          backgroundImage: NetworkImage(
                              'https://i.stack.imgur.com/l60Hf.png'),
                          backgroundColor: Colors.white,
                        ),
                  Positioned(
                    bottom: -14,
                    right: 5,
                    child: IconButton(
                      onPressed: seleteImage,
                      icon: const Icon(
                        Icons.add_a_photo,
                        color: Colors.white,
                        shadows: [
                          Shadow(blurRadius: 35),
                        ],
                      ),
                    ),
                  )
                ],
              ),

              Flexible(
                flex: 1,
                child: Container(),
              ),

              // USERNAME

              TextFieldInput(
                paddi: 16,
                bord: 10,
                hintText: "Username",
                textEditingController: _usernameController,
                textInputType: TextInputType.text,
              ),

              const SizedBox(
                height: 14,
              ),

              // EMAIL

              TextFieldInput(
                paddi: 16,
                bord: 10,
                hintText: "Enter your email",
                textEditingController: _emailController,
                textInputType: TextInputType.emailAddress,
              ),

              const SizedBox(
                height: 14,
              ),

              // PASSWORD

              TextFieldInput(
                paddi: 16,
                bord: 10,
                hintText: "Enter your password",
                textEditingController: _passwordController,
                textInputType: TextInputType.text,
                isPass: true,
              ),

              const SizedBox(
                height: 14,
              ),

              // BIO

              TextFieldInput(
                paddi: 16,
                bord: 10,
                hintText: "Enter your bio",
                textEditingController: _bioController,
                textInputType: TextInputType.multiline,
              ),

              Container(
                  padding: EdgeInsets.symmetric(vertical: _warn != '' ? 8 : 0),
                  child: _warn != ''
                      ? Text(
                          _warn,
                          style: TextStyle(
                            color: lightTextColor,
                          ),
                        )
                      : const SizedBox()),

              Flexible(
                flex: 3,
                child: Container(),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    child: Text(
                      "Have an account?",
                      style: TextStyle(color: lightTextColor),
                    ),
                    // padding: EdgeInsets.symmetric(vertical: 8),
                  ),
                  GestureDetector(
                    onTap: () => Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => LoginScreen(),
                      ),
                    ),
                    child: Container(
                      padding: EdgeInsets.symmetric(vertical: 24),
                      child: const Text(
                        " Sign in",
                        style: TextStyle(
                            color: Color.fromARGB(255, 187, 187, 191),
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ],
              ),
              InkWell(
                onTap: () => {signUpUser()},
                child: Container(
                  width: double.infinity,
                  alignment: Alignment.center,
                  // margin: EdgeInsets.only(bottom: 20),
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  decoration: const ShapeDecoration(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                    ),
                    color: primaryColor,
                  ),
                  child: !_isLoading
                      ? const Text("Sign up")
                      : const CircularProgressIndicator(
                          color: Colors.black,
                        ),
                ),
              ),
              Flexible(
                flex: 1,
                child: Container(),
              )
            ],
          ),
        ),
      ),
    );
  }
}
