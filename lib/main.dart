import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';

void main() {
  runApp(const FlagGameApp());
}

const _forest = Color(0xFF174B3A);
const _leaf = Color(0xFF2F7658);
const _ink = Color(0xFF202A24);
const _muted = Color(0xFF778078);
const _paper = Color(0xFFF5F6F0);

class FlagGameApp extends StatelessWidget {
  const FlagGameApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Bandeirando',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        scaffoldBackgroundColor: _paper,
        colorScheme: ColorScheme.fromSeed(
          seedColor: _forest,
          primary: _forest,
          surface: _paper,
        ),
        textTheme: const TextTheme(
          headlineMedium: TextStyle(
            color: _ink,
            fontSize: 32,
            fontWeight: FontWeight.w800,
            height: 1.08,
            letterSpacing: -1,
          ),
          titleLarge: TextStyle(
            color: _ink,
            fontSize: 20,
            fontWeight: FontWeight.w700,
          ),
          bodyMedium: TextStyle(color: _muted, fontSize: 14),
        ),
      ),
      home: const _AppShell(),
    );
  }
}

enum GameMode { random, continent }

class Country {
  const Country(this.name, this.flag, this.continent);

  final String name;
  final String flag;
  final String continent;
}

const _continents = ['África', 'América', 'Ásia', 'Europa', 'Oceania'];

