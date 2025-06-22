import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:petadoption/core/entities/pet_entity.dart';
import '../../../../core/common/widget/pet_card.dart';
import '../bloc/favorite_bloc.dart';
class Favorites extends StatelessWidget {
  const Favorites({super.key});

  @override
  Widget build(BuildContext context) {
    // Trigger loading when screen builds
    context.read<FavoritesBloc>().add(LoadFavorites());

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Favorite',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: BlocBuilder<FavoritesBloc, FavoritesState>(
          builder: (context, state) {
            if (state is FavoritesLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is FavoritesError) {
              return Center(child: Text(state.message));
            } else if (state is FavoritesLoaded) {
              if (state.favorites.isEmpty) {
                return const Center(child: Text("No favorite pets found"));
              }

              return RefreshIndicator(
                onRefresh: () async {
                  context.read<FavoritesBloc>().add(LoadFavorites());
                  await Future.delayed(const Duration(milliseconds: 300));
                },
                edgeOffset: 0,
                displacement: 60,
                child: LayoutBuilder(
                  builder: (context, constraints) {
                    final isTablet = constraints.maxWidth > 600;

                    if (isTablet) {
                      return GridView.builder(
                        physics: const AlwaysScrollableScrollPhysics(),
                        padding: const EdgeInsets.only(bottom: 24),
                        gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          mainAxisSpacing: 16,
                          crossAxisSpacing: 16,
                          childAspectRatio: 1.5,
                        ),
                        itemCount: state.favorites.length,
                        itemBuilder: (context, index) {
                          final pet = state.favorites[index];
                          return PetCard(
                            pet: pet.toEntity(),
                            onPetClicked: (p) => Navigator.pushNamed(
                                context, 'detail',
                                arguments: p),
                          );
                        },
                      );
                    } else {
                      return ListView.builder(
                        physics: const AlwaysScrollableScrollPhysics(),
                        itemCount: state.favorites.length,
                        itemBuilder: (context, index) {
                          final pet = state.favorites[index];
                          return PetCard(
                            pet: pet.toEntity(),
                            onPetClicked: (p) => Navigator.pushNamed(
                                context, 'detail',
                                arguments: p),
                          );
                        },
                      );
                    }
                  },
                ),
              );
            }

            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }
}
