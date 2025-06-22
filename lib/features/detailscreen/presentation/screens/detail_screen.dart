import 'package:confetti/confetti.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:petadoption/features/favorite/presentation/bloc/favorite_bloc.dart';

import '../../../../core/datasource/pet_local_model.dart';
import '../../../../core/entities/pet_entity.dart';
import '../../../history/presentation/bloc/adopt_bloc.dart';

class Detail extends StatefulWidget {
  final PetEntity pet;

  const Detail({super.key, required this.pet});

  @override
  State<Detail> createState() => _DetailState();
}

class _DetailState extends State<Detail> {
  late bool isFavorited;
  late bool isAdopted;

  late ConfettiController _confettiController;

  @override
  void dispose() {
    _confettiController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _confettiController = ConfettiController(
      duration: const Duration(seconds: 2),
    );
    isFavorited = widget.pet.isFavorited;
    isAdopted = widget.pet.isAdopted;
  }

  void _toggleFavorite(BuildContext context) {
    setState(() {
      isFavorited = !isFavorited;
    });

    final updatedPet = widget.pet.copyWith(isFavorited: isFavorited);
    final localModel = PetLocalModel.fromEntity(updatedPet);

    context.read<FavoritesBloc>().add(ToggleFavoritePet(localModel));
  }

  void _handleAdopt(BuildContext context) {
    final updatedPet = widget.pet.copyWith(isAdopted: true);
    final petModel = PetLocalModel.fromEntity(updatedPet);
    context.read<AdoptionBloc>().add(AdoptPet(petModel));
    setState(() {
      isAdopted = true;
    });

    _confettiController.play();

    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text("🎉 Congratulations!"),
        content: Text("You adopted ${widget.pet.name}!"),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("OK"),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final priceBgColor = isDark ? Colors.grey[800] : Colors.grey[200];
    final priceTextColor = isDark ? Colors.white : Colors.black87;
    double imageSize = MediaQuery.of(context).size.width > 600 ? 260 : 160;

    return Stack(
      children: [
        Scaffold(
          appBar: AppBar(
            title: const Text(
              'Pet Details',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            centerTitle: true,
            leading: IconButton(
              icon: const Icon(Icons.arrow_back_ios_new),
              onPressed: () => Navigator.pop(context),
            ),
          ),
          body: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 8),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    IconButton(
                      onPressed: () => _toggleFavorite(context),
                      icon: Icon(
                        isFavorited ? Icons.favorite : Icons.favorite_border,
                        color: isDark ? Colors.redAccent : Colors.red,
                        size: 28,
                      ),
                    ),
                  ],
                ),
                Hero(
                  tag: 'petImage-${widget.pet.id}',
                  child: CircleAvatar(
                    radius: imageSize,
                    backgroundImage: NetworkImage(widget.pet.imageUrl),
                  ),
                ),
                const SizedBox(height: 16),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      widget.pet.name,
                      style: const TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 14,
                        vertical: 8,
                      ),
                      decoration: BoxDecoration(
                        color: priceBgColor,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        '₹${widget.pet.price.toStringAsFixed(0)}',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          color: priceTextColor,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),

                Text(
                  widget.pet.description,
                  style: const TextStyle(fontSize: 16),
                ),
                const SizedBox(height: 24),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconText(
                      icon: Icons.pets,
                      label: 'Breed',
                      value: widget.pet.breed,
                    ),
                    IconText(
                      icon: widget.pet.gender == 'Male'
                          ? Icons.male
                          : Icons.female,
                      label: 'Gender',
                      value: widget.pet.gender,
                    ),
                    IconText(
                      icon: Icons.calendar_today,
                      label: 'Age',
                      value: widget.pet.age,
                    ),
                  ],
                ),
                const Spacer(),
                SizedBox(
                  width: double.infinity,
                  height: 55,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: isDark ? Colors.white : Colors.black,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    onPressed: isAdopted ? null : () => _handleAdopt(context),
                    child: Text(
                      isAdopted ? 'Already Adopted' : 'Adopt Me',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: isDark ? Colors.black : Colors.white,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 8),
              ],
            ),
          ),
        ),
        Align(
          alignment: Alignment.topCenter,
          child: ConfettiWidget(
            confettiController: _confettiController,
            blastDirectionality: BlastDirectionality.explosive,
            shouldLoop: false,
            numberOfParticles: 20,
          ),
        ),
      ],
    );
  }
}

class IconText extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;

  const IconText({
    super.key,
    required this.icon,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final backgroundColor = isDark ? Colors.grey[800] : Colors.grey[200];
    final iconColor = isDark ? Colors.white : Colors.black87;

    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: backgroundColor,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Icon(icon, size: 20, color: iconColor),
        ),
        const SizedBox(width: 8),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(label, style: Theme.of(context).textTheme.bodyMedium),
            Text(value, style: Theme.of(context).textTheme.bodyMedium),
          ],
        ),
      ],
    );
  }
}
