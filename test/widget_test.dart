import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:app_peca/screens/lista_peca_page.dart';

void main() {
  testWidgets('Deve exibir a estrutura inicial de lista de peças', (WidgetTester tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: PecaListScreen(),
      ),
    );

    expect(find.text('Lista de Peças'), findsOneWidget);

    expect(find.byIcon(Icons.add), findsOneWidget);

    expect(find.byType(CircularProgressIndicator), findsOneWidget);
  });
}
