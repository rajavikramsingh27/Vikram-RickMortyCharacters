import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qurhealth_task/BLoC/RickMortyCharactersDetails/rick_morty_characters_details_cubit.dart';
import 'package:qurhealth_task/Components/LoaderApp.dart';
import 'package:qurhealth_task/ExportFiles/ExportFilesMust.dart';
import 'package:qurhealth_task/Repository/RickMortyCharactersDetailsRepo.dart';

class RickMortyCharactersDetails extends StatefulWidget {
  const RickMortyCharactersDetails({super.key, required this.id});

  final int id;

  @override
  State<RickMortyCharactersDetails> createState() => _RickMortyCharactersDetailsState();
}

class _RickMortyCharactersDetailsState extends State<RickMortyCharactersDetails> {
  RickMortyCharactersDetailsCubit? controller;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    // Future.delayed(const Duration(seconds: 1), () {
    //   if (mounted) {
        final repo = RickMortyCharactersDetailsRepo(id: widget.id);

        // WidgetsBinding.instance.addPostFrameCallback((_) {
          controller = BlocProvider.of<RickMortyCharactersDetailsCubit>(context, listen: false);
          controller?.di_RickMortyCharactersDetailsRepo = repo;
          controller?.getCharacterPage();
        // });
      // }
    // });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();

    controller = null;
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarStyle(
        text: 'Details',
        textStyle: TextStylesInter.textStyles_16,
      ),
      body: BlocBuilder<RickMortyCharactersDetailsCubit, RickMortyCharactersDetailsState>(
          builder: (context, state) {
            if (state is RickMortyCharactersDetailsLoadedState) {
              return Container(
                key: const Key("detailsContainer"),
                color: Colors.white,
                padding:
                const EdgeInsets.only(left: 10, right: 10, top: 10, bottom: 10),

                width: double.infinity,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 100,
                      width: 100,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: CachedNetworkImage(
                          key: const Key("image"),
                          imageUrl:
                          "https://rickandmortyapi.com/api/character/avatar/22.jpeg",
                          // imageUrl:
                          // state.arrProductList![index].image,
                          progressIndicatorBuilder:
                              (context, url, downloadProgress) =>
                              CircularProgressIndicator(
                                  value: downloadProgress.progress),
                          errorWidget: (context, url, error) =>
                          const Icon(Icons.error),
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      key: const Key("name"),
                      state.characterDetails!.name,
                      style: TextStylesInter.textStyles_16,
                    ),
                    const SizedBox(height: 10),
                    Text(
                      key: const Key("status"),
                      state.characterDetails!.status,
                      style: TextStylesInter.textStyles_16,
                    ),
                    const SizedBox(height: 10),
                    Text(
                      key: const Key("species"),
                      state.characterDetails!.species,
                      style: TextStylesInter.textStyles_16,
                    ),
                    // const SizedBox(height: 10),
                    // Text(state.arrProductList![index].type, style: TextStylesInter.textStyles_16,),
                    const SizedBox(height: 10),
                    Text(
                      key: const Key("gender"),
                      state.characterDetails!.gender,
                      style: TextStylesInter.textStyles_16,
                    ),
                  ],
                ),
              );
            } else {
              return LoaderApp.loader();
            }
        }
      ),
    );
  }
}
