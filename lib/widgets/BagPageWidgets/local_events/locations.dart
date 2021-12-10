
class LocalEventsModel {
  final String name;
  final String urlImage;

  final String description;


  LocalEventsModel({
    this.name,
    this.urlImage,
  
    this.description,

  });
}


List<LocalEventsModel> localevents = [
  LocalEventsModel(
    name: 'DRAGON BOAT FESTIVAL',
    urlImage: 'assets/images/dragon.jpg',
    description:
        'The Dragon Boat Festival includes competitions for teams of men, women, and mixed rowers who race to the finish line using a dragon-inspired, 15-meter-long boat.',

  ),
  LocalEventsModel(
    name: 'ATIATIHAN FESTIVAL',
    urlImage: 'assets/images/atiatihan.jpg',
    description:
        'Boracay’s version of Aklan’s Ati-Atihan on the second Sunday of January wows foreigners with the motley-colored bodily decorations of the dancers grooving to lively music.',

  ),
  LocalEventsModel(
    name: 'NEW YEAR',
    urlImage: 'assets/images/newyear.jpeg',
    description:
        'Boracay entertains tourists in ushering in the New Year, just like a renowned tourist attraction must do. Colorful fireworks are set off in the last minutes of December 31 to welcome New Year.',
  
  ),
  LocalEventsModel(
    name: 'PARAW CUP',
    urlImage: 'assets/images/paraw.jpg',
    description:
        'Combining a cultural and sports event in one, the International Paraw Cup Challenge showcases locals’ skills in steering the native outrigger boats of the Philippines .',
  
  ),
];
