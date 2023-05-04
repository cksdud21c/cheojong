class Category {
  final String icon, title;

  Category({required this.icon, required this.title});
}

//카테고리별로 기입.
List<Category> demo_categories = [
  Category(
    icon: "assets/icons/dress.svg",
    title: "Dress",
  ),
  Category(
    icon: "assets/icons/shirt.svg",
    title: "Shirt",
  ),
  Category(
    icon: "assets/icons/pants.svg",
    title: "Pants",
  ),
  Category(
    icon: "assets/icons/Tshirt.svg",
    title: "Tshirt",
  ),
];
