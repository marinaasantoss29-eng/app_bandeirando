import 'package:flutter/material.dart';

import '../../../core/theme/app_theme.dart';
import '../../flags/data/country.dart';
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
    return countries.where((country) {
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
                          color: ink,
                          fontSize: 28,
                          fontWeight: FontWeight.w800,
                          letterSpacing: -0.8,
                        ),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        'Encontre um país entre ${countries.length} bandeiras.',
                        style: const TextStyle(color: muted, fontSize: 14),
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
                          children: ['Todos', ...continents].map((continent) {
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
                                  color: selected ? forest : ink,
                                  fontWeight: FontWeight.w600,
                                ),
                                side: BorderSide(
                                  color: selected
                                      ? leaf
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
                      color: muted,
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
                              style: TextStyle(color: muted, fontSize: 15),
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
                                    color: ink,
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


