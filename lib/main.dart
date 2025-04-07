import 'package:flutter/material.dart';

void main() {
  runApp(const MenuRestaurantApp());
}

class MenuRestaurantApp extends StatelessWidget {
  const MenuRestaurantApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Menu du Restaurant',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'Roboto',
        scaffoldBackgroundColor: const Color(0xFFF9F9F9),
        colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.deepOrange),
      ),
      home: const MenuScreen(),
    );
  }
}

class MenuScreen extends StatelessWidget {
  const MenuScreen({super.key});

  final List<String> categories = const ['Entrées', 'Plats', 'Desserts'];

  final Map<String, List<Meal>> meals = const {
    'Entrées': [
      Meal('Salade César', 'assets/salade.jpg', 6.5, 'Laitue, poulet, parmesan, croûtons.'),
      Meal('Soupe à l\'oignon', 'assets/soupe.jpg', 5.0, 'Servie gratinée avec du fromage.'),
      Meal('Salade César', 'assets/salade.jpg', 6.5, 'Laitue, poulet, parmesan, croûtons.'),
      Meal('Soupe à l\'oignon', 'assets/soupe.jpg', 5.0, 'Servie gratinée avec du fromage.'),
      Meal('Salade César', 'assets/salade.jpg', 6.5, 'Laitue, poulet, parmesan, croûtons.'),
      Meal('Soupe à l\'oignon', 'assets/soupe.jpg', 5.0, 'Servie gratinée avec du fromage.'),
    ],
    'Plats': [
      Meal('Burger maison', 'assets/burger.jpg', 12.0, 'Avec frites maison.'),
      Meal('Pâtes carbonara', 'assets/pates.jpg', 10.5, 'Crème, lardons, parmesan.'),
      Meal('Burger maison', 'assets/burger.jpg', 12.0, 'Avec frites maison.'),
      Meal('Pâtes carbonara', 'assets/pates.jpg', 10.5, 'Crème, lardons, parmesan.'),
      Meal('Burger maison', 'assets/burger.jpg', 12.0, 'Avec frites maison.'),
      Meal('Pâtes carbonara', 'assets/pates.jpg', 10.5, 'Crème, lardons, parmesan.'),
    ],
    'Desserts': [
      Meal('Tiramisu', 'assets/tiramisu.jpg', 5.5, 'Café, mascarpone, cacao.'),
      Meal('Fondant au chocolat', 'assets/fondant.jpg', 6.0, 'Cœur fondant au chocolat noir.'),
      Meal('Tiramisu', 'assets/tiramisu.jpg', 5.5, 'Café, mascarpone, cacao.'),
      Meal('Fondant au chocolat', 'assets/fondant.jpg', 6.0, 'Cœur fondant au chocolat noir.'),
      Meal('Tiramisu', 'assets/tiramisu.jpg', 5.5, 'Café, mascarpone, cacao.'),
      Meal('Fondant au chocolat', 'assets/fondant.jpg', 6.0, 'Cœur fondant au chocolat noir.'),
    ],
  };

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: categories.length,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Menu du Restaurant'),
          centerTitle: true,
          backgroundColor: Colors.white,
          elevation: 0,
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(60),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 10.0),
              child: TabBar(
                isScrollable: false,
                indicator: BoxDecoration(
                  color: Colors.deepOrange,
                  borderRadius: BorderRadius.circular(30),
                ),
                labelColor: Colors.white,
                unselectedLabelColor: Colors.black87,
                labelStyle: const TextStyle(fontWeight: FontWeight.w600, fontSize: 14),
                padding: const EdgeInsets.symmetric(horizontal: 8),
                indicatorPadding: const EdgeInsets.symmetric(horizontal: 6),
                tabs: categories.map((category) {
                  return Tab(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                      child: Text(category),
                    ),
                  );
                }).toList(),
              ),
            ),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12.0),
          child: TabBarView(
            children: categories.map((category) {
              final categoryMeals = meals[category]!;
              return ListView.builder(
                itemCount: categoryMeals.length,
                itemBuilder: (context, index) {
                  return MealCard(meal: categoryMeals[index]);
                },
              );
            }).toList(),
          ),
        ),
      ),
    );
  }
}

class Meal {
  final String name;
  final String imagePath;
  final double price;
  final String description;

  const Meal(this.name, this.imagePath, this.price, this.description);
}

class MealCard extends StatefulWidget {
  final Meal meal;

  const MealCard({super.key, required this.meal});

  @override
  State<MealCard> createState() => _MealCardState();
}

class _MealCardState extends State<MealCard> with SingleTickerProviderStateMixin {
  double _scale = 1.0;

  void _onTapDown(_) {
    setState(() => _scale = 0.97);
  }

  void _onTapUp(_) {
    setState(() => _scale = 1.0);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Tu peux afficher une popup ou autre ici
      },
      onTapDown: _onTapDown,
      onTapUp: _onTapUp,
      onTapCancel: () => setState(() => _scale = 1.0),
      child: AnimatedScale(
        scale: _scale,
        duration: const Duration(milliseconds: 100),
        child: Card(
          margin: const EdgeInsets.symmetric(vertical: 12),
          elevation: 5,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          child: Padding(
            padding: const EdgeInsets.all(14),
            child: Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image.asset(
                    widget.meal.imagePath,
                    width: 90,
                    height: 90,
                    fit: BoxFit.cover,
                  ),
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.meal.name,
                        style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        widget.meal.description,
                        style: const TextStyle(color: Colors.black54, fontSize: 14),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        '${widget.meal.price.toStringAsFixed(2)} €',
                        style: const TextStyle(
                          fontSize: 16,
                          color: Colors.deepOrange,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
