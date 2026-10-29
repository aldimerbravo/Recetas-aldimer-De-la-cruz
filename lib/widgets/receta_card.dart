import 'package:flutter/material.dart';
import 'package:recetas_app/models/receta.dart';

class RecetaCard extends StatelessWidget {
  final Receta receta;
  final VoidCallback? onTap;

  const RecetaCard({super.key, required this.receta, this.onTap});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: const Color(0xFFF3E9E1),
      elevation: 2,
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.network(
                  receta.imagenUrl,
                  width: 90,
                  height: 90,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stack) => Container(
                    width: 90,
                    height: 90,
                    color: const Color(0xFFD7CCC8),
                    child: const Icon(Icons.restaurant,
                        color: Color(0xFF8D6E63), size: 36),
                  ),
                ),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      receta.nombre,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF3E2723),
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      '${receta.cocina} - ${receta.dificultad} - ${receta.tiempoTotal} min',
                      style: const TextStyle(
                        fontSize: 14,
                        color: Color(0xFF8D7B73),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}