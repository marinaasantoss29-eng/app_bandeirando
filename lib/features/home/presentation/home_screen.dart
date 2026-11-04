import 'package:flutter/material.dart';

import '../../../core/theme/app_theme.dart';
import '../../flags/data/country.dart';
import '../../game/presentation/game_screen.dart';
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  GameMode _mode = GameMode.random;
  String _continent = 'América';
  int _duration = 60;

  void _startGame() {
    final pool = _mode == GameMode.random
        ? countries
        : countries
              .where((country) => country.continent == _continent)
              .toList();
    Navigator.of(context).push(
      MaterialPageRoute<void>(
        builder: (_) => GameScreen(
          countries: pool,
          duration: _duration,
          modeLabel: _mode == GameMode.random ? 'Aleatório' : _continent,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(22, 24, 22, 28),
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 560),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          color: forest,
                          borderRadius: BorderRadius.circular(13),
                        ),
                        child: const Icon(
                          Icons.public_rounded,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(width: 11),
                      const Text(
                        'BANDEIRANDO',
                        style: TextStyle(
                          color: forest,
                          fontSize: 13,
                          fontWeight: FontWeight.w800,
                          letterSpacing: 1.5,
                        ),
                      ),
                      const Spacer(),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 11,
                          vertical: 7,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(
                          '${countries.length} países',
                          style: const TextStyle(
                            color: muted,
                            fontWeight: FontWeight.w600,
                            fontSize: 12,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 34),
                  Text(
                    'Explore o mundo\nbandeira por bandeira.',
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'Um quiz rápido para testar seus conhecimentos.',
                    style: TextStyle(color: muted, fontSize: 15),
                  ),
                  const SizedBox(height: 27),
                  const _SectionHeading(number: '01', title: 'Modo de jogo'),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      Expanded(
                        child: _ModeCard(
                          selected: _mode == GameMode.random,
                          icon: Icons.shuffle_rounded,
                          title: 'Jogo aleatório',
                          subtitle: 'Todos os países',
                          onTap: () => setState(() => _mode = GameMode.random),
                        ),
                      ),
                      const SizedBox(width: 11),
                      Expanded(
                        child: _ModeCard(
                          selected: _mode == GameMode.continent,
                          icon: Icons.explore_rounded,
                          title: 'Por continente',
                          subtitle: 'Escolha uma região',
                          onTap: () =>
                              setState(() => _mode = GameMode.continent),
                        ),
                      ),
                    ],
                  ),
                  if (_mode == GameMode.continent) ...[
                    const SizedBox(height: 14),
                    Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: continents
                          .map(
                            (continent) => ChoiceChip(
                              label: Text(continent),
                              selected: _continent == continent,
                              onSelected: (_) =>
                                  setState(() => _continent = continent),
                              selectedColor: const Color(0xFFDCEBE0),
                              labelStyle: TextStyle(
                                color: _continent == continent ? forest : ink,
                                fontWeight: FontWeight.w600,
                              ),
                              side: BorderSide(
                                color: _continent == continent
                                    ? leaf
                                    : const Color(0xFFE0E4DD),
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                            ),
                          )
                          .toList(),
                    ),
                  ],
                  const SizedBox(height: 23),
                  const _SectionHeading(number: '02', title: 'Tempo de jogo'),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      _TimeChip(
                        label: '30 s',
                        selected: _duration == 30,
                        onTap: () => setState(() => _duration = 30),
                      ),
                      const SizedBox(width: 8),
                      _TimeChip(
                        label: '1 min',
                        selected: _duration == 60,
                        onTap: () => setState(() => _duration = 60),
                      ),
                      const SizedBox(width: 8),
                      _TimeChip(
                        label: '3 min',
                        selected: _duration == 180,
                        onTap: () => setState(() => _duration = 180),
                      ),
                      const SizedBox(width: 8),
                      _TimeChip(
                        label: '5 min',
                        selected: _duration == 300,
                        onTap: () => setState(() => _duration = 300),
                      ),
                    ],
                  ),
                  const SizedBox(height: 25),
                  SizedBox(
                    width: double.infinity,
                    height: 57,
                    child: FilledButton(
                      onPressed: _startGame,
                      style: FilledButton.styleFrom(
                        backgroundColor: forest,
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(17),
                        ),
                      ),
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'COMEÇAR JOGO',
                            style: TextStyle(
                              fontWeight: FontWeight.w800,
                              letterSpacing: 1.1,
                              fontSize: 14,
                            ),
                          ),
                          SizedBox(width: 9),
                          Icon(Icons.arrow_forward_rounded, size: 19),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 13),
                  const Center(
                    child: Text(
                      'Uma bandeira de cada vez.',
                      style: TextStyle(color: muted, fontSize: 12),
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
class _SectionHeading extends StatelessWidget {
  const _SectionHeading({required this.number, required this.title});

  final String number;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          number,
          style: const TextStyle(
            color: leaf,
            fontSize: 12,
            fontWeight: FontWeight.w800,
          ),
        ),
        const SizedBox(width: 9),
        Text(
          title,
          style: const TextStyle(
            color: ink,
            fontWeight: FontWeight.w700,
            fontSize: 15,
          ),
        ),
      ],
    );
  }
}

class _ModeCard extends StatelessWidget {
  const _ModeCard({
    required this.selected,
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.onTap,
  });

  final bool selected;
  final IconData icon;
  final String title;
  final String subtitle;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: selected ? const Color(0xFFE6EFE7) : Colors.white,
      borderRadius: BorderRadius.circular(18),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(18),
        child: Container(
          constraints: const BoxConstraints(minHeight: 104),
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(18),
            border: Border.all(
              color: selected ? leaf : const Color(0xFFE5E8E1),
              width: selected ? 1.5 : 1,
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(icon, color: selected ? forest : muted, size: 20),
              const SizedBox(height: 10),
              Text(
                title,
                style: const TextStyle(
                  color: ink,
                  fontSize: 13,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 3),
              Text(
                subtitle,
                style: const TextStyle(color: muted, fontSize: 11),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _TimeChip extends StatelessWidget {
  const _TimeChip({
    required this.label,
    required this.selected,
    required this.onTap,
  });

  final String label;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: OutlinedButton(
        onPressed: onTap,
        style: OutlinedButton.styleFrom(
          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 3),
          backgroundColor: selected ? const Color(0xFFE6EFE7) : Colors.white,
          foregroundColor: selected ? forest : ink,
          side: BorderSide(color: selected ? leaf : const Color(0xFFE0E4DD)),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(13),
          ),
        ),
        child: Text(
          label,
          style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 12),
        ),
      ),
    );
  }
}

