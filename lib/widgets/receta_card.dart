import 'package:flutter/material.dart';
import 'package:recetas_app/models/receta.dart';

class RecetaCard extends StatelessWidget {
  final Receta receta;
  final VoidCallback? onTap;

  const RecetaCard({
    super.key,
    required this.receta,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: const Color(0xFFF3E9E1),
      elevation: 3,
      shadowColor: const Color(0xFF4E342E).withValues(alpha: 0.15),
      margin: const EdgeInsets.all(5),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(14),
      ),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Imagen grande: ocupa todo el espacio disponible
              Expanded(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.network(
                    receta.imagenUrl,
                    fit: BoxFit.cover,
                    loadingBuilder: (context, child, progress) {
                      if (progress == null) return child;
                      return const Center(
                        child: SizedBox(
                          width: 25,
                          height: 25,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            color: Color(0xFF8D6E63),
                          ),
                        ),
                      );
                    },
                    errorBuilder: (context, error, stackTrace) {
                      return Center(
                        child: Icon(
                          Icons.image_not_supported_outlined,
                          size: 40,
                          color: Colors.brown.shade300,
                        ),
                      );
                    },
                  ),
                ),
              ),
              const SizedBox(height: 10),

              // Nombre de la receta
              Text(
                receta.nombre,
                textAlign: TextAlign.center,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF3E2723),
                ),
              ),

              const SizedBox(height: 4),
              Text(
                '${receta.porciones} porciones · ${receta.calorias} kcal',
                textAlign: TextAlign.center,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  fontSize: 12,
                  color: Color(0xFF8D7B73),
                ),
              ),

              const SizedBox(height: 10),

              // Barra café con el tiempo
              Container(
                padding: const EdgeInsets.symmetric(vertical: 8),
                decoration: BoxDecoration(
                  color: const Color(0xFFD7C0AE),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  '${receta.tiempoTotal} min',
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF5D4037),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}