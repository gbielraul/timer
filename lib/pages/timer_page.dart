import 'dart:async';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:timer/global/common/constants.dart';
import 'package:timer/global/common/notification_service.dart';
import 'package:timer/global/common/time.dart';
import 'package:timer/global/widgets/border_gradient_container.dart';
import 'package:timer/global/widgets/circular_timer.dart';
import 'package:timer/global/widgets/g_app_bar.dart';

class TimerPage extends StatefulWidget {
  const TimerPage({Key? key}) : super(key: key);

  @override
  State<TimerPage> createState() => _TimerPageState();
}

class _TimerPageState extends State<TimerPage> {
  // It will be true if the sound button is disabled
  bool _isMuted = false;
  // It will be true if the remind button is enabled
  bool _doRemind = true;

  // It will be true if the timer is running
  bool _isRunning = false;

  // The timer set value
  int _max = 0;
  // The timer current value
  int _timerValue = 0;

  // The _timer will handle the _timerValue periodically
  Timer? _timer;

  // Called when this Widget initializes
  @override
  void initState() {
    super.initState();
    // Add a Timer.periodic to the _timer,
    // that will call a method every second
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) async {
      // If the timer is running and the timer value is less than timer set value
      if (_isRunning && _timerValue < _max) {
        // If the sound button is enabled
        if (!_isMuted) {
          // Play the pop.mp3 sound effect
          AudioCache cache = AudioCache();
          await cache.play('pop.mp3');
        }
        setState(() {
          // Increment the timer value
          _timerValue++;
        });
      }
      // If the timer is running and the timer value is the same of timer set value
      else if (_isRunning && _timerValue == _max) {
        // If the remind button is enabled
        if (_doRemind) {
          // Get the NotificationService and show a notification
          Provider.of<NotificationService>(context, listen: false)
              .showNotification(CustomNotification(
            id: 1,
            title: 'Timer',
            body: 'Time is over!',
            payload: '/timer',
          ));
        }
        // Stop the timer
        setState(() {
          _isRunning = false;
        });
      }
    });
  }

  // Called when the Widget disposes
  @override
  void dispose() {
    // Cancel the timer loop
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(gradient: cPrimaryGradient),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Column(
          children: [
            // AppBar
            GAppBar(
              // Set the height to 180% of default toolbar height
              height: kToolbarHeight + kToolbarHeight * .8,
              leading:
                  // Sound button
                  GestureDetector(
                onTap: () => setState(() {
                  _isMuted = !_isMuted;
                }),
                child: BorderGradientContainer(
                  shape: BoxShape.circle,
                  borderGradient: cPrimaryDarkGradient,
                  backgroundGradient: cPrimaryGradient,
                  boxShadow: const [
                    BoxShadow(
                      color: cPrimaryLight,
                      blurRadius: 20,
                      offset: Offset(-6, -6),
                    ),
                    BoxShadow(
                      color: cPrimaryDark,
                      blurRadius: 18,
                      offset: Offset(8, 8),
                    ),
                  ],
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: SvgPicture.asset(
                      'lib/global/icons/mute_${_isMuted ? 'active' : 'unactive'}.svg',
                      height: 20,
                      width: 20,
                    ),
                  ),
                ),
              ),
              actions: [
                // Remind button
                GestureDetector(
                  onTap: () => setState(() {
                    _doRemind = !_doRemind;
                  }),
                  child: BorderGradientContainer(
                    shape: BoxShape.circle,
                    borderGradient: cPrimaryDarkGradient,
                    backgroundGradient: cPrimaryGradient,
                    boxShadow: const [
                      BoxShadow(
                        color: cPrimaryLight,
                        blurRadius: 20,
                        offset: Offset(-6, -6),
                      ),
                      BoxShadow(
                        color: cPrimaryDark,
                        blurRadius: 18,
                        offset: Offset(8, 8),
                      ),
                    ],
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: SvgPicture.asset(
                        'lib/global/icons/reminder_${_doRemind ? 'active' : 'unactive'}.svg',
                        height: 20,
                        width: 20,
                      ),
                    ),
                  ),
                ),
              ],
              // AppBar title
              title: const Text(
                'Timer',
                style: heading,
              ),
            ),
            // The page body
            Expanded(
              flex: 1,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const SizedBox(height: 84),
                  // The timer
                  CircularTimer(
                    // 7% of screen
                    height: MediaQuery.of(context).size.width * .7,
                    width: MediaQuery.of(context).size.width * .7,
                    // Timer percentage bar size
                    size: 185,
                    // Timer set value
                    max: _max,
                    // Timer current value
                    // If the timer is running, the current timer value will be set to
                    // current percentage value ( 100 - (100 * timerValue / max) )
                    value: _isRunning ? 100 - (100 * _timerValue / _max) : 0,
                    // Called when the user slides down or slides up
                    // passing the move state, that is 1 if the user is sliding down or
                    // -1 if the user is sliding up
                    onDrag: (moveState) => setState(() {
                      if (!_isRunning) {
                        if (moveState == -1 && _max < 3600) {
                          setState(() {
                            _max++;
                          });
                        } else if (moveState == 1 && _max > 0) {
                          setState(() {
                            _max--;
                          });
                        }
                      }
                    }),
                    // The text within the timer
                    child: Text(
                      // Timer value formatted
                      Time.formatTime(_isRunning ? _max - _timerValue : _max),
                      style: heading,
                    ),
                  ),
                  // The Play / Pause button
                  GestureDetector(
                    onTap: () => setState(() {
                      if (!_isRunning) _timerValue = 0;
                      _isRunning = !_isRunning;
                    }),
                    child: BorderGradientContainer(
                      height: 64,
                      width: 64,
                      shape: BoxShape.rectangle,
                      borderGradient: cPrimaryDarkGradient,
                      borderRadius: BorderRadius.circular(20),
                      backgroundGradient: cPrimaryGradient,
                      boxShadow: const [
                        BoxShadow(
                          color: cPrimaryLight,
                          blurRadius: 20,
                          offset: Offset(-6, -6),
                        ),
                        BoxShadow(
                          color: cPrimaryDark,
                          blurRadius: 18,
                          offset: Offset(8, 8),
                        ),
                      ],
                      child: SvgPicture.asset(
                          'lib/global/icons/${_isRunning ? 'pause' : 'play'}.svg',
                          height: 24,
                          fit: BoxFit.scaleDown),
                    ),
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height * .1)
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
