import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
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

  Timer? _debounce;
  final FocusNode _focusNode = FocusNode();

  void _onSearchChanged(String query) {
    if (_debounce?.isActive ?? false) _debounce!.cancel();
    _debounce = Timer(const Duration(milliseconds: 300), () {
      context.read<HomeBloc>().add(SearchPets(query));
    });
  }

  @override
  void dispose() {
    _debounce?.cancel();
    _focusNode.dispose();
    searchController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textColor = theme.textTheme.bodyLarge?.color ?? AppColors.black;
    final isDark = theme.brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Home',
          style: TextStyle(fontWeight: FontWeight.bold, color: textColor),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: GestureDetector(
          onTap: () => _focusNode.unfocus(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 16),
              Container(
                decoration: BoxDecoration(
                  color: theme.inputDecorationTheme.fillColor ?? theme.cardColor,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: isDark ? Colors.grey.shade800 : Colors.grey.shade300,
                    width: 1,
                  ),
                  boxShadow: [
                    if (!isDark)
                      BoxShadow(
                        color: Colors.black.withOpacity(0.05),
                        blurRadius: 6,
                        offset: const Offset(0, 2),
                      ),
                  ],
                ),
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: TextField(
                  controller: searchController,
                  focusNode: _focusNode,
                  onChanged: _onSearchChanged,
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: theme.textTheme.bodyMedium?.color,
                  ),
                  decoration: InputDecoration(
                    icon: Icon(
                      Icons.search,
                      color: isDark ? Colors.grey.shade400 : Colors.grey.shade600,
                    ),
                    hintText: 'Search...',
                    hintStyle: TextStyle(
                      color: isDark ? Colors.grey.shade500 : Colors.grey.shade600,
                    ),
                    border: InputBorder.none,
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Text(
                'Pets',
                style: TextStyle(
                  fontSize: 22,
                  color: textColor,
                  fontWeight: FontWeight.bold,
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
                        itemCount: state.pets.length + 1,
                        itemBuilder: (context, index) {
                          if (index < state.pets.length) {
                            final pet = state.pets[index];
                            return PetCard(
                              pet: pet,
                              onPetClicked: (p) =>
                                  context.pushNamed('detail', extra: p),
                            );
                          }

                          if (state.isLoadingMore) {
                            return const Padding(
                              padding: EdgeInsets.symmetric(vertical: 24),
                              child: Center(child: CircularProgressIndicator()),
                            );
                          } else {
                            return const Padding(
                              padding: EdgeInsets.symmetric(vertical: 24),
                              child: Center(
                                child: Text("No more pets available"),
                              ),
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
