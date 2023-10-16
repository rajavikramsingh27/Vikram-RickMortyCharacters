
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qurhealth_task/BLoC/rick_morty_characters_cubit.dart';
import 'package:qurhealth_task/Components/AppBarStyle.dart';
import 'package:qurhealth_task/Styles/TextStyles.dart';
import 'package:cached_network_image/cached_network_image.dart';

class RickMortyCharacters extends StatefulWidget {
  const RickMortyCharacters({super.key});

  @override
  State<RickMortyCharacters> createState() => _RickMortyCharactersState();
}

class _RickMortyCharactersState extends State<RickMortyCharacters> {
  RickMortyCharactersCubit controller = RickMortyCharactersCubit();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    Future.delayed(const Duration(seconds: 1), () {
      if (mounted) {
        controller = BlocProvider.of<RickMortyCharactersCubit>(context, listen: false);

        WidgetsBinding.instance.addPostFrameCallback((_) {
          controller.getCharacterPage(1);
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBarStyle(
        text: 'Rick & Morty Characters',
        textStyle: TextStylesInter.textStyles_16,
      ),
      body: BlocBuilder<RickMortyCharactersCubit, RickMortyCharactersState>(
        builder: (context, state) {
          if (state is LoadedState) {
            return ListView.separated(
              separatorBuilder: (context, index) {
                return Container(
                  color: Colors.grey,
                  height: 1,
                );
              },
              itemCount: state.arrProductList!.length,
              itemBuilder: (context, index) {
                return Container(
                  padding: const EdgeInsets.only(
                      left: 10,
                      right: 10,
                      top: 10,
                      bottom: 10
                  ),
                  child: Column(
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: 100,
                            width: 100,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: CachedNetworkImage(
                                // imageUrl: "https://rickandmortyapi.com/api/character/avatar/22.jpeg",
                                imageUrl: state.arrProductList![index].image,
                                progressIndicatorBuilder: (context, url, downloadProgress) =>
                                    CircularProgressIndicator(value: downloadProgress.progress),
                                errorWidget: (context, url, error) => const Icon(Icons.error),
                              ),
                            ),
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(state.arrProductList![index].name, style: TextStylesInter.textStyles_16,),
                                const SizedBox(height: 10),
                                Text(state.arrProductList![index].status, style: TextStylesInter.textStyles_16,),
                                const SizedBox(height: 10),
                                Text(state.arrProductList![index].species, style: TextStylesInter.textStyles_16,),
                                // const SizedBox(height: 10),
                                // Text(state.arrProductList![index].type, style: TextStylesInter.textStyles_16,),
                                const SizedBox(height: 10),
                                Text(state.arrProductList![index].gender, style: TextStylesInter.textStyles_16,),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              },
            );
          } else {
            return const Center(
              child:  CircularProgressIndicator(
                color: Colors.green,
              ),
            );
          }
        },
      ),
    );
  }
}
