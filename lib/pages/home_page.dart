import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:islamtime/bang.dart';
import 'package:islamtime/custom_widgets/clock.dart';
import 'package:islamtime/custom_widgets/countdown.dart';

class HomePage extends StatelessWidget {
  final Bang bang;

  const HomePage({Key key, @required this.bang}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // print('build inside HomePage ${bang.myParse}');
    // var bool = DateTime.now().compareTo(DateFormat);
    return Scaffold(
      body: SafeArea(
        child: Container(
          color: hexToColor('#E3E3ED'),
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: Center(
            child: Stack(
              children: <Widget>[
                FlareActor(
                  'assets/flare/DayAndNight.flr',
                  animation: 'night_idle',
                  fit: BoxFit.fill,
                ),
                Align(alignment: Alignment.topCenter, child: Clock()),
                Padding(
                  padding: const EdgeInsets.only(top: 90),
                  child: Align(
                    alignment: Alignment.topCenter,
                    child: Text(
                      'Time Left until midnight',
                      style: GoogleFonts.roboto(
                        fontSize: 30.0,
                        textStyle: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          shadows: <Shadow>[
                            Shadow(
                              offset: Offset(2.0, 2.0),
                              blurRadius: 3.0,
                              color: Color.fromARGB(255, 0, 0, 0),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: CountdownPage(bang: bang),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Color hexToColor(String code) {
    return new Color(int.parse(code.substring(1, 7), radix: 16) + 0xFF000000);
  }
}
