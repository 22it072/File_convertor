class ConversionType {
  final String from;
  final String to;
  final String title;
  final String icon;

  const ConversionType({
    required this.from,
    required this.to,
    required this.title,
    required this.icon,
  });
}

const List<ConversionType> conversionOptions = [
  ConversionType(
    from: 'pdf',
    to: 'jpg',
    title: 'PDF to JPG',
    icon: 'assets/images/pdf_to_jpg.png',
  ),
  ConversionType(
    from: 'jpg',
    to: 'png',
    title: 'JPG to PNG',
    icon: 'assets/images/jpg_to_png.png',
  ),
  ConversionType(
    from: 'png',
    to: 'jpg',
    title: 'PNG to JPG',
    icon: 'assets/images/png_to_jpg.png',
  ),
];