import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:qurinomchat/core/network/api_client.dart';
import 'package:qurinomchat/core/network/dio_client.dart';
import 'package:qurinomchat/data/repositories/auth_repository.dart';
import 'package:qurinomchat/data/repositories/chat_repository.dart';
import 'package:qurinomchat/domain/usecases/auth/login_usecase.dart';
import 'package:qurinomchat/domain/usecases/chat/get_chats_usecase.dart';
import 'package:qurinomchat/domain/usecases/chat/get_messages_usecase.dart';
import 'package:qurinomchat/domain/usecases/chat/send_message_usecase.dart';
import 'package:qurinomchat/presentation/bloc/auth/auth_bloc.dart';
import 'package:qurinomchat/presentation/bloc/chat/chat_bloc.dart';
import 'package:qurinomchat/presentation/viewmodels/auth_viewmodel.dart';
import 'package:qurinomchat/presentation/viewmodels/chat_viewmodel.dart';
import 'package:qurinomchat/presentation/views/auth/login_view.dart';
import 'package:qurinomchat/presentation/views/auth/role_selection_view.dart';
import 'package:qurinomchat/presentation/views/home_view.dart';
import 'package:shared_preferences/shared_preferences.dart';


void main()async {
  WidgetsFlutterBinding.ensureInitialized();
  final prefs = await SharedPreferences.getInstance();
  final isLoggedIn = prefs.getString('auth_token') != null;
  runApp( MyApp(isLoggedIn: isLoggedIn,));
}

class MyApp extends StatelessWidget {
  final bool isLoggedIn;
  const MyApp({required this.isLoggedIn,Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final dio = DioClient().dio;
    final apiClient = ApiClient(dio);

    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider(
          create: (context) => AuthRepository(apiClient),
        ),
        RepositoryProvider(
          create: (context) => ChatRepository(apiClient),
        ),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => AuthBloc(
              LoginUseCase(context.read<AuthRepository>()),
            ),
          ),
          BlocProvider(
            create: (context) => ChatBloc(
              GetChatsUseCase(context.read<ChatRepository>()),
              GetMessagesUseCase(context.read<ChatRepository>()),
              SendMessageUseCase(context.read<ChatRepository>()),
            ),
          ),
        ],
        child: ChangeNotifierProvider(
          create: (context) => ChatViewModel(
            context.read<ChatBloc>(),
          ),
          child: MaterialApp(
            title: 'Chat App MVVM',
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
              primarySwatch: Colors.blue,
              visualDensity: VisualDensity.adaptivePlatformDensity,
            ),
            home: const RoleSelectionView(),
            routes: {
              '/login': (context) => LoginView(
                role: '',
                viewModel: AuthViewModel(),
                emailController: TextEditingController(),
                passwordController: TextEditingController(),
                formKey: GlobalKey<FormState>(),
              ),
              '/home': (context) =>  HomeView(),
            },
          ),
        ),
      ),
    );
  }
}