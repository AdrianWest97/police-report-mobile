import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:prms/route_generator.dart';
import 'package:prms/utils/SharedPrefs.dart';
import 'package:prms/utils/loading_bloc.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await sharedPrefs.init();
  await DotEnv().load('.env');
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<LoadingBloc>.value(
          value: LoadingBloc(),
        )
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.red,
          backgroundColor: Color(0xfff),
        ),
        initialRoute: _checkAuth(),
        onGenerateRoute: RouteGenerator.generateRoute,
      ),
    );
  }

  _checkAuth() {
    if (sharedPrefs.token == '') {
      return '/login';
    }
    return '/';
  }
}
