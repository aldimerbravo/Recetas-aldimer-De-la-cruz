import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:recetas_app/main.dart';

void main() {
  testWidgets('Muestra el splash y luego pasa al home', (WidgetTester tester) async {
    await tester.pumpWidget(const RecetasApp());

    // El splash muestra el nombre de la app
    expect(find.text('Recetas App'), findsOneWidget);

    // Esperamos los 3 segundos del splash para que navegue al home
    await tester.pump(const Duration(seconds: 3));
    await tester.pump();

    // Ya en el home aparece el saludo
    expect(find.text('Hola, Santos Aldimer'), findsOneWidget);
  });
}