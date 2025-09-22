class PopularMenuItem {
  final String name;
  final String calories;
  final double rating;
  
  final bool isRecommended;
  final bool isSpicy;
  final bool isNew;
  PopularMenuItem({
    required this.name,
    required this.calories,
    required this.rating,
    
    this.isRecommended = false,
    this.isSpicy = false,
    this.isNew = false,
  });
}