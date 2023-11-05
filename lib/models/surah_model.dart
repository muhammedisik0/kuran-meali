class Surah {
  final int number;
  final String name;
  final int startsFrom;
  final int ends;

  const Surah(
    this.number,
    this.name, {
    required this.startsFrom,
    required this.ends,
  });
}
