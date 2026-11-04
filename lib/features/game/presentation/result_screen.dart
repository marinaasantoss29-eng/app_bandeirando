import 'package:flutter/material.dart';

import '../../../core/theme/app_theme.dart';
class ResultScreen extends StatelessWidget {
  const ResultScreen({
    required this.answered,
    required this.correct,
    required this.modeLabel,
    required this.duration,
    super.key,
  });

  final int answered;
  final int correct;
  final String modeLabel;
  final int duration;

  @override
  Widget build(BuildContext context) {
    final accuracy = answered == 0 ? 0 : (correct * 100 / answered).round();
    final message = accuracy >= 80
        ? 'Você é um verdadeiro explorador! 🌍'
        : accuracy >= 50
        ? 'Mandou bem! Continue explorando ✨'
        : 'Cada rodada é uma nova descoberta 🌱';

    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24),
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 460),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 94,
                    height: 94,
                    decoration: BoxDecoration(
                      color: const Color(0xFFE2EFE5),
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: const Center(
                      child: Text('🏁', style: TextStyle(fontSize: 48)),
                    ),
                  ),
                  const SizedBox(height: 23),
                  const Text(
                    'FIM DE JOGO',
                    style: TextStyle(
                      color: leaf,
                      fontSize: 11,
                      fontWeight: FontWeight.w800,
                      letterSpacing: 2,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Que viagem!',
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    message,
                    textAlign: TextAlign.center,
                    style: const TextStyle(color: muted, fontSize: 14),
                  ),
                  const SizedBox(height: 24),
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(21),
                    decoration: BoxDecoration(
                      color: forest,
                      borderRadius: BorderRadius.circular(24),
                    ),
                    child: Column(
                      children: [
                        Text(
                          '$accuracy%',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 52,
                            fontWeight: FontWeight.w800,
                            letterSpacing: -2,
                          ),
                        ),
                        const Text(
                          'DE APROVEITAMENTO',
                          style: TextStyle(
                            color: Color(0xFFA8C9B6),
                            fontSize: 10,
                            fontWeight: FontWeight.w800,
                            letterSpacing: 1.5,
                          ),
                        ),
                        const SizedBox(height: 20),
                        const Divider(color: Color(0x44FFFFFF), height: 1),
                        const SizedBox(height: 16),
                        Row(
                          children: [
                            Expanded(
                              child: _ResultStat(
                                value: '$answered',
                                label: 'Respondidas',
                              ),
                            ),
                            Container(
                              width: 1,
                              height: 38,
                              color: const Color(0x44FFFFFF),
                            ),
                            Expanded(
                              child: _ResultStat(
                                value: '$correct',
                                label: 'Acertos',
                              ),
                            ),
                            Container(
                              width: 1,
                              height: 38,
                              color: const Color(0x44FFFFFF),
                            ),
                            Expanded(
                              child: _ResultStat(
                                value: modeLabel,
                                label: 'Modo',
                                compact: true,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 22),
                  SizedBox(
                    width: double.infinity,
                    height: 54,
                    child: FilledButton.icon(
                      onPressed: () => Navigator.of(context).pop(),
                      icon: const Icon(Icons.home_rounded),
                      label: const Text(
                        'VOLTAR AO INÍCIO',
                        style: TextStyle(
                          fontWeight: FontWeight.w800,
                          letterSpacing: 1,
                        ),
                      ),
                      style: FilledButton.styleFrom(
                        backgroundColor: forest,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    'Tempo de jogo: ${duration >= 60 ? '${duration ~/ 60} min' : '$duration s'}',
                    style: const TextStyle(color: muted, fontSize: 12),
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

class _ResultStat extends StatelessWidget {
  const _ResultStat({
    required this.value,
    required this.label,
    this.compact = false,
  });

  final String value;
  final String label;
  final bool compact;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          value,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
            color: Colors.white,
            fontSize: compact ? 15 : 21,
            fontWeight: FontWeight.w800,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: const TextStyle(color: Color(0xFFA8C9B6), fontSize: 11),
        ),
      ],
    );
  }
}

