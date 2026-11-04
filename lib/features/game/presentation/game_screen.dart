import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';

import '../../../core/theme/app_theme.dart';
import '../../flags/data/country.dart';
import 'result_screen.dart';
class GameScreen extends StatefulWidget {
  const GameScreen({
    required this.countries,
    required this.duration,
    required this.modeLabel,
    super.key,
  });

  final List<Country> countries;
  final int duration;
  final String modeLabel;

  @override
  State<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  final Random _random = Random();
  late final List<Country> _questions;
  late List<Country> _currentOptions;
  late int _remainingSeconds;
  Timer? _timer;
  int _questionIndex = 0;
  int _answered = 0;
  int _correct = 0;
  String? _selectedAnswer;
  bool _finished = false;

  Country get _currentCountry => _questions[_questionIndex % _questions.length];

  List<Country> _createOptions() {
    final choices =
        widget.countries
            .where((country) => country.name != _currentCountry.name)
            .toList()
          ..shuffle(_random);
    return <Country>[...choices.take(3), _currentCountry]..shuffle(_random);
  }

  @override
  void initState() {
    super.initState();
    _questions = List<Country>.of(widget.countries)..shuffle(_random);
    _currentOptions = _createOptions();
    _remainingSeconds = widget.duration;
    _timer = Timer.periodic(const Duration(seconds: 1), (_) {
      if (!mounted || _finished) return;
      if (_remainingSeconds <= 1) {
        setState(() => _remainingSeconds = 0);
        _finishGame();
      } else {
        setState(() => _remainingSeconds--);
      }
    });
  }

  void _answer(Country answer) {
    if (_selectedAnswer != null || _finished) return;
    setState(() {
      _selectedAnswer = answer.name;
      _answered++;
      if (answer.name == _currentCountry.name) _correct++;
    });
    Future<void>.delayed(const Duration(milliseconds: 650), () {
      if (!mounted || _finished || _remainingSeconds == 0) return;
      setState(() {
        _questionIndex++;
        _selectedAnswer = null;
        _currentOptions = _createOptions();
      });
    });
  }

  void _finishGame() {
    if (_finished) return;
    _finished = true;
    _timer?.cancel();
    Navigator.of(context).pushReplacement(
      MaterialPageRoute<void>(
        builder: (_) => ResultScreen(
          answered: _answered,
          correct: _correct,
          modeLabel: widget.modeLabel,
          duration: widget.duration,
        ),
      ),
    );
  }

