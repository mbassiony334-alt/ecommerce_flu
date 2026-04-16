import 'package:e_commarcae/core/utils/auth_guard.dart';
import 'package:e_commarcae/core/widget/sideCard.dart';
import 'package:e_commarcae/feature/cart/viewModel/cubit/cart_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      AuthGuard.check(context, actionLabel: 'view your cart');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(centerTitle: true, title: const Text("Cart Items")),
      body: BlocBuilder<CartCubit, CartState>(
        builder: (context, state) {
          if (state is CartLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is ListCartSuccess) {
            return ListView.builder(
              itemCount: state.car.length,
              itemBuilder: (context, ind) {
                return SideCard(prod: state.car[ind], name: 'car');
              },
            );
          }

          return const SizedBox.shrink();
        },
      ),
    );
  }
}
