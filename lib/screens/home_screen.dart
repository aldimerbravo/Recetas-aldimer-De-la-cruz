import 'package:flutter/material.dart';
import 'package:recetas_app/services/recipe_service.dart';
import 'package:recetas_app/models/receta.dart';
import 'package:recetas_app/widgets/receta_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // AHORA TODO SE OBTIENE DESDE LA API
  final RecipeService _recipeService = RecipeService();
  late Future<List<Receta>> _futureRecetas;

  // LISTA DE CATEGORIAS
  final List<Categoria> categorias = const [
    Categoria("Desayuno", Icons.free_breakfast),
    Categoria("Almuerzo", Icons.lunch_dining),
    Categoria("Cena", Icons.dinner_dining),
    Categoria("Postres", Icons.cake),
    Categoria("Bebidas", Icons.local_cafe),
    Categoria("Saludable", Icons.eco),
  ];

  @override
  void initState() {
    super.initState();
    // AQUÍ SE CONECTA A LA API Y OBTIENE LA LISTA DE RECETAS
    _futureRecetas = _recipeService.obtenerRecetas();
  }

  // MÉTODO PARA MOSTRAR TEXTO AL DAR CLIC AL BOTÓN FLOTANTE
  void _mostrarMensaje() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text("Has dado clic al botón flotante"),
        backgroundColor: Color(0xFF4E342E),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFAF6F1), // Fondo general crema
      appBar: AppBar(
        title: const Text(
          'Recetas App',
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
        // Color primario: Café oscuro
        backgroundColor: const Color(0xFF4E342E),
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _mostrarMensaje,
        // Color de acento: Café medio
        backgroundColor: const Color(0xFF8D6E63),
        child: const Icon(
          Icons.chat,
          color: Colors.white,
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Hola, Santos Aldimer",
                      style: TextStyle(
                        fontSize: 26,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF3E2723), // Texto principal oscuro
                      ),
                    ),
                    SizedBox(height: 4),
                    Text(
                      "¿Qué quieres cocinar hoy?",
                      style: TextStyle(
                        fontSize: 14,
                        color: Color(0xFF8D7B73), // Texto secundario suave
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
                CircleAvatar(
                  radius: 24,
                  backgroundColor: Color(0xFFEFE3DA), // Acento suave secundario
                  child: Icon(Icons.person, color: Color(0xFF8D6E63)),
                ),
              ],
            ),
            const SizedBox(height: 20),
            ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: Stack(
                children: [
                  // Fondo del banner con degradado (Café oscuro a Café claro)
                  Container(
                    width: double.infinity,
                    height: 140,
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          Color(0xFF5D4037),
                          Color(0xFFA1887F),
                        ],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                    ),
                  ),
                  // Textos del banner
                  const Positioned(
                    left: 20,
                    top: 24,
                    right: 20,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Más de 30 recetas",
                          style: TextStyle(
                            fontSize: 20,
                            color: Colors.white70,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        SizedBox(height: 4),
                        Text(
                          "para todos los gustos",
                          style: TextStyle(
                            fontSize: 24,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Positioned(
                    right: 16,
                    bottom: 16,
                    child: Row(
                      children: [
                        Icon(Icons.restaurant_menu, color: Colors.white),
                        SizedBox(width: 8),
                        Icon(
                          Icons.sentiment_satisfied_alt,
                          color: Colors.white,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              "Nuestras categorías",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Color(0xFF3E2723),
              ),
            ),
            const SizedBox(height: 12),
            SizedBox(
              height: 90,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: categorias.length,
                itemBuilder: (context, index) {
                  return CategoriaItem(categoria: categorias[index]);
                },
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              "Recetas Destacadas",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Color(0xFF3E2723),
              ),
            ),
            const SizedBox(height: 12),
            FutureBuilder<List<Receta>>(
              future: _futureRecetas,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(color: Color(0xFF8D6E63)),
                  );
                }
                if (snapshot.hasError) {
                  return Center(
                    child: Text(
                      "Error al conectarse con la api : ${snapshot.error}",
                    ),
                  );
                }
                if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return const Center(
                      child: Text("No hay recetas disponibles"));
                }

                final recetas = snapshot.data!;
                return GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 12,
                    mainAxisSpacing: 12,
                    childAspectRatio: 0.78,
                  ),
                  itemCount: recetas.length,
                  itemBuilder: (context, index) {
                    return RecetaCard(receta: recetas[index]);
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

// ───────── Categoría (modelo + item, dentro del mismo archivo) ─────────

class Categoria {
  final String nombre;
  final IconData icono;

  const Categoria(this.nombre, this.icono);
}

class CategoriaItem extends StatelessWidget {
  final Categoria categoria;
  const CategoriaItem({super.key, required this.categoria});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 80,
      margin: const EdgeInsets.only(right: 12),
      child: Column(
        children: [
          CircleAvatar(
            radius: 28,
            // Fondo del avatar: beige suave
            backgroundColor: const Color(0xFFEFE3DA),
            child: Icon(
              categoria.icono,
              color: const Color(0xFF8D6E63),
            ),
          ),
          const SizedBox(height: 6),
          Text(
            categoria.nombre,
            style: const TextStyle(
              color: Color(0xFF3E2723),
              fontSize: 11,
              fontWeight: FontWeight.w500,
            ),
            textAlign: TextAlign.center,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}