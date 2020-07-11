import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_cubit/flutter_cubit.dart';
import 'package:get/get.dart' as getPackage;
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:islamtime/bloc/bang_bloc.dart';
import 'package:islamtime/bloc/time_cycle/time_cycle_bloc.dart';
import 'package:islamtime/pages/home_page.dart';
import 'package:islamtime/repository/bang_api_client.dart';
import 'package:islamtime/repository/bang_repository.dart';
import 'cubit/body_status_cubit.dart';
import 'pages/onboarding_page.dart';
import 'package:http/http.dart' as http;
import 'package:islamtime/repository/location_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';

// class SimpleBlocDelegate extends BlocDelegate {
//   @override
//   void onTransition(Bloc bloc, Transition transition) {
//     super.onTransition(bloc, transition);
//     // print(transition);
//   }

//   @override
//   void onEvent(Bloc bloc, Object event) {
//     super.onEvent(bloc, event);
//     // print('event $event');
//   }
// }

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  HydratedBloc.storage = await HydratedStorage.build();

  SharedPreferences prefs = await SharedPreferences.getInstance();
  String locationPrefs = prefs.getString('location');

  print('vscodeeee');

  final LocalBangRepository repository = LocalBangRepository(
    bangApiClient: BangApiClient(
      httpClient: http.Client(),
    ),
  );

  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider<BangBloc>(
          create: (_) => BangBloc(
            bangRepository: repository,
            locationRepository: LocationRepository(),
          ),
        ),
        BlocProvider<TimeCycleBloc>(
          create: (_) => TimeCycleBloc(),
        ),
      ],
      child: CubitProvider(
        create: (_) => BodyStatusCubit(),
        child: getPackage.GetMaterialApp(
          debugShowCheckedModeBanner: false,
          home: locationPrefs != null
              ? HomePage(showDialog: false, userLocation: locationPrefs)
              : OnBoardingPage(),
        ),
      ),
    ),
  );
}
