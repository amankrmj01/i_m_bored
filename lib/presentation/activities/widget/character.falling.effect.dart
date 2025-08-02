import 'package:flutter/material.dart';
import 'package:i_m_bored/constants/random.activities.dart';

class CharacterFallingEffect extends StatefulWidget {
  const CharacterFallingEffect({super.key});

  @override
  State<CharacterFallingEffect> createState() => _CharacterFallingEffectState();
}

enum _Phase { idle, falling, rising }

class _CharacterFallingEffectState extends State<CharacterFallingEffect>
    with TickerProviderStateMixin {
  late String _activity;
  late List<String> _chars;

  late List<AnimationController> _fallControllers;
  late List<Animation<double>> _fallAnimations;
  late List<AnimationController> _riseControllers;
  late List<Animation<double>> _riseAnimations;
  late List<int> _fallDelays;
  late List<int> _riseDelays;

  _Phase _phase = _Phase.idle;
  String? _pendingActivity;

  // Smooth height transition support
  double _containerHeight = 0.0;
  final _oldTextKey = GlobalKey();
  final _newTextKey = GlobalKey();

  @override
  void initState() {
    super.initState();
    _setNewActivity();
    // Waiting for first frame to get initial height
    WidgetsBinding.instance.addPostFrameCallback(
      (_) => _updateContainerHeight(),
    );
  }

  void _setNewActivity({String? activity}) {
    final newActivity = activity ?? (activities..shuffle()).first;
    _activity = newActivity;
    _chars = _activity.split('');
    _initControllers(_chars.length);
    setState(() => _phase = _Phase.idle);
  }

  void _initControllers(int len) {
    _fallControllers = List.generate(
      len,
      (_) => AnimationController(
        vsync: this,
        duration: const Duration(milliseconds: 700),
      ),
    );
    _fallAnimations = _fallControllers
        .map(
          (c) => Tween<double>(
            begin: 0,
            end: 1,
          ).animate(CurvedAnimation(parent: c, curve: Curves.easeIn)),
        )
        .toList();

    _riseControllers = List.generate(
      len,
      (_) => AnimationController(
        vsync: this,
        duration: const Duration(milliseconds: 700),
      ),
    );
    _riseAnimations = _riseControllers
        .map(
          (c) => Tween<double>(
            begin: 1,
            end: 0,
          ).animate(CurvedAnimation(parent: c, curve: Curves.easeOut)),
        )
        .toList();

    _fallDelays = List.generate(len, (_) => _randomDelay());
    _riseDelays = List.generate(len, (_) => _randomDelay());
  }

  int _randomDelay() =>
      (1000 * (0.2 + 0.8 * (UniqueKey().hashCode % 1000) / 1000)).toInt();

  Future<void> _triggerFall() async {
    setState(() => _phase = _Phase.falling);

    await Future.wait(
      List.generate(_chars.length, (i) async {
        await Future.delayed(Duration(milliseconds: _fallDelays[i]));
        _fallControllers[i].forward();
      }),
    );

    await Future.delayed(const Duration(milliseconds: 300));

    _pendingActivity = (activities..shuffle()).first;
    final newChars = _pendingActivity!.split('');
    final newLen = newChars.length;

    // Smoothly animate container to new text's size
    _updateContainerHeight(isNew: true);

    for (final c in _fallControllers) {
      c.dispose();
    }
    for (final c in _riseControllers) {
      c.dispose();
    }

    _initControllers(newLen);
    for (final c in _riseControllers) {
      c.reset();
    }

    setState(() {
      _chars = newChars;
      _activity = _pendingActivity!;
      _phase = _Phase.rising;
    });

    await Future.wait(
      List.generate(_chars.length, (i) async {
        await Future.delayed(Duration(milliseconds: _riseDelays[i]));
        _riseControllers[i].forward();
      }),
    );

    await Future.delayed(const Duration(milliseconds: 800));

    for (final c in _fallControllers) {
      c.reset();
    }
    for (final c in _riseControllers) {
      c.reset();
    }

    setState(() {
      _phase = _Phase.idle;
      // Resize container to final text height
      _updateContainerHeight();
    });
  }

  void _updateContainerHeight({bool isNew = false}) {
    // Measures height of the currently visible text (or next one if isNew)
    final context = (isNew ? _newTextKey : _oldTextKey).currentContext;
    if (context != null && mounted) {
      final height = context.size?.height ?? 0.0;
      if ((_containerHeight - height).abs() > 1) {
        setState(() {
          _containerHeight = height + 48; // 24 padding top & bottom
        });
      }
    }
  }

  @override
  void dispose() {
    for (final c in _fallControllers) {
      c.dispose();
    }
    for (final c in _riseControllers) {
      c.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Build both old & new text invisibly to measure heights for animation
    final textWidgets = <Widget>[
      _ActivityText(
        key: _oldTextKey,
        chars: _chars,
        wordSplit: _activity,
        phase: _phase,
        fallAnims: _fallAnimations,
        riseAnims: _riseAnimations,
      ),
      if (_pendingActivity != null && _phase == _Phase.falling)
        Opacity(
          key: _newTextKey,
          opacity: 0,
          child: _ActivityText(
            chars: _pendingActivity!.split(''),
            wordSplit: _pendingActivity!,
            phase: _Phase.idle,
            fallAnims: [],
            riseAnims: [],
          ),
        ),
    ];

    // Use AnimatedContainer for smooth resizing
    return Material(
      color: Colors.transparent,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 500),
          curve: Curves.easeInOut,
          constraints: BoxConstraints(
            minWidth: 250,
            maxWidth: 350,
            minHeight: _containerHeight,
          ),
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: Colors.black,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: Colors.white, width: 1),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ...textWidgets,
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: _phase == _Phase.falling || _phase == _Phase.rising
                    ? null
                    : _triggerFall,
                child: const Text('Try Again'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _ActivityText extends StatelessWidget {
  final List<String> chars;
  final String wordSplit;
  final _Phase phase;
  final List<Animation<double>> fallAnims, riseAnims;

  const _ActivityText({
    super.key,
    required this.chars,
    required this.wordSplit,
    required this.phase,
    required this.fallAnims,
    required this.riseAnims,
  });

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 4,
      crossAxisAlignment: WrapCrossAlignment.center,
      alignment: WrapAlignment.center,
      children: chars.isEmpty
          ? [const SizedBox()]
          : wordSplit.split(' ').map((word) {
              final start = wordSplit.indexOf(word);
              final wordChars = List.generate(
                word.length,
                (i) => chars[start + i],
              );
              return Row(
                mainAxisSize: MainAxisSize.min,
                children: List.generate(wordChars.length, (j) {
                  final i = start + j;
                  return (fallAnims.isEmpty || riseAnims.isEmpty)
                      ? Text(
                          wordChars[j],
                          style: const TextStyle(
                            fontSize: 18,
                            color: Colors.white,
                          ),
                        )
                      : AnimatedBuilder(
                          animation: Listenable.merge([
                            fallAnims[i],
                            riseAnims[i],
                          ]),
                          builder: (context, child) {
                            double fall = fallAnims[i].value;
                            double rise = riseAnims[i].value;
                            double offsetY = 0;
                            double opacity = 1;
                            if (phase == _Phase.falling) {
                              offsetY = fall * 60;
                              opacity = 1 - fall;
                            } else if (phase == _Phase.rising) {
                              offsetY = rise * -60;
                              opacity = 1 - rise;
                            }
                            return Transform.translate(
                              offset: Offset(0, offsetY),
                              child: Opacity(
                                opacity: opacity.clamp(0.0, 1.0),
                                child: child,
                              ),
                            );
                          },
                          child: Text(
                            wordChars[j],
                            style: const TextStyle(
                              fontSize: 18,
                              color: Colors.white,
                            ),
                          ),
                        );
                }),
              );
            }).toList(),
    );
  }
}
