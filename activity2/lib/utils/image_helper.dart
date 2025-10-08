class ImageHelper {
  static String getPizzaImagePath(String pizzaName) {
    switch (pizzaName.toLowerCase()) {
      case 'margherita':
        return 'assets/images/margherita.png';
      case 'pepperoni':
        return 'assets/images/pepperoni.png';
      case 'bbq chicken':
        return 'assets/images/bbq_chicken.png';
      case 'veggie supreme':
        return 'assets/images/veggie_supreme.png';
      case 'spicy jalapeño':
        return 'assets/images/spicy_jalapeno.png';
      case 'hawaiian':
        return 'assets/images/hawaiian.png';
      case 'meat lovers':
        return 'assets/images/meat_lovers.png';
      case 'garden fresh':
        return 'assets/images/garden_fresh.png';
      default:
        return 'assets/images/margherita.png'; // Default fallback
    }
  }
}
