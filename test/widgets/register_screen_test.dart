import 'package:benfica_social/providers/auth_provider.dart';
import 'package:benfica_social/screens/login_screen.dart';
import 'package:benfica_social/screens/register_screen.dart';
import 'package:benfica_social/widgets/my_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/route_manager.dart';
import 'package:provider/provider.dart';

void main() {
  testWidgets('Register Screen has First Name, Email and Password fields and a Login button', (WidgetTester tester) async {
   final mockAuthProvider = AuthProvider();
    // await tester.pumpWidget(GetMaterialApp(home: LoginScreen()));
  await tester.pumpWidget(
      ChangeNotifierProvider(
        create: (context) => AuthProvider(),
        child: MaterialApp(
          home: RegisterScreen(),
        ),
      ),
    );
    // Find the MyTextField widgets by type.
    final nameFieldFinder = find.byType(MyTextField).first;
    final emailFieldFinder = find.byType(MyTextField);
    final passwordFieldFinder = find.byType(MyTextField).last;
    expect(emailFieldFinder, findsOneWidget);
    expect(passwordFieldFinder, findsOneWidget);
     // Simulate user typing an email.
    await tester.enterText(emailFieldFinder, 'test@example.com');
    expect(find.text('test@example.com'), findsOneWidget);

    // Simulate user typing a password.
    await tester.enterText(passwordFieldFinder, 'password123');
    expect(find.text('password123'), findsOneWidget);
     await tester.tap(find.text('Register'));
    await tester.pump();
  });


}
