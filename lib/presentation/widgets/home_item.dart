import '../../domain/entities/beers.dart';
import '../blocs/beers/beers_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeItem extends StatefulWidget {
  const HomeItem({
    Key? key,
    required this.item,
    this.onTap,
    this.isVisible = true,
  }) : super(key: key);
  final Beers item;

  final void Function()? onTap;
  final bool isVisible;

  @override
  State<HomeItem> createState() => _HomeItemState();
}

class _HomeItemState extends State<HomeItem> {
  @override
  Widget build(BuildContext context) {
    return Card(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(15.0)),
      ),
      child: Material(
        borderRadius: BorderRadius.circular(15.0),
        color: Colors.white,
        shadowColor: Colors.black.withOpacity(0.15),
        child: InkWell(
          borderRadius: BorderRadius.circular(15.0),
          onTap: widget.onTap,
          child: Container(
            height: 300,
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
            child: Stack(
              alignment: Alignment.center,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      flex: 4,
                      child: Image.network(
                        widget.item.imageUrl!,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Flexible(
                      flex: 1,
                      child: Text(
                        widget.item.name!,
                        style: const TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 18,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      widget.item.abv.toString(),
                      style: const TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 20,
                      ),
                    ),
                  ],
                ),
                if (widget.isVisible)
                  Positioned(
                      top: 0,
                      right: 0,
                      child: StatefulBuilder(
                        builder: (context, setState) => IconButton(
                          onPressed: () {
                            if (widget.item.isFavorite!) {
                              context
                                  .read<BeersCubit>()
                                  .removeFavorite(widget.item);
                            } else {
                              context
                                  .read<BeersCubit>()
                                  .addFavorite(widget.item);
                            }

                            setState(
                              () => widget.item.isFavorite =
                                  !widget.item.isFavorite!,
                            );
                          },
                          icon: Icon(
                            widget.item.isFavorite!
                                ? Icons.favorite_sharp
                                : Icons.favorite_border,
                            color: Colors.red,
                          ),
                        ),
                      ))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
