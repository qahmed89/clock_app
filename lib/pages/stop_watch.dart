import 'package:flutter/material.dart';
import 'package:stop_watch_timer/stop_watch_timer.dart';

class StopWatch extends StatefulWidget {


  @override
  _StopWatchState createState() => _StopWatchState();

}

class _StopWatchState extends State<StopWatch> {

  final _isHours = true;

  final StopWatchTimer _stopWatchTimer = StopWatchTimer(
    isLapHours: true,
    onChange: (value) => print('onChange $value'),
    onChangeRawSecond: (value) => print('onChangeRawSecond $value'),
    onChangeRawMinute: (value) => print('onChangeRawMinute $value'),
  );

  final _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _stopWatchTimer.rawTime.listen((value) =>
        print('rawTime $value ${StopWatchTimer.getDisplayTime(value)}'));
    _stopWatchTimer.minuteTime.listen((value) => print('minuteTime $value'));
    _stopWatchTimer.secondTime.listen((value) => print('secondTime $value'));
    _stopWatchTimer.records.listen((value) => print('records $value'));

    /// Can be set preset time. This case is "00:01.23".
    // _stopWatchTimer.setPresetTime(mSec: 1234);
  }

  @override
  void dispose() async {
    super.dispose();
    await _stopWatchTimer.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Container(

    child: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          /// Display stop watch time
          Padding(
            padding: const EdgeInsets.only(bottom: 0),
            child: StreamBuilder<int>(
              stream: _stopWatchTimer.rawTime,
              initialData: _stopWatchTimer.rawTime.value,
              builder: (context, snap) {
                final value = snap.data;
                final displayTime =
                StopWatchTimer.getDisplayTime(value, hours: _isHours);
                return Column(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(8),
                      child: Text(
                        displayTime,
                        style: const TextStyle(
                            fontSize: 40,
                            fontFamily: 'avenir',
                            color: Colors.white,

                            fontWeight: FontWeight.bold),
                      ),

                    ),
                     SizedBox(height: 20,)
                  ],
                );
              },
            ),
          ),

          /// Display every minute.

          /// Button
          Padding(
            padding: const EdgeInsets.all(2),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(bottom: 0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 4),
                        child: RoundButton(
                          colors: Colors.green,
                          icon: Icons.play_arrow,
                          onPress: () async {
                            _stopWatchTimer.onExecute
                                .add(StopWatchExecute.start);
                          },

                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 4),
                        child: RoundButton(
                          colors: Colors.red,
                          icon: Icons.stop,
                          onPress: () async {
                            _stopWatchTimer.onExecute
                                .add(StopWatchExecute.stop);
                          },

                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 4),
                        child: RoundButton(
                          colors: Colors.blue,
                          icon: Icons.refresh,
                          onPress: () async {
                            _stopWatchTimer.onExecute
                                .add(StopWatchExecute.reset);
                          },

                        ),
                      ),


        ]
      ),
    ),
      ]
    ),
    ),
      ]
    )
    )
    );



  }
}
class RoundButton extends StatelessWidget {
  RoundButton ({this.colors , this.onPress , this.icon});
  final Color colors;
  final Function onPress ;
  final IconData icon ;
  @override
  Widget build(BuildContext context) {
    return ClipOval(

      child: Material(
        elevation: 20.0,
        color: colors, // button color
        child: InkWell(
          splashColor: Colors.red, // inkwell color
          child: SizedBox(width: 56, height: 56, child: Icon(icon ,color: Colors.white,)),
          onTap: onPress,
        ),
      ),
    );
  }
}
