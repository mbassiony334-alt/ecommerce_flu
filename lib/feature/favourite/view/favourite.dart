import 'package:e_commarcae/core/widget/sideCard.dart';
import 'package:e_commarcae/feature/favourite/viewModel/cubit/fav_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class FavPage extends StatelessWidget {
  const FavPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(centerTitle: true, title: Text("Favourit Item")),
      body: BlocBuilder<FavCubit, FavState>(
        builder: (context, state) {
          if (state is FavLoading) {
            return Center(child: CircularProgressIndicator());
          } else if (state is ListFavSuccess) {
            return ListView.builder(
              itemCount: state.faovourite.length,
              itemBuilder: (context, ind) {
                return SideCard(prod: state.faovourite[ind]);
              },
            );
          }

          return SizedBox.shrink();
        },
      ),
    );
  }
}