const _countries = <Country>[
  Country('África do Sul', '🇿🇦', 'África'),
  Country('Argélia', '🇩🇿', 'África'),
  Country('Angola', '🇦🇴', 'África'),
  Country('Benin', '🇧🇯', 'África'),
  Country('Botsuana', '🇧🇼', 'África'),
  Country('Burkina Faso', '🇧🇫', 'África'),
  Country('Burundi', '🇧🇮', 'África'),
  Country('Cabo Verde', '🇨🇻', 'África'),
  Country('Camarões', '🇨🇲', 'África'),
  Country('Chade', '🇹🇩', 'África'),
  Country('Comores', '🇰🇲', 'África'),
  Country('Congo', '🇨🇬', 'África'),
  Country('Costa do Marfim', '🇨🇮', 'África'),
  Country('Djibuti', '🇩🇯', 'África'),
  Country('Egito', '🇪🇬', 'África'),
  Country('Eritreia', '🇪🇷', 'África'),
  Country('Essuatíni', '🇸🇿', 'África'),
  Country('Etiópia', '🇪🇹', 'África'),
  Country('Gabão', '🇬🇦', 'África'),
  Country('Gâmbia', '🇬🇲', 'África'),
  Country('Gana', '🇬🇭', 'África'),
  Country('Guiné', '🇬🇳', 'África'),
  Country('Guiné-Bissau', '🇬🇼', 'África'),
  Country('Guiné Equatorial', '🇬🇶', 'África'),
  Country('Quênia', '🇰🇪', 'África'),
  Country('Lesoto', '🇱🇸', 'África'),
  Country('Libéria', '🇱🇷', 'África'),
  Country('Líbia', '🇱🇾', 'África'),
  Country('Madagascar', '🇲🇬', 'África'),
  Country('Malaui', '🇲🇼', 'África'),
  Country('Mali', '🇲🇱', 'África'),
  Country('Marrocos', '🇲🇦', 'África'),
  Country('Maurício', '🇲🇺', 'África'),
  Country('Mauritânia', '🇲🇷', 'África'),
  Country('Moçambique', '🇲🇿', 'África'),
  Country('Namíbia', '🇳🇦', 'África'),
  Country('Níger', '🇳🇪', 'África'),
  Country('Nigéria', '🇳🇬', 'África'),
  Country('República Centro-Africana', '🇨🇫', 'África'),
  Country('República Democrática do Congo', '🇨🇩', 'África'),
  Country('Ruanda', '🇷🇼', 'África'),
  Country('São Tomé e Príncipe', '🇸🇹', 'África'),
  Country('Seicheles', '🇸🇨', 'África'),
  Country('Senegal', '🇸🇳', 'África'),
  Country('Serra Leoa', '🇸🇱', 'África'),
  Country('Somália', '🇸🇴', 'África'),
  Country('Sudão', '🇸🇩', 'África'),
  Country('Sudão do Sul', '🇸🇸', 'África'),
  Country('Tanzânia', '🇹🇿', 'África'),
  Country('Togo', '🇹🇬', 'África'),
  Country('Tunísia', '🇹🇳', 'África'),
  Country('Uganda', '🇺🇬', 'África'),
  Country('Zâmbia', '🇿🇲', 'África'),
  Country('Zimbábue', '🇿🇼', 'África'),
  Country('Antígua e Barbuda', '🇦🇬', 'América'),
  Country('Argentina', '🇦🇷', 'América'),
  Country('Bahamas', '🇧🇸', 'América'),
  Country('Barbados', '🇧🇧', 'América'),
  Country('Belize', '🇧🇿', 'América'),
  Country('Bolívia', '🇧🇴', 'América'),
  Country('Brasil', '🇧🇷', 'América'),
  Country('Canadá', '🇨🇦', 'América'),
  Country('Chile', '🇨🇱', 'América'),
  Country('Colômbia', '🇨🇴', 'América'),
  Country('Costa Rica', '🇨🇷', 'América'),
  Country('Cuba', '🇨🇺', 'América'),
  Country('Dominica', '🇩🇲', 'América'),
  Country('El Salvador', '🇸🇻', 'América'),
  Country('Equador', '🇪🇨', 'América'),
  Country('Estados Unidos', '🇺🇸', 'América'),
  Country('Granada', '🇬🇩', 'América'),
  Country('Guatemala', '🇬🇹', 'América'),
  Country('Guiana', '🇬🇾', 'América'),
  Country('Haiti', '🇭🇹', 'América'),
  Country('Honduras', '🇭🇳', 'América'),
  Country('Jamaica', '🇯🇲', 'América'),
  Country('México', '🇲🇽', 'América'),
  Country('Nicarágua', '🇳🇮', 'América'),
  Country('Panamá', '🇵🇦', 'América'),
  Country('Paraguai', '🇵🇾', 'América'),
  Country('Peru', '🇵🇪', 'América'),
  Country('República Dominicana', '🇩🇴', 'América'),
  Country('Santa Lúcia', '🇱🇨', 'América'),
  Country('São Cristóvão e Neves', '🇰🇳', 'América'),
  Country('São Vicente e Granadinas', '🇻🇨', 'América'),
  Country('Suriname', '🇸🇷', 'América'),
  Country('Trinidad e Tobago', '🇹🇹', 'América'),
  Country('Uruguai', '🇺🇾', 'América'),
  Country('Venezuela', '🇻🇪', 'América'),
  Country('Afeganistão', '🇦🇫', 'Ásia'),
  Country('Arábia Saudita', '🇸🇦', 'Ásia'),
  Country('Armênia', '🇦🇲', 'Ásia'),
  Country('Azerbaijão', '🇦🇿', 'Ásia'),
  Country('Bahrein', '🇧🇭', 'Ásia'),
  Country('Bangladesh', '🇧🇩', 'Ásia'),
  Country('Butão', '🇧🇹', 'Ásia'),
  Country('Brunei', '🇧🇳', 'Ásia'),
  Country('Camboja', '🇰🇭', 'Ásia'),
  Country('Cazaquistão', '🇰🇿', 'Ásia'),
  Country('China', '🇨🇳', 'Ásia'),
  Country('Chipre', '🇨🇾', 'Ásia'),
  Country('Coreia do Norte', '🇰🇵', 'Ásia'),
  Country('Coreia do Sul', '🇰🇷', 'Ásia'),
  Country('Emirados Árabes Unidos', '🇦🇪', 'Ásia'),
  Country('Filipinas', '🇵🇭', 'Ásia'),
  Country('Geórgia', '🇬🇪', 'Ásia'),
  Country('Índia', '🇮🇳', 'Ásia'),
  Country('Indonésia', '🇮🇩', 'Ásia'),
  Country('Iêmen', '🇾🇪', 'Ásia'),
  Country('Irã', '🇮🇷', 'Ásia'),
  Country('Iraque', '🇮🇶', 'Ásia'),
  Country('Israel', '🇮🇱', 'Ásia'),
  Country('Japão', '🇯🇵', 'Ásia'),
  Country('Jordânia', '🇯🇴', 'Ásia'),
  Country('Kuwait', '🇰🇼', 'Ásia'),
  Country('Laos', '🇱🇦', 'Ásia'),
  Country('Líbano', '🇱🇧', 'Ásia'),
  Country('Malásia', '🇲🇾', 'Ásia'),
  Country('Maldivas', '🇲🇻', 'Ásia'),
  Country('Mongólia', '🇲🇳', 'Ásia'),
  Country('Myanmar', '🇲🇲', 'Ásia'),
  Country('Nepal', '🇳🇵', 'Ásia'),
  Country('Omã', '🇴🇲', 'Ásia'),
  Country('Paquistão', '🇵🇰', 'Ásia'),
  Country('Palestina', '🇵🇸', 'Ásia'),
  Country('Qatar', '🇶🇦', 'Ásia'),
  Country('Quirguistão', '🇰🇬', 'Ásia'),
  Country('Singapura', '🇸🇬', 'Ásia'),
  Country('Sri Lanka', '🇱🇰', 'Ásia'),
  Country('Síria', '🇸🇾', 'Ásia'),
  Country('Tajiquistão', '🇹🇯', 'Ásia'),
  Country('Tailândia', '🇹🇭', 'Ásia'),
  Country('Timor-Leste', '🇹🇱', 'Ásia'),
  Country('Turcomenistão', '🇹🇲', 'Ásia'),
  Country('Turquia', '🇹🇷', 'Ásia'),
  Country('Uzbequistão', '🇺🇿', 'Ásia'),
  Country('Vietnã', '🇻🇳', 'Ásia'),
  Country('Albânia', '🇦🇱', 'Europa'),
  Country('Alemanha', '🇩🇪', 'Europa'),
  Country('Áustria', '🇦🇹', 'Europa'),
  Country('Bélgica', '🇧🇪', 'Europa'),
  Country('Bielorrússia', '🇧🇾', 'Europa'),
  Country('Bósnia e Herzegovina', '🇧🇦', 'Europa'),
  Country('Bulgária', '🇧🇬', 'Europa'),
  Country('Croácia', '🇭🇷', 'Europa'),
  Country('Dinamarca', '🇩🇰', 'Europa'),
  Country('Eslováquia', '🇸🇰', 'Europa'),
  Country('Eslovênia', '🇸🇮', 'Europa'),
  Country('Estônia', '🇪🇪', 'Europa'),
  Country('Espanha', '🇪🇸', 'Europa'),
  Country('Finlândia', '🇫🇮', 'Europa'),
  Country('França', '🇫🇷', 'Europa'),
  Country('Grécia', '🇬🇷', 'Europa'),
  Country('Hungria', '🇭🇺', 'Europa'),
  Country('Islândia', '🇮🇸', 'Europa'),
  Country('Irlanda', '🇮🇪', 'Europa'),
  Country('Itália', '🇮🇹', 'Europa'),
  Country('Letônia', '🇱🇻', 'Europa'),
  Country('Lituânia', '🇱🇹', 'Europa'),
  Country('Luxemburgo', '🇱🇺', 'Europa'),
  Country('Macedônia do Norte', '🇲🇰', 'Europa'),
  Country('Malta', '🇲🇹', 'Europa'),
  Country('Moldávia', '🇲🇩', 'Europa'),
  Country('Montenegro', '🇲🇪', 'Europa'),
  Country('Países Baixos', '🇳🇱', 'Europa'),
  Country('Noruega', '🇳🇴', 'Europa'),
  Country('Polônia', '🇵🇱', 'Europa'),
  Country('Portugal', '🇵🇹', 'Europa'),
  Country('Reino Unido', '🇬🇧', 'Europa'),
  Country('República Tcheca', '🇨🇿', 'Europa'),
  Country('Romênia', '🇷🇴', 'Europa'),
  Country('Rússia', '🇷🇺', 'Europa'),
  Country('Sérvia', '🇷🇸', 'Europa'),
  Country('Suécia', '🇸🇪', 'Europa'),
  Country('Suíça', '🇨🇭', 'Europa'),
  Country('Ucrânia', '🇺🇦', 'Europa'),
  Country('Austrália', '🇦🇺', 'Oceania'),
  Country('Fiji', '🇫🇯', 'Oceania'),
  Country('Ilhas Salomão', '🇸🇧', 'Oceania'),
  Country('Ilhas Marshall', '🇲🇭', 'Oceania'),
  Country('Kiribati', '🇰🇮', 'Oceania'),
  Country('Micronésia', '🇫🇲', 'Oceania'),
  Country('Nauru', '🇳🇷', 'Oceania'),
  Country('Nova Zelândia', '🇳🇿', 'Oceania'),
  Country('Palau', '🇵🇼', 'Oceania'),
  Country('Papua-Nova Guiné', '🇵🇬', 'Oceania'),
  Country('Samoa', '🇼🇸', 'Oceania'),
  Country('Tonga', '🇹🇴', 'Oceania'),
  Country('Tuvalu', '🇹🇻', 'Oceania'),
  Country('Vanuatu', '🇻🇺', 'Oceania'),
];

