import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qurhealth_task/BLoC/rick_morty_characters_cubit.dart';
import 'package:qurhealth_task/Components/AppBarStyle.dart';
import 'package:qurhealth_task/Components/LoaderApp.dart';
import 'package:qurhealth_task/Repository/RickMortyCharactersRepo.dart';
import 'package:qurhealth_task/Styles/TextStyles.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:qurhealth_task/Views/FilterApp.dart';
import 'package:qurhealth_task/Views/RickMortyCharactersDetails.dart';

import '../Utils/API.dart';
import '../Utils/APIEndPoints.dart';

class RickMortyCharacters extends StatefulWidget {
  const RickMortyCharacters({super.key});

  @override
  State<RickMortyCharacters> createState() => _RickMortyCharactersState();
}

class _RickMortyCharactersState extends State<RickMortyCharacters> {
  RickMortyCharactersCubit? controller;
  final ScrollController scrollController = ScrollController();

  var url = kBaseURL + APIEndPoints.character_page.value;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    Future.delayed(const Duration(seconds: 1), () {
      if (mounted) {
        controller =
            BlocProvider.of<RickMortyCharactersCubit>(context, listen: false);

        WidgetsBinding.instance.addPostFrameCallback((_) {
          controller!.getCharacterPage(url: url, page: 1);
          scrollController.addListener(pagination);
        });
      }
    });
  }

  void pagination() {
    if (scrollController.position.atEdge) {
      if (scrollController.position.pixels == 0) {
        print('scrollController.position.pixels == 0');
      } else {
        controller?.pageCount += 1;
        print(controller?.pageCount);

        controller?.getCharacterPage(url: url, page: controller!.pageCount, isLoader: false);
      }
    } else {}
  }

  Widget onFilter() {
    return IconButton(
      icon: Icon(Icons.filter_list_outlined),
      onPressed: () {
        FilterApp.filterCharacters(context, onApply: () {
          Navigator.pop(context);
          print("object");

          String endPointsFilter = "";

          if (arrFilterSelected[0]) {
            endPointsFilter = "$endPointsFilter&name=${arrFilterTFController[0].text}";
          }

          if (arrFilterSelected[1]) {
            endPointsFilter = "$endPointsFilter&status=${arrFilterTFController[1].text}";
          }

          if (arrFilterSelected[2]) {
            endPointsFilter = "$endPointsFilter&species=${arrFilterTFController[2].text}";
          }

          print(endPointsFilter);

          controller!.getCharacterPage(url: url, page: 1, endPointsFilter: endPointsFilter);

        }, onCancel: () {
          Navigator.pop(context);

          arrFilterSelected = arrFilterSelected.map((e) {
            return false;
          }).toList();

          arrFilterTFController[0].text = "";
          arrFilterTFController[1].text = "";
          arrFilterTFController[2].text = "";

          url = kBaseURL + APIEndPoints.character_page.value;
          controller!.getCharacterPage(url: url, page: 1);
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: Key("vikram"),
      backgroundColor: Colors.white,
      appBar: AppBarStyle(
        text: 'Rick & Morty Characters',
        textStyle: TextStylesInter.textStyles_16,
        trailingAction: onFilter(),
      ),
      body: BlocBuilder<RickMortyCharactersCubit, RickMortyCharactersState>(
        builder: (context, state) {
          if (state is RickMortyCharactersLoadedState) {
            return Column(
              children: [
                Container(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    color: Colors.grey,
                    child: Text(
                      "Total:- ${state.arrCharacterList!.length}",
                      style: TextStylesInter.textStyles_16,
                    )),
                Expanded(
                    child: ListView.separated(
                  key: const Key("listView"),
                  controller: scrollController,
                  separatorBuilder: (context, index) {
                    return Container(
                      color: Colors.grey,
                      height: 1,
                    );
                  },
                  itemCount: state.arrCharacterList!.length,
                  itemBuilder: (context, index) {
                    return InkWell(
                      child: Container(
                        padding: const EdgeInsets.only(
                            left: 10, right: 10, top: 10, bottom: 10),
                        child: Column(
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  child: Text(index.toString()),
                                  padding: const EdgeInsets.only(right: 10),
                                ),
                                SizedBox(
                                  height: 100,
                                  width: 100,
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(10),
                                    child: CachedNetworkImage(
                                      // imageUrl: "https://rickandmortyapi.com/api/character/avatar/22.jpeg",
                                      imageUrl:
                                      state.arrCharacterList![index].image,
                                      progressIndicatorBuilder: (context, url,
                                          downloadProgress) =>
                                          CircularProgressIndicator(
                                              value: downloadProgress.progress),
                                      errorWidget: (context, url, error) =>
                                      const Icon(Icons.error),
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 10),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        state.arrCharacterList![index].name,
                                        style: TextStylesInter.textStyles_16,
                                      ),
                                      const SizedBox(height: 10),
                                      Text(
                                        state.arrCharacterList![index].status,
                                        style: TextStylesInter.textStyles_16,
                                      ),
                                      const SizedBox(height: 10),
                                      Text(
                                        state.arrCharacterList![index].species,
                                        style: TextStylesInter.textStyles_16,
                                      ),
                                      // const SizedBox(height: 10),
                                      // Text(state.arrProductList![index].type, style: TextStylesInter.textStyles_16,),
                                      const SizedBox(height: 10),
                                      Text(
                                        state.arrCharacterList![index].gender,
                                        style: TextStylesInter.textStyles_16,
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(builder: (context) => RickMortyCharactersDetails(id: state.arrCharacterList![index].id,)));
                      },
                    );
                  },
                )),
                LoaderApp.loader()
              ],
            );
          } else {
            return LoaderApp.loader();
          }
        },
      ),
    );
  }
}
