import 'package:e_commarcae/core/widget/cardBC.dart';
import 'package:e_commarcae/feature/categories/viewModel/cubit/categories_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Brandpage extends StatelessWidget {
  const Brandpage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<CategoriesCubit, CategoriesState>(
        builder: (context, state) {
          if (state is CategoriesLoading) {
            return CircularProgressIndicator();
          } else if (state is CategoriesSuccess) {
            return ListView.builder(
              itemCount: state.categories.length,
              itemBuilder: (context, ind) {
                CardBC(
                  img: state.categories[ind].image,
                  title: state.categories[ind].name,
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
