import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:instacar/core/services/FavoritesService.dart';

class RideCard extends StatefulWidget {
  final String id;
  final String name;
  final String genderAge;
  final String date;
  final String from;
  final String to;
  final String type;
  final String model;
  final String color;
  final String plate;
  final int totalSpots;
  final int takenSpots;
  final String observation;

  const RideCard({
    super.key,
    required this.id,
    required this.name,
    required this.genderAge,
    required this.date,
    required this.from,
    required this.to,
    required this.type,
    required this.model,
    required this.color,
    required this.plate,
    required this.totalSpots,
    required this.takenSpots,
    required this.observation,
  });

  @override
  State<RideCard> createState() => _RideCardState();
}

class _RideCardState extends State<RideCard> {
  bool isExpanded = false;
  bool isFavorite = false;

  @override
  void initState() {
    super.initState();
    checkFavorite();
  }

  Future<void> checkFavorite() async {
    final fav = await FavoritesService.isFavorite(widget.id);
    setState(() {
      isFavorite = fav;
    });
  }

  void toggleFavorite() async {
    if (isFavorite) {
      await FavoritesService.removeFavorite(widget.id);
    } else {
      await FavoritesService.addFavorite(widget.id);
    }
    setState(() {
      isFavorite = !isFavorite;
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        elevation: 0,
        behavior: SnackBarBehavior.floating,
        backgroundColor: Colors.transparent,
        content: AwesomeSnackbarContent(
          title: isFavorite ? 'Carona Favoritada!' : 'Favorito Removido',
          message: isFavorite
              ? 'Você marcou a carona como favorita.'
              : 'Você removeu a carona dos favoritos.',
          contentType:
              isFavorite ? ContentType.success : ContentType.warning,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 3,
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Top Row: Name + Age + Date
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  widget.name,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                Text(widget.genderAge, style: const TextStyle(color: Colors.grey)),
                Text(widget.date, style: const TextStyle(color: Colors.grey)),
              ],
            ),

            const Divider(height: 16),

            // Locations
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Column(
                  children: [
                    const Icon(Icons.circle, size: 10),
                    Container(
                      height: 50,
                      width: 1,
                      color: Colors.black,
                    ),
                    const Icon(Icons.square, size: 10),
                  ],
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(5),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(4),
                          color: Colors.white,
                        ),
                        child: Text(widget.from, style: const TextStyle(fontSize: 16)),
                      ),
                      const SizedBox(height: 10),
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(5),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(4),
                          color: Colors.white,
                        ),
                        child: Text(widget.to, style: const TextStyle(fontSize: 16)),
                      ),
                    ],
                  ),
                ),
                IconButton(
                  icon: Icon(isExpanded ? Icons.expand_less : Icons.expand_more),
                  onPressed: () {
                    setState(() {
                      isExpanded = !isExpanded;
                    });
                  },
                ),
              ],
            ),

            // Expandable content
            AnimatedCrossFade(
              firstChild: const SizedBox.shrink(),
              secondChild: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(height: 8),
                  Wrap(
                    spacing: 10,
                    children: [
                      const Text("Tipo:", style: TextStyle(fontWeight: FontWeight.bold)),
                      Text(widget.type),
                      const Text("Modelo:", style: TextStyle(fontWeight: FontWeight.bold)),
                      Text(widget.model),
                      const Text("Cor:", style: TextStyle(fontWeight: FontWeight.bold)),
                      Text(widget.color),
                      const Text("Placa:", style: TextStyle(fontWeight: FontWeight.bold)),
                      Text(widget.plate),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text("Observação:",
                            style: TextStyle(fontWeight: FontWeight.bold)),
                        const SizedBox(height: 12),
                        Text(widget.observation),
                      ],
                    ),
                  ),
                  const SizedBox(height: 12),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      InkWell(
                        borderRadius: BorderRadius.circular(8),
                        onTap: toggleFavorite,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                          child: Row(
                            children: [
                              Icon(
                                isFavorite ? Icons.favorite : Icons.favorite_border,
                                color: Colors.pink,
                              ),
                              const SizedBox(width: 4),
                              const Text("Favoritar", style: TextStyle(color: Colors.pink)),
                            ],
                          ),
                        ),
                      ),
                      Text("Vagas ${widget.takenSpots}/${widget.totalSpots}"),
                      InkWell(
                        borderRadius: BorderRadius.circular(8),
                        onTap: () {
                          // Navegar para o chat, se desejar
                        },
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                          child: Row(
                            children: const [
                              Icon(Icons.chat_bubble_outline, color: Colors.blue),
                              SizedBox(width: 4),
                              Text("Chat", style: TextStyle(color: Colors.blue)),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              crossFadeState:
                  isExpanded ? CrossFadeState.showSecond : CrossFadeState.showFirst,
              duration: const Duration(milliseconds: 300),
            ),
          ],
        ),
      ),
    );
  }
}
