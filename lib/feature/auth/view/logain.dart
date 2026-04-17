import 'package:e_commarcae/core/utils/extension.dart';
import 'package:e_commarcae/core/widget/custom_elvated.dart';
import 'package:e_commarcae/core/widget/customtextfield/inputCustomButton.dart';
import 'package:e_commarcae/core/widget/customtextfield/vaildator.dart';
import 'package:e_commarcae/feature/auth/view/forgetpage_email.dart';
import 'package:e_commarcae/feature/auth/view/regestier.dart';
import 'package:e_commarcae/feature/auth/viewModel/cubit/auth_cubit.dart';
import 'package:e_commarcae/feature/products/view/products.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController controllerEmail = TextEditingController();
  TextEditingController controllerpassword = TextEditingController();
  bool ischecked = false;

  @override
  void dispose() {
    controllerEmail.dispose();
    controllerpassword.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              
              Container(
                width: context.wp(.8),
                height: context.responsiveValue(
                  mobile: 60,
                  tablet: 90,
                  desktop: 110,
                ),
                child: Image.asset(
                  "assets/images/splashImg.png",
                  fit: BoxFit.cover,
                ),
              ),
              Inputcustombutton(
                labelText: "Email",
                controller: controllerEmail,
                prefixIcon: Icons.email,
                hint: "entre your mail **@",
                keyboardType: TextInputType.emailAddress,
                validator: MyValidators.emailValidator,
              ),
              Inputcustombutton(
                labelText: "password",
                controller: controllerpassword,
                prefixIcon: Icons.lock,
                hint: "entre your password",
                validator: MyValidators.passwordValidator,
                keyboardType: TextInputType.visiblePassword,
                obscureText: true,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  children: [
                    Row(
                      children: [
                        Checkbox(
                          value: ischecked,
                          onChanged: (val) {
                            setState(() {
                              ischecked = val!;
                            });
                          },
                        ),
                        const Text("remember me"),
                      ],
                    ),
                    const Spacer(),
                    InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (_) => ForgetPassemail()),
                        );
                      },
                      child: const Text("forget password"),
                    ),
                  ],
                ),
              ),
              BlocConsumer<AuthCubit, AuthState>(
                listener: (context, state) {
                  if (state is AuthFailure) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text("failed to login")),
                    );
                  } else if (state is AuthSucces) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text("login success")),
                    );
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => ProductHome()),
                    );
                  }
                },
                builder: (context, state) {
                  final cubitStat = BlocProvider.of<AuthCubit>(context);
                  return CustomElvated(
                    action: () {
                      cubitStat.signIn(
                        controllerEmail.text,
                        controllerpassword.text,
                      );
                    },
                    buttonTitle: "login",
                    textwanted: true,
                    isLoading: state is AuthLoading,
                  );
                },
              ),
              TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) =>RegestierPage ()),
                  );
                },
                child: const Text("if you don't have an account,click here"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
