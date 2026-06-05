import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// 1. IMPORTACIONES DE FEATURES (Architecture: Vertical Slicing)
import 'features/auth/data/services/auth_service.dart';
import 'features/auth/presentation/viewmodels/auth_viewmodel.dart';
import 'features/auth/presentation/views/login_view.dart';
import 'features/auth/presentation/views/register_view.dart';

import 'features/transactions/data/services/transaction_service.dart';
import 'features/transactions/presentation/viewmodels/transaction_viewmodel.dart';
import 'features/transactions/presentation/views/transaction_list_view.dart';

import 'package:wallet/core/theme/app_theme.dart';

void main() {
  // 2. INYECCIÓN DE DEPENDENCIAS MANUAL (Manual DI)
  final authService = AuthService();
  final transactionService = TransactionService();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => AuthViewModel(service: authService),
        ),
        ChangeNotifierProvider(
          create: (_) => TransactionViewModel(service: transactionService),
        ),
      ],
      child: const WalletApp(),
    ),
  );
}

class WalletApp extends StatelessWidget {
  const WalletApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Wallet de Gastos',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      initialRoute: '/login',
      routes: {
        '/login': (context) => const LoginView(),
        '/register': (context) => const RegisterView(),
        '/transactions': (context) => const TransactionListView(),
      },
    );
  }
}
