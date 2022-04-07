class UnbordingContent {
  String image;
  String title;
  String discription;

  UnbordingContent(
      {required this.image, required this.title, required this.discription});
}

List<UnbordingContent> contents = [
  UnbordingContent(
      title: 'Ligação com o Cliente',
      image: 'lib/assets/images/mao.svg',
      discription:
          "O aplicativo foi feito par ajudar a pequenos agricultores a conseguir aumentar suas margens "
          "de lucro e facilitar na divulgação de seus produtos, conectando diretamente com o consumidor. "),
  UnbordingContent(
      title: 'Venda Mais',
      image: 'lib/assets/images/lucro.svg',
      discription:
          "Produtores poderão ver o que possíveis compradores estão à procura e usuários poderão "
          "encontrar produtos mais perto de casa. "),
  UnbordingContent(
      title: 'Encontre os Melhores Produtos',
      image: 'lib/assets/images/legumes.svg',
      discription:
          "O sistema de histórico preços proporciona uma forma de o usuário avaliar suas compra. "
          "Já a media de preço pode ajudar o produtor controlar seus preços, usando preços gerais. "),
];
