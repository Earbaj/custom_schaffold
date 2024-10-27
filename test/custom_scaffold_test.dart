// example/test/custom_scaffold_test.dart
import 'package:custom_scaffold/custom_scaffold.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('CustomScaffold displays child widget',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: CustomScaffold(
          appBar: AppBar(title: const Text('Test')),
          child: const Text('Hello from Custom Scaffold!'),
        ),
      ),
    );

    // Verify that the CustomScaffold displays the correct child
    expect(find.text('Hello from Custom Scaffold!'), findsOneWidget);
  });
}
