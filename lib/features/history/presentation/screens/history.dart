import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:petadoption/core/entities/pet_entity.dart';

import '../../../../core/common/widget/pet_card.dart';
import '../bloc/adopt_bloc.dart'; // Update path accordingly

class History extends StatelessWidget {
  const History({super.key});

  @override
  Widget build(BuildContext context) {
    // Load the adopted pets when screen builds
    context.read<AdoptionBloc>().add(LoadAdoptedPets());

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'History',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: BlocBuilder<AdoptionBloc, AdoptionState>(
          builder: (context, state) {
            if (state is AdoptionLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is AdoptionFailure) {
              return Center(child: Text(state.message));
            } else if (state is AdoptionHistoryLoaded) {
              if (state.pets.isEmpty) {
                return const Center(child: Text("No pets adopted yet"));
              }

              return RefreshIndicator(
                onRefresh: () async {
                  context.read<AdoptionBloc>().add(LoadAdoptedPets());
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
                        itemCount: state.pets.length,
                        itemBuilder: (context, index) {
                          final pet = state.pets[index];
                          return PetCard(
                            pet: pet.toEntity(),
                            onPetClicked: (p) => Navigator.pushNamed(
                              context,
                              'detail',
                              arguments: p,
                            ),
                          );
                        },
                      );
                    } else {
                      return ListView.builder(
                        physics: const AlwaysScrollableScrollPhysics(),
                        itemCount: state.pets.length,
                        itemBuilder: (context, index) {
                          final pet = state.pets[index];
                          return PetCard(
                            pet: pet.toEntity(),
                            onPetClicked: (p) => Navigator.pushNamed(
                              context,
                              'detail',
                              arguments: p,
                            ),
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
