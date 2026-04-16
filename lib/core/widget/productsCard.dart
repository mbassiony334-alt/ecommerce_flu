import 'package:e_commarcae/core/utils/auth_guard.dart';
import 'package:e_commarcae/feature/cart/viewModel/cubit/cart_cubit.dart';
import 'package:e_commarcae/feature/favourite/viewModel/cubit/fav_cubit.dart';
import 'package:e_commarcae/feature/products/model/productsModel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Productscard extends StatefulWidget {
  const Productscard({super.key, required this.productsModel});

  final ProductsModel productsModel;

  @override
  State<Productscard> createState() => _ProductscardState();
}

class _ProductscardState extends State<Productscard> {
  bool isFav = false;
  // final favourite = BlocProvider.of<FavCubit>(context);
  @override
  Widget build(BuildContext context) {
    final favourite = BlocProvider.of<FavCubit>(context);
    final cart = BlocProvider.of<CartCubit>(context);
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      elevation: 5,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              Container(
                height: 150,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.blue.shade100,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Image.network(
                  widget.productsModel.thumbnail,
                  fit: BoxFit.contain,
                ),
              ),
              Positioned(
                top: 10,
                left: 10,
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 5,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Text(
                    "${widget.productsModel.discountPercentage}%",
                    style: const TextStyle(color: Colors.white),
                  ),
                ),
              ),
              Positioned(
                top: 10,
                right: 10,
                child: GestureDetector(
                  onTap: () {
                    if (!AuthGuard.check(
                      context,
                      actionLabel: isFav ? 'remove from favourites' : 'add to favourites',
                    )) return;
                    setState(() {
                      isFav = !isFav;
                      if (isFav) {
                        favourite.addFavourite(widget.productsModel.id);
                      }
                      if (isFav == false) {
                        favourite.delFavourite(widget.productsModel.id);
                      }
                    });
                  },
                  child: CircleAvatar(
                    backgroundColor: Colors.white,
                    child: Icon(
                      isFav ? Icons.favorite : Icons.favorite_border,
                      color: Colors.red,
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "${widget.productsModel.price} LE",
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
                Row(
                  children: [
                    const Icon(Icons.star_border),
                    Text("${widget.productsModel.rating}"),
                  ],
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Text(
              widget.productsModel.title,
              style: const TextStyle(fontSize: 16),
            ),
          ),
          const SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.all(10),
            child: SizedBox(
              width: double.infinity,
              child: OutlinedButton(
                onPressed: () {
                  if (!AuthGuard.check(context, actionLabel: 'add to cart')) return;
                  cart.addCart(widget.productsModel.id);
                },
                child: const Text("Add"),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
