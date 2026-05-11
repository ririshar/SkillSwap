// ignore: unused_import
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:skill_swap_app/main.dart';

void main() {
  testWidgets('App loads and shows Listings page', (WidgetTester tester) async {
    await tester.pumpWidget(const SkillSwapApp());

    expect(find.text('Browse Skills'), findsOneWidget);
    expect(find.text('Listings'), findsOneWidget);
    expect(find.text('Create'), findsOneWidget);
    expect(find.text('Requests'), findsOneWidget);
  });

  testWidgets('Can navigate to Create page', (WidgetTester tester) async {
    await tester.pumpWidget(const SkillSwapApp());

    await tester.tap(find.text('Create'));
    await tester.pumpAndSettle();

    expect(find.text('Create Listing'), findsOneWidget);
  });

  testWidgets('Can navigate to Requests page', (WidgetTester tester) async {
    await tester.pumpWidget(const SkillSwapApp());

    await tester.tap(find.text('Requests'));
    await tester.pumpAndSettle();

    expect(find.text('Requests'), findsWidgets);
  });
}