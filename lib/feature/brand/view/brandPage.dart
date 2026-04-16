import 'package:e_commarcae/core/widget/cardBC.dart';
import 'package:e_commarcae/feature/brand/viewModel/cubit/brand_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Brandpage extends StatelessWidget {
  const Brandpage({super.key});

  @override
  
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<BrandCubit, BrandState>(
        builder: (context, state) {
          if (state is BrandLoading) {
            return CircularProgressIndicator();
          } else if (state is BrandSuccess) {
            return ListView.builder(
              itemCount: state.brands.length,
              itemBuilder: (context, ind) {
                CardBC(
                  img: state.brands[ind].emoji,
                  title: state.brands[ind].name,
                );
                return null;
              },
            );
          }
          return SizedBox.shrink();
        },
      ),
    );
  }
}