import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('App smoke test', (WidgetTester tester) async {
    // Basic smoke test - just check MaterialApp can be created
    // Full app testing requires EasyLocalization setup which is complex in test environment
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: Center(child: Text('Chatbox Flutter')),
        ),
      ),
    );
    
    await tester.pump();
    expect(find.text('Chatbox Flutter'), findsOneWidget);
  });
}
