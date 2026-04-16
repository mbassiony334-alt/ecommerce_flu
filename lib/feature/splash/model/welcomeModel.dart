class Welcomemodel {
  final String tittle;
  final String description;
  final String img;

  Welcomemodel({
    required this.tittle,
    required this.description,
    required this.img,
  });
}

List<Welcomemodel> pages = [
  Welcomemodel(
    tittle: 'Welcome to Marketi',
    description:
        'Discover a world of endless possibilities and shop from the comfort of your fingertips Browse through a wide range of products, from fashion and electronics to home.',
    img: 'assets/images/Illustration_Onboarding_1.jpg',
  ),
  Welcomemodel(
    tittle: 'Easy to Buy',
    description:
        'Find the perfect item that suits your style and needs With secure payment options and fast delivery, shopping has never been easier.',
    img: 'assets/images/Illustration_Onboarding_2.jpg',
  ),
  Welcomemodel(
    tittle: 'Wonderful User Experience',
    description:
        'Start exploring now and experience the convenience of online shopping at its best. ',
    img: 'assets/images/Illustration_Onboarding_3.jpg',
  ),
];
