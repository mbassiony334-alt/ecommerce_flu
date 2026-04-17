import 'package:e_commarcae/core/widget/sideCard.dart';
import 'package:e_commarcae/feature/favourite/viewModel/cubit/fav_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class FavPage extends StatelessWidget {
  const FavPage({super.key, this.isEmbedded = false});

  final bool isEmbedded;

  @override
  Widget build(BuildContext context) {
    final body = BlocBuilder<FavCubit, FavState>(
      builder: (context, state) {
        if (state is FavLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is ListFavSuccess) {
          if (state.faovourite.isEmpty) {
            return const _EmptySavedView();
          }
          return ListView.builder(
            itemCount: state.faovourite.length,
            itemBuilder: (context, ind) {
              return SideCard(prod: state.faovourite[ind]);
            },
          );
        }
        return const _EmptySavedView();
      },
    );
    if (isEmbedded) {
      return body;
    }
    return Scaffold(
      appBar: AppBar(centerTitle: true, title: const Text('Favourite Item')),
      body: body,
    );
  }
}

class _EmptySavedView extends StatelessWidget {
  const _EmptySavedView();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.favorite_border_rounded, size: 62, color: Colors.grey.shade400),
            const SizedBox(height: 12),
            Text(
              'No saved items yet',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: Colors.grey.shade700,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
