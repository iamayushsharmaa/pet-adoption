import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:petadoption/features/home/presentation/bloc/home_bloc.dart';

import '../../../../core/common/widget/pet_card.dart';
import '../../../../theme/app_colors.dart';
import '../../domain/usecases/get_all_pets_usecases.dart';

class Home extends StatefulWidget {
  final GetAllPetsUseCase getAllPetsUseCase;

  const Home({super.key, required this.getAllPetsUseCase});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late final ScrollController _scrollController;
  final searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();

    _scrollController.addListener(() {
      final bloc = context.read<HomeBloc>();
      final state = bloc.state;

      if (state is HomeLoaded &&
          !state.isLoadingMore &&
          _scrollController.position.pixels >=
              _scrollController.position.maxScrollExtent - 300) {
        bloc.add(LoadMorePets());
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textColor = theme.textTheme.bodyLarge?.color ?? AppColors.black;

    return BlocProvider(
      create: (_) => HomeBloc(widget.getAllPetsUseCase)..add(LoadPets()),
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'Home',
            style: TextStyle(fontWeight: FontWeight.bold, color: textColor),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              Container(
                decoration: BoxDecoration(
                  color:
                      theme.inputDecorationTheme.fillColor ?? theme.cardColor,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.grey.shade300),
                ),
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: TextField(
                  controller: searchController,
                  decoration: InputDecoration(
                    icon: Icon(Icons.search, color: Colors.grey),
                    hintText: 'Search...',
                    border: InputBorder.none,
                  ),
                  onChanged: (query) {
                    context.read<HomeBloc>().add(SearchPets(query));
                  },
                ),
              ),
              const SizedBox(height: 10),
              Expanded(
                child: BlocBuilder<HomeBloc, HomeState>(
                  builder: (context, state) {
                    if (state is HomeLoading) {
                      return const Center(child: CircularProgressIndicator());
                    } else if (state is HomeLoaded) {
                      return ListView.builder(
                        controller: _scrollController,
                        itemCount:
                            state.pets.length + (state.isLoadingMore ? 1 : 0),
                        itemBuilder: (context, index) {
                          if (index < state.pets.length) {
                            final pet = state.pets[index];
                            return PetCard(
                              pet: pet,
                              onPetClicked: (p) {
                                // Navigate to detail screen
                              },
                            );
                          } else {
                            return const Padding(
                              padding: EdgeInsets.symmetric(vertical: 24),
                              child: Center(child: CircularProgressIndicator()),
                            );
                          }
                        },
                      );
                    } else if (state is HomeError) {
                      return Center(child: Text(state.message));
                    }

                    return const SizedBox.shrink();
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
