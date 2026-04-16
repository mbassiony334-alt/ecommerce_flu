import 'package:e_commarcae/core/utils/extension.dart';
import 'package:e_commarcae/core/widget/custom_elvated.dart';
import 'package:e_commarcae/core/widget/customtextfield/inputCustomButton.dart';
import 'package:e_commarcae/core/widget/customtextfield/vaildator.dart';
import 'package:e_commarcae/feature/auth/view/codePage.dart';
import 'package:e_commarcae/feature/auth/viewModel/cubit/auth_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ForgetPassemail extends StatefulWidget {
  const ForgetPassemail({super.key});

  @override
  State<ForgetPassemail> createState() => _ForgetPassemailState();
}

class _ForgetPassemailState extends State<ForgetPassemail> {
  TextEditingController controlleremail = TextEditingController();
  @override
  void dispose() {
    
    super.dispose();
    controlleremail.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
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
              "assets/images/forgetEmail.png",
              fit: BoxFit.cover,
            ),
          ),
          Inputcustombutton(
            labelText: "Email",
            controller: controlleremail,
            prefixIcon: Icons.mail_outline,
            hint: "email @**",
            validator: MyValidators.emailValidator,
            keyboardType: TextInputType.emailAddress,
          ),
          SizedBox(height: 20),
          BlocConsumer<AuthCubit, AuthState>(
            listener: (context, state) {
              if (state is Forgetfaliure) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text("your mail or user not valid"),
                    backgroundColor: Colors.redAccent,
                  ),
                );
              } else if (state is ForgetPass) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text("Check your mail"),
                    backgroundColor: Color.fromARGB(255, 240, 240, 105),
                  ),
                );
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => Codepage(email:controlleremail.text)),
                );
              }
              // TODO: implement listener
            },
            builder: (context, state) {
              final forget = BlocProvider.of<AuthCubit>(context);
              return CustomElvated(
                buttonTitle: "send code",
                textwanted: true,
                isLoading: state is AuthLoading,
                action: () {
                  forget.forgetPass(email: controlleremail.text);
                },
              );
            },
          ),
        ],
      ),
    );
  }
}