  String get _formattedTime {
    final minutes = (_remainingSeconds ~/ 60).toString().padLeft(2, '0');
    final seconds = (_remainingSeconds % 60).toString().padLeft(2, '0');
    return '$minutes:$seconds';
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final progress = _remainingSeconds / widget.duration;
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 560),
            child: Padding(
              padding: const EdgeInsets.fromLTRB(22, 14, 22, 22),
              child: Column(
                children: [
                  Row(
                    children: [
                      IconButton(
                        onPressed: () => Navigator.of(context).maybePop(),
                        icon: const Icon(Icons.close_rounded),
                        style: IconButton.styleFrom(
                          backgroundColor: Colors.white,
                          foregroundColor: ink,
                        ),
                      ),
                      const Spacer(),
                      Text(
                        widget.modeLabel.toUpperCase(),
                        style: const TextStyle(
                          color: muted,
                          fontWeight: FontWeight.w800,
                          fontSize: 11,
                          letterSpacing: 1.2,
                        ),
                      ),
                      const Spacer(),
                      const Icon(
                        Icons.check_circle_outline,
                        color: leaf,
                        size: 19,
                      ),
                      const SizedBox(width: 5),
                      Text(
                        '$_correct',
                        style: const TextStyle(
                          color: forest,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'PERGUNTA ${_answered + 1}',
                        style: const TextStyle(
                          color: muted,
                          fontSize: 11,
                          fontWeight: FontWeight.w800,
                          letterSpacing: 1.2,
                        ),
                      ),
                      Row(
                        children: [
                          Icon(
                            Icons.timer_outlined,
                            size: 17,
                            color: _remainingSeconds <= 10
                                ? const Color(0xFFCC5948)
                                : forest,
                          ),
                          const SizedBox(width: 5),
                          Text(
                            _formattedTime,
                            style: TextStyle(
                              color: _remainingSeconds <= 10
                                  ? const Color(0xFFCC5948)
                                  : forest,
                              fontSize: 16,
                              fontWeight: FontWeight.w800,
                              fontFeatures: const [
                                FontFeature.tabularFigures(),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: LinearProgressIndicator(
                      value: progress.clamp(0, 1),
                      minHeight: 7,
                      backgroundColor: const Color(0xFFE5E9E1),
                      color: _remainingSeconds <= 10
                          ? const Color(0xFFCC5948)
                          : leaf,
                    ),
                  ),
                  const SizedBox(height: 22),
                  Expanded(
                    child: Column(
                      children: [
                        Expanded(
                          flex: 5,
                          child: Container(
                            width: double.infinity,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(26),
                              border: Border.all(
                                color: const Color(0xFFE9ECE6),
                              ),
                              boxShadow: const [
                                BoxShadow(
                                  color: Color(0x0C173B28),
                                  blurRadius: 22,
                                  offset: Offset(0, 8),
                                ),
                              ],
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Text(
                                  'DE QUAL PAÍS É ESTA BANDEIRA?',
                                  style: TextStyle(
                                    color: muted,
                                    fontSize: 10,
                                    letterSpacing: 1.1,
                                    fontWeight: FontWeight.w800,
                                  ),
                                ),
                                const SizedBox(height: 22),
                                Text(
                                  _currentCountry.flag,
                                  style: const TextStyle(
                                    fontSize: 92,
                                    height: 1.1,
                                  ),
                                ),
                                const SizedBox(height: 22),
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 13,
                                    vertical: 7,
                                  ),
                                  decoration: BoxDecoration(
                                    color: paper,
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: Text(
                                    '${_answered + 1}ª rodada',
                                    style: const TextStyle(
                                      color: muted,
                                      fontSize: 12,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(height: 21),
                        const Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            'ESCOLHA UMA RESPOSTA',
                            style: TextStyle(
                              color: muted,
                              fontSize: 10,
                              letterSpacing: 1.1,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                        ),
                        const SizedBox(height: 11),
                        Expanded(
                          flex: 4,
                          child: Column(
                            children: [
                              for (var index = 0; index < 4; index++) ...[
                                Expanded(
                                  child: _AnswerButton(
                                    country: _currentOptions[index],
                                    selectedAnswer: _selectedAnswer,
                                    correctAnswer: _currentCountry.name,
                                    onTap: () =>
                                        _answer(_currentOptions[index]),
                                  ),
                                ),
                                if (index < 3) const SizedBox(height: 9),
                              ],
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 32,
                          child: _selectedAnswer == null
                              ? const SizedBox.shrink()
                              : Center(
                                  child: Text(
                                    _selectedAnswer == _currentCountry.name
                                        ? 'Isso aí! Resposta certa 🎉'
                                        : 'Quase! Era ${_currentCountry.name}',
                                    style: TextStyle(
                                      color:
                                          _selectedAnswer ==
                                              _currentCountry.name
                                          ? forest
                                          : const Color(0xFFB34F40),
                                      fontWeight: FontWeight.w700,
                                      fontSize: 13,
                                    ),
                                  ),
                                ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _AnswerButton extends StatelessWidget {
  const _AnswerButton({
    required this.country,
    required this.selectedAnswer,
    required this.correctAnswer,
    required this.onTap,
  });

  final Country country;
  final String? selectedAnswer;
  final String correctAnswer;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final isSelected = selectedAnswer == country.name;
    final showCorrect = selectedAnswer != null && country.name == correctAnswer;
    final isWrong = isSelected && !showCorrect;
    final color = showCorrect
        ? const Color(0xFFE0F0E4)
        : isWrong
        ? const Color(0xFFF9E5E1)
        : Colors.white;
    final border = showCorrect
        ? leaf
        : isWrong
        ? const Color(0xFFD66C5C)
        : const Color(0xFFE3E7E0);

    return SizedBox(
      width: double.infinity,
      child: OutlinedButton(
        onPressed: selectedAnswer == null ? onTap : null,
        style: OutlinedButton.styleFrom(
          backgroundColor: color,
          foregroundColor: ink,
          disabledForegroundColor: ink,
          side: BorderSide(
            color: border,
            width: showCorrect || isWrong ? 1.5 : 1,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 15),
        ),
        child: Row(
          children: [
            Expanded(
              child: Text(
                country.name,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            if (showCorrect)
              const Icon(Icons.check_circle_rounded, color: leaf, size: 19)
            else if (isWrong)
              const Icon(
                Icons.cancel_rounded,
                color: Color(0xFFD66C5C),
                size: 19,
              ),
          ],
        ),
      ),
    );
  }
}

