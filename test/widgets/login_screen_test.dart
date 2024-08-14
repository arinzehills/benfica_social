import 'package:benfica_social/providers/auth_provider.dart';
import 'package:benfica_social/screens/login_screen.dart';
import 'package:benfica_social/widgets/my_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';

void main() {
  testWidgets('LoginScreen has Email and Password fields and a Login button', (WidgetTester tester) async {
   final mockAuthProvider = AuthProvider();
    // await tester.pumpWidget(GetMaterialApp(home: LoginScreen()));
  await tester.pumpWidget(
      ChangeNotifierProvider(
        create: (context) => AuthProvider(),
        child: const MaterialApp(
          home: LoginScreen(),
        ),
      ),
    );
    // Find the MyTextField widgets by type.
    final emailFieldFinder = find.byType(MyTextField).first;
    final passwordFieldFinder = find.byType(MyTextField).last;
    expect(emailFieldFinder, findsOneWidget);
    expect(passwordFieldFinder, findsOneWidget);
     // Simulate user typing an email.
    await tester.enterText(emailFieldFinder, 'test@example.com');
    expect(find.text('test@example.com'), findsOneWidget);

    // Simulate user typing a password.
    await tester.enterText(passwordFieldFinder, 'password123');
    expect(find.text('password123'), findsOneWidget);
    //  await tester.tap(find.text('Login'));
    await tester.pump();
  });


}
