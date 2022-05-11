import 'package:localization/localization.dart';

class UnbordingContent {
  String image;
  String title;
  String discription;

  UnbordingContent(
      {required this.image, required this.title, required this.discription});
}

List<UnbordingContent> contents = [
  UnbordingContent(
      title: 'onboard_first_page_theme'.i18n(),
      image: 'lib/assets/images/mao.svg',
      discription: 'onboard_first_page_phrase'.i18n()),
  UnbordingContent(
      title: 'onboard_second_page_theme'.i18n(),
      image: 'lib/assets/images/lucro.svg',
      discription: 'onboard_second_page_phrase'.i18n()),
  UnbordingContent(
      title: 'onboard_third_page_theme'.i18n(),
      image: 'lib/assets/images/legumes.svg',
      discription: 'onboard_third_page_phrase'.i18n()),
];
