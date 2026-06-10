// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:flutter_todo_app/main.dart';

void main() {
  testWidgets('Todo home screen shows the starter list', (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp());

    expect(find.text('TO DO'), findsOneWidget);
    expect(find.text('Make Tutorial'), findsOneWidget);
    expect(find.text('Do Exercise'), findsOneWidget);
    expect(find.byIcon(Icons.add), findsOneWidget);
    expect(find.byIcon(Icons.delete_outline), findsNWidgets(4));

    await tester.tap(find.byIcon(Icons.delete_outline).first);
    await tester.pumpAndSettle();

    expect(find.text('Make Tutorial'), findsNothing);
  });
}
