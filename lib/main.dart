import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:prms/components/material_color.dart';
import 'package:prms/root.dart';
import 'package:prms/route_generator.dart';
import 'package:prms/utils/SharedPrefs.dart';
import 'package:prms/utils/currentUser.dart';
import 'package:prms/utils/loading_bloc.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final savedThemeMode = await AdaptiveTheme.getThemeMode();
  await sharedPrefs.init();
  await DotEnv().load('.env');
  runApp(MyApp(savedThemeMode: savedThemeMode));
}

class MyApp extends StatelessWidget {
  final AdaptiveThemeMode savedThemeMode;

  const MyApp({Key key, this.savedThemeMode}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AdaptiveTheme(
      light: ThemeData(
          brightness: Brightness.light,
          primarySwatch: createMaterialColor(Color(0xFFBA5E5F)),
          accentColor: createMaterialColor(Color(0xFF1F78B4))),
      dark: ThemeData(
        brightness: Brightness.dark,
        primarySwatch: createMaterialColor(Color(0xFFBA5E5F)),
        accentColor: createMaterialColor(Color(0xFF1F78B4)),
      ),
      initial: AdaptiveThemeMode.light,
      builder: (theme, darkTheme) => MultiProvider(
        providers: [
          ChangeNotifierProvider<LoadingBloc>.value(
            value: LoadingBloc(),
          ),
          ChangeNotifierProvider<CurrentUser>.value(
            value: CurrentUser(),
          )
        ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: theme,
          darkTheme: darkTheme,
          home: AuthRoot(),
          onGenerateRoute: RouteGenerator.generateRoute,
        ),
      ),
    );
  }
}
