import 'package:e_commarcae/core/utils/extension.dart';
import 'package:e_commarcae/core/widget/custom_elvated.dart';
import 'package:e_commarcae/core/widget/customtextfield/inputCustomButton.dart';
import 'package:e_commarcae/core/widget/customtextfield/vaildator.dart';
import 'package:e_commarcae/feature/auth/model/resgeter.dart';
import 'package:e_commarcae/feature/auth/view/logain.dart';
import 'package:e_commarcae/feature/auth/viewModel/cubit/auth_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RegestierPage extends StatefulWidget {
  const RegestierPage({super.key});

  @override
  State<RegestierPage> createState() => _RegestierPageState();
}

class _RegestierPageState extends State<RegestierPage> {
  TextEditingController controllerEmail = TextEditingController();
  TextEditingController controllerpassword = TextEditingController();
  TextEditingController controllerconfirmpassword = TextEditingController();
  TextEditingController controllerphone = TextEditingController();
  TextEditingController controllername = TextEditingController();
  

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
                  mobile: 40,
                  tablet: 70,
                  desktop: 90,
                ),
                child: Image.asset(
                  "assets/images/splashImg.png",
                  fit: BoxFit.cover,
                ),
              ),
              Inputcustombutton(
                labelText: "name",
                controller: controllername,
                prefixIcon: Icons.person,
                hint: "entre your name",
                validator: MyValidators.displayNamevalidator,
                keyboardType: TextInputType.text,
              ),
              Inputcustombutton(
                labelText: "phone",
                controller: controllerphone,
                prefixIcon: Icons.phone_android_rounded,
                hint: "entre your phone",
               validator: MyValidators.phoneValidator,
                keyboardType: TextInputType.emailAddress,
              ),
              Inputcustombutton(
                labelText: "Email",
                controller: controllerEmail,
                prefixIcon: Icons.email,
                hint: "entre your mail **@",
                validator: MyValidators.emailValidator,
                keyboardType: TextInputType.emailAddress,
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
                  if (state is Regfailure) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text("failed to regestier")),
                    );
                  } else if (state is Regsuccess) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text("regestier success")),
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
                      cubitStat.signUp(
                        RegetierModel(
                          name: controllername.text,
                          phone: controllerphone.text,
                          email: controllerEmail.text,
                          password: controllerpassword.text,
                          confirmPassword: controllerconfirmpassword.text,
                        ),
                      );
                    },
                    textwanted: true,
                    buttonTitle: "Sign Up",
                    isLoading:  state is AuthLoading,
                       
                        
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
