import '../models/pizza.dart';

class PizzaService {
  const PizzaService();

  List<Pizza> getFeaturedPizzas() {
    return const [
      Pizza(
        id: 'marg',
        name: 'Margherita',
        description: 'Tomato, mozzarella, basil',
        price: 189.00,
        imageUrl: 'icon:pizza',
      ),
      Pizza(
        id: 'pep',
        name: 'Pepperoni',
        description: 'Classic pepperoni & cheese',
        price: 229.00,
        imageUrl: 'icon:pizza',
      ),
      Pizza(
        id: 'veg',
        name: 'Veggie',
        description: 'Peppers, olives, onion, mushrooms',
        price: 209.00,
        imageUrl: 'icon:pizza',
      ),
      Pizza(
        id: 'bbq',
        name: 'BBQ Chicken',
        description: 'BBQ sauce, chicken, red onion',
        price: 249.00,
        imageUrl: 'icon:pizza',
      ),
    ];
  }
}
