
class Location {
  final String name;
  final String urlImage;
  final String latitude;
  final String longitude;
  final String addressLine1;
  final String addressLine2;

  Location({
    this.name,
    this.urlImage,
    this.latitude,
    this.longitude,
    this.addressLine1,
    this.addressLine2,
  });
}


List<Location> locations = [
  Location(
    name: 'DRAGON BOAT FESTIVAL',
    urlImage: 'assets/images/dragon.jpg',
    addressLine1:
        'The Dragon Boat Festival includes competitions for teams of men, women, and mixed rowers who race to the finish line using a dragon-inspired, 15-meter-long boat.',
    addressLine2: 'SPORTING EVENTS',
    latitude: 'BORACAY',
    longitude: 'EVENTS',
  ),
  Location(
    name: 'ATIATIHAN FESTIVAL',
    urlImage: 'assets/images/atiatihan.jpg',
    addressLine1:
        'Boracay’s version of Aklan’s Ati-Atihan on the second Sunday of January wows foreigners with the motley-colored bodily decorations of the dancers grooving to lively music.',
    addressLine2: 'CULTURAL EVENTS',
    latitude: 'BORACAY',
    longitude: 'EVENTS',
  ),
  Location(
    name: 'NEW YEAR',
    urlImage: 'assets/images/newyear.jpeg',
    addressLine1:
        'Boracay entertains tourists in ushering in the New Year, just like a renowned tourist attraction must do. Colorful fireworks are set off in the last minutes of December 31 to welcome New Year.',
    addressLine2: 'CULTURAL EVENTS',
    latitude: 'BORACAY',
    longitude: 'EVENTS',
  ),
  Location(
    name: 'PARAW CUP',
    urlImage: 'assets/images/paraw.jpg',
    addressLine1:
        'Combining a cultural and sports event in one, the International Paraw Cup Challenge showcases locals’ skills in steering the native outrigger boats of the Philippines .',
    addressLine2: 'SPORTING EVENTS',
    latitude: 'BORACAY',
    longitude: 'EVENTS',
  ),
];
