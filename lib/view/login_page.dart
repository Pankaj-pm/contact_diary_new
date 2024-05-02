import 'package:contact_diary/view/home_page.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  GlobalKey<FormState> fKey = GlobalKey<FormState>();
  TextEditingController email = TextEditingController();
  TextEditingController pass = TextEditingController();

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    SharedPreferences.getInstance().then((pref) {
      var isLogin = pref.getBool("isLogin");
      if(isLogin??false){
        Navigator.pushReplacement(context, MaterialPageRoute(
          builder: (context) {
            return Homepage();
          },
        ));
      }
    });

  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Form(
          key: fKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                controller: email,
                decoration: InputDecoration(hintText: "Email"),
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Enter Email Address";
                  }
                },
              ),
              SizedBox(
                height: 20,
              ),
              TextFormField(
                controller: pass,
                decoration: InputDecoration(hintText: "Password"),
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Enter password";
                  }
                },
              ),
              SizedBox(
                height: 60,
              ),
              ElevatedButton(
                  onPressed: () async {
                    var isVAl = fKey.currentState?.validate() ?? false;
                    if (isVAl) {
                      if (email.text == "abc@gmail.com" && pass.text == "123456") {
                        var sp = await SharedPreferences.getInstance();
                        await sp.setBool("isLogin", true);

                        Navigator.push(context, MaterialPageRoute(
                          builder: (context) {
                            return Homepage();
                          },
                        ));
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text("Invalid"),
                          ),
                        );
                      }
                    } else {}
                  },
                  child: Text("Login"))
            ],
          ),
        ),
      ),
    );
  }
}
