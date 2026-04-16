import 'package:e_commarcae/core/utils/extension.dart';
import 'package:e_commarcae/core/widget/custom_elvated.dart';
import 'package:e_commarcae/core/widget/customtextfield/inputCustomButton.dart';
import 'package:e_commarcae/core/widget/customtextfield/vaildator.dart';
import 'package:e_commarcae/feature/auth/view/logain.dart';
import 'package:e_commarcae/feature/auth/viewModel/cubit/auth_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Restpage extends StatefulWidget {
  final String email;

  const Restpage({super.key, required this.email});

  @override
  State<Restpage> createState() => _RestpageState();
}

class _RestpageState extends State<Restpage> {
  TextEditingController controllerconfirmpassword = TextEditingController();
  TextEditingController controllerpassword = TextEditingController();

  _RestpageState();

  @override
  void dispose() {
    controllerconfirmpassword.dispose();
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
              // ignore: sized_box_for_whitespace
              Container(
                width: context.wp(.8),
                height: context.responsiveValue(
                  mobile: 60,
                  tablet: 90,
                  desktop: 110,
                ),
                child: Image.asset(
                  "assets/images/Illustration_Create_New_Password.jpg",
                  fit: BoxFit.cover,
                ),
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
              Inputcustombutton(
                labelText: "Confirm password",
                controller: controllerconfirmpassword,
                prefixIcon: Icons.lock,
                hint: "entre your confirm password",
                validator: MyValidators.passwordValidator,
                keyboardType: TextInputType.visiblePassword,
                obscureText: true,
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
                      MaterialPageRoute(builder: (_) => LoginPage()),
                    );
                  }
                },
                builder: (context, state) {
                  final cubitStat = BlocProvider.of<AuthCubit>(context);
                  return CustomElvated(
                    action: () {
                      cubitStat.resPassword(
                        widget.email,
                        controllerconfirmpassword.text,
                        controllerpassword.text,
                      );
                    },
                    buttonTitle: "Confirm",
                    textwanted: true,
                    isLoading: state is AuthLoading,
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