class _AppShell extends StatefulWidget {
  const _AppShell();

  @override
  State<_AppShell> createState() => _AppShellState();
}

class _AppShellState extends State<_AppShell> {
  int _selectedTab = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _selectedTab,
        children: const [HomeScreen(), FlagSearchScreen()],
      ),
      bottomNavigationBar: NavigationBar(
        selectedIndex: _selectedTab,
        onDestinationSelected: (index) => setState(() => _selectedTab = index),
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.sports_esports_outlined),
            selectedIcon: Icon(Icons.sports_esports_rounded),
            label: 'Jogar',
          ),
          NavigationDestination(
            icon: Icon(Icons.search_rounded),
            label: 'Buscar',
          ),
        ],
      ),
    );
  }
}

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
        ? _countries
        : _countries
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
                          color: _forest,
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
                          color: _forest,
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
                          '${_countries.length} países',
                          style: const TextStyle(
                            color: _muted,
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
                    style: TextStyle(color: _muted, fontSize: 15),
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
                      children: _continents
                          .map(
                            (continent) => ChoiceChip(
                              label: Text(continent),
                              selected: _continent == continent,
                              onSelected: (_) =>
                                  setState(() => _continent = continent),
                              selectedColor: const Color(0xFFDCEBE0),
                              labelStyle: TextStyle(
                                color: _continent == continent ? _forest : _ink,
                                fontWeight: FontWeight.w600,
                              ),
                              side: BorderSide(
                                color: _continent == continent
                                    ? _leaf
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
                        backgroundColor: _forest,
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
                      style: TextStyle(color: _muted, fontSize: 12),
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

class FlagSearchScreen extends StatefulWidget {
  const FlagSearchScreen({super.key});

  @override
  State<FlagSearchScreen> createState() => _FlagSearchScreenState();
}

class _FlagSearchScreenState extends State<FlagSearchScreen> {
  final TextEditingController _searchController = TextEditingController();
  String _query = '';
  String _continent = 'Todos';

  List<Country> get _results {
    final query = _normalizeSearch(_query.trim());
    return _countries.where((country) {
      final matchesQuery =
          query.isEmpty || _normalizeSearch(country.name).contains(query);
      final matchesContinent =
          _continent == 'Todos' || country.continent == _continent;
      return matchesQuery && matchesContinent;
    }).toList();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final results = _results;
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 560),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(22, 26, 22, 18),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Explorar bandeiras',
                        style: TextStyle(
                          color: _ink,
                          fontSize: 28,
                          fontWeight: FontWeight.w800,
                          letterSpacing: -0.8,
                        ),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        'Encontre um país entre ${_countries.length} bandeiras.',
                        style: const TextStyle(color: _muted, fontSize: 14),
                      ),
                      const SizedBox(height: 18),
                      TextField(
                        controller: _searchController,
                        onChanged: (value) => setState(() => _query = value),
                        decoration: InputDecoration(
                          hintText: 'Buscar país',
                          prefixIcon: const Icon(Icons.search_rounded),
                          suffixIcon: _query.isEmpty
                              ? null
                              : IconButton(
                                  tooltip: 'Limpar busca',
                                  onPressed: () {
                                    _searchController.clear();
                                    setState(() => _query = '');
                                  },
                                  icon: const Icon(Icons.close_rounded),
                                ),
                          filled: true,
                          fillColor: Colors.white,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(16),
                            borderSide: BorderSide.none,
                          ),
                        ),
                      ),
                      const SizedBox(height: 14),
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: ['Todos', ..._continents].map((continent) {
                            final selected = _continent == continent;
                            return Padding(
                              padding: const EdgeInsets.only(right: 8),
                              child: ChoiceChip(
                                label: Text(continent),
                                selected: selected,
                                onSelected: (_) =>
                                    setState(() => _continent = continent),
                                selectedColor: const Color(0xFFDCEBE0),
                                labelStyle: TextStyle(
                                  color: selected ? _forest : _ink,
                                  fontWeight: FontWeight.w600,
                                ),
                                side: BorderSide(
                                  color: selected
                                      ? _leaf
                                      : const Color(0xFFE0E4DD),
                                ),
                              ),
                            );
                          }).toList(),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(22, 0, 22, 10),
                  child: Text(
                    '${results.length} ${results.length == 1 ? 'país encontrado' : 'países encontrados'}',
                    style: const TextStyle(
                      color: _muted,
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                Expanded(
                  child: results.isEmpty
                      ? const Center(
                          child: Padding(
                            padding: EdgeInsets.all(24),
                            child: Text(
                              'Nenhum país encontrado. Tente outra busca.',
                              textAlign: TextAlign.center,
                              style: TextStyle(color: _muted, fontSize: 15),
                            ),
                          ),
                        )
                      : ListView.separated(
                          padding: const EdgeInsets.fromLTRB(22, 0, 22, 16),
                          itemCount: results.length,
                          separatorBuilder: (_, _) => const SizedBox(height: 8),
                          itemBuilder: (context, index) {
                            final country = results[index];
                            return Container(
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(16),
                              ),
                              child: ListTile(
                                contentPadding: const EdgeInsets.symmetric(
                                  horizontal: 16,
                                  vertical: 4,
                                ),
                                leading: Text(
                                  country.flag,
                                  style: const TextStyle(fontSize: 32),
                                ),
                                title: Text(
                                  country.name,
                                  style: const TextStyle(
                                    color: _ink,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                                subtitle: Text(country.continent),
                              ),
                            );
                          },
                        ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

String _normalizeSearch(String value) {
  return value
      .toLowerCase()
      .replaceAll(RegExp('[áàâãä]'), 'a')
      .replaceAll(RegExp('[éèêë]'), 'e')
      .replaceAll(RegExp('[íìîï]'), 'i')
      .replaceAll(RegExp('[óòôõö]'), 'o')
      .replaceAll(RegExp('[úùûü]'), 'u')
      .replaceAll('ç', 'c');
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
            color: _leaf,
            fontSize: 12,
            fontWeight: FontWeight.w800,
          ),
        ),
        const SizedBox(width: 9),
        Text(
          title,
          style: const TextStyle(
            color: _ink,
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
              color: selected ? _leaf : const Color(0xFFE5E8E1),
              width: selected ? 1.5 : 1,
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(icon, color: selected ? _forest : _muted, size: 20),
              const SizedBox(height: 10),
              Text(
                title,
                style: const TextStyle(
                  color: _ink,
                  fontSize: 13,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 3),
              Text(
                subtitle,
                style: const TextStyle(color: _muted, fontSize: 11),
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
          foregroundColor: selected ? _forest : _ink,
          side: BorderSide(color: selected ? _leaf : const Color(0xFFE0E4DD)),
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
                          foregroundColor: _ink,
                        ),
                      ),
                      const Spacer(),
                      Text(
                        widget.modeLabel.toUpperCase(),
                        style: const TextStyle(
                          color: _muted,
                          fontWeight: FontWeight.w800,
                          fontSize: 11,
                          letterSpacing: 1.2,
                        ),
                      ),
                      const Spacer(),
                      const Icon(
                        Icons.check_circle_outline,
                        color: _leaf,
                        size: 19,
                      ),
                      const SizedBox(width: 5),
                      Text(
                        '$_correct',
                        style: const TextStyle(
                          color: _forest,
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
                          color: _muted,
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
                                : _forest,
                          ),
                          const SizedBox(width: 5),
                          Text(
                            _formattedTime,
                            style: TextStyle(
                              color: _remainingSeconds <= 10
                                  ? const Color(0xFFCC5948)
                                  : _forest,
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
                          : _leaf,
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
                                    color: _muted,
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
                                    color: _paper,
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: Text(
                                    '${_answered + 1}ª rodada',
                                    style: const TextStyle(
                                      color: _muted,
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
                              color: _muted,
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
                                          ? _forest
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
        ? _leaf
        : isWrong
        ? const Color(0xFFD66C5C)
        : const Color(0xFFE3E7E0);

    return SizedBox(
      width: double.infinity,
      child: OutlinedButton(
        onPressed: selectedAnswer == null ? onTap : null,
        style: OutlinedButton.styleFrom(
          backgroundColor: color,
          foregroundColor: _ink,
          disabledForegroundColor: _ink,
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
              const Icon(Icons.check_circle_rounded, color: _leaf, size: 19)
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
                      color: _leaf,
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
                    style: const TextStyle(color: _muted, fontSize: 14),
                  ),
                  const SizedBox(height: 24),
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(21),
                    decoration: BoxDecoration(
                      color: _forest,
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
                        backgroundColor: _forest,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    'Tempo de jogo: ${duration >= 60 ? '${duration ~/ 60} min' : '$duration s'}',
                    style: const TextStyle(color: _muted, fontSize: 12),
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
