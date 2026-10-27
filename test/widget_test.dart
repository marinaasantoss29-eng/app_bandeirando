import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:app_bandeiras/main.dart';

void main() {
  testWidgets('menu oferece modos, continentes e tempos de jogo', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(const FlagGameApp());

    expect(find.text('BANDEIRANDO'), findsOneWidget);
    expect(find.text('Jogo aleatório'), findsOneWidget);
    expect(find.text('Por continente'), findsOneWidget);
    expect(find.text('190 países'), findsOneWidget);
    expect(find.text('30 s'), findsOneWidget);
    expect(find.text('1 min'), findsOneWidget);
    expect(find.text('3 min'), findsOneWidget);
    expect(find.text('5 min'), findsOneWidget);

    await tester.tap(find.text('Por continente'));
    await tester.pump();

    expect(find.text('África'), findsOneWidget);
    expect(find.text('América'), findsOneWidget);
    expect(find.text('Ásia'), findsOneWidget);
    expect(find.text('Europa'), findsOneWidget);
    expect(find.text('Oceania'), findsOneWidget);
  });

  testWidgets('busca bandeiras por país sem exigir acentos', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(const FlagGameApp());

    await tester.tap(find.text('Buscar'));
    await tester.pumpAndSettle();

    expect(find.text('Explorar bandeiras'), findsOneWidget);
    await tester.enterText(find.byType(TextField), 'Mexico');
    await tester.pumpAndSettle();

    expect(find.text('México'), findsOneWidget);
    expect(find.text('1 país encontrado'), findsOneWidget);
  });

  testWidgets('jogador consegue iniciar uma partida', (
    WidgetTester tester,
  ) async {
    await tester.binding.setSurfaceSize(const Size(800, 1000));
    addTearDown(() => tester.binding.setSurfaceSize(null));
    await tester.pumpWidget(const FlagGameApp());

    await tester.ensureVisible(find.text('COMEÇAR JOGO'));
    await tester.pumpAndSettle();
    await tester.tap(
      find.ancestor(
        of: find.text('COMEÇAR JOGO'),
        matching: find.byType(FilledButton),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.byType(GameScreen), findsOneWidget);
    expect(find.text('PERGUNTA 1'), findsOneWidget);
    expect(find.text('DE QUAL PAÍS É ESTA BANDEIRA?'), findsOneWidget);
    expect(find.text('ESCOLHA UMA RESPOSTA'), findsOneWidget);
    expect(find.byType(OutlinedButton), findsNWidgets(4));

    await tester.tap(find.byType(OutlinedButton).first);
    await tester.pump();
    expect(
      find.text('Isso aí! Resposta certa 🎉').evaluate().isNotEmpty ||
          find.textContaining('Quase! Era').evaluate().isNotEmpty,
      isTrue,
    );
    await tester.pump(const Duration(milliseconds: 650));
    expect(find.text('PERGUNTA 2'), findsOneWidget);
  });
}
