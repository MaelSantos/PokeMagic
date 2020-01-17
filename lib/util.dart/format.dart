String formatID(int i) {
  String linkImagens = "https://www.serebii.net/pokemongo/pokemon/";

  switch (i.toString().length) {
    case 1:
      linkImagens += "00$i.png";
      break;
    case 2:
      linkImagens += "0$i.png";
      break;
    case 3:
      linkImagens += "$i.png";
      break;
    // default:
    //   linkImagens += "$i.png";
  }
  return linkImagens;
}
