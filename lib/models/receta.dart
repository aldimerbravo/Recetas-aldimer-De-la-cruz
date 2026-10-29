class Receta {
  final int? id;
  final String nombre;
  final List<String> ingredientes;
  final List<String> instrucciones;
  final int tiempoPreparacion;
  final int tiempoCoccion;
  final int porciones;
  final int calorias;
  final String imagenUrl;
  final double calificacion;

  const Receta({
    this.id,
    required this.nombre,
    required this.ingredientes,
    required this.instrucciones,
    required this.tiempoPreparacion,
    required this.tiempoCoccion,
    required this.porciones,
    required this.calorias,
    required this.imagenUrl,
    required this.calificacion,
  });

  factory Receta.fromJson(Map<String, dynamic> json) {
    return Receta(
      id: json['id'],
      nombre: json['name'],
      ingredientes: List<String>.from(json['ingredients']),
      instrucciones: List<String>.from(json['instructions']),
      tiempoPreparacion: json['prepTimeMinutes'] ?? 0,
      tiempoCoccion: json['cookTimeMinutes'] ?? 0, // antes: cookMinutes
      porciones: json['servings'] ?? 0,
      calorias: json['caloriesPerServing'] ?? 0,
      imagenUrl: json['image'],
      calificacion: ((json['rating'] ?? 0) as num).toDouble(),
    );
  }

  int get tiempoTotal => tiempoPreparacion + tiempoCoccion;
}