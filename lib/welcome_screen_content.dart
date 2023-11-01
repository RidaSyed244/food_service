
class UnbordingContent {
  String image;
  String title;
  String discription;

  UnbordingContent(
      {required this.image, required this.title, required this.discription});
}

List<UnbordingContent> WelcomeContents = [
 
  UnbordingContent(
      title: 'All your favorites',
      image: 'assets/images/secondImage.png',
      discription:
          "Order from the best local restraunts\n with easy, on-demand delivery. "),
  UnbordingContent(
      title: 'Free delivery offers',
      image: 'assets/images/illustrations.png'
      
      ,
      discription:
          "Frre delivery for new customers via Apple Pay\n and others payment methods"),
 UnbordingContent(
      title: 'Choose your food',
      image: 'assets/images/fourthImage.png',
      discription:
          "Easily find your type of food craving and you'll\n get delivery in wide range"),
];
