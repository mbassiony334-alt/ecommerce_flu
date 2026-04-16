// import 'package:e_commarcae/core/utils/extension.dart';
// import 'package:e_commarcae/core/widget/custom_elvated.dart';
// import 'package:e_commarcae/core/widget/customtextfield/inputCustomButton.dart';
// import 'package:e_commarcae/core/widget/customtextfield/vaildator.dart';
// import 'package:e_commarcae/feature/auth/view/forgetpage_email.dart';
// import 'package:e_commarcae/feature/auth/viewModel/cubit/auth_cubit.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';

// class ForgetPassPhone extends StatefulWidget {
//   const ForgetPassPhone({super.key});

//   @override
//   State<ForgetPassPhone> createState() => _ForgetPassPhoneState();
// }

// class _ForgetPassPhoneState extends State<ForgetPassPhone> {
//   TextEditingController controllerphone = TextEditingController();
//   @override
//   void dispose() {
//     // TODO: implement dispose
//     super.dispose();
//     controllerphone.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Center(
//       child: Column(
//         children: [
//           // ignore: sized_box_for_whitespace
//           Container(
//             width: context.wp(.8),
//             height: context.responsiveValue(
//               mobile: 60,
//               tablet: 90,
//               desktop: 110,
//             ),
//             child: Image.asset(
//               "assets/images/Illustration_Forgot_Password_With_Phone.jpg",
//               fit: BoxFit.cover,
//             ),
//           ),
//           Inputcustombutton(
//             labelText: "phone",
//             controller: controllerphone,
//             prefixIcon: Icons.phone,
//             hint: "phone number",
//             validator: MyValidators.phoneValidator,
//             keyboardType: TextInputType.number,
//           ),
//           SizedBox(height: 20),
//           BlocConsumer<AuthCubit, AuthState>(
//             listener: (context, state) {
//               if()
//               // TODO: implement listener
//             },
//             builder: (context, state) {
//               return CustomElvated(buttonTitle: "send code", action: () {});
//             },
//           ),
//           InkWell(
//             onTap: () {
//               Navigator.push(
//                 context,
//                 MaterialPageRoute(builder: (context) => ForgetPassemail()),
//               );
//             },
//             child: Text("try another way"),
//           ),
//         ],
//       ),
//     );
//   }
// }
