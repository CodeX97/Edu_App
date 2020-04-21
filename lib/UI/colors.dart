import 'dart:ui';

class AppColor {
  final Color color;
  final String name;

  const AppColor(this.color, this.name);

  static const List<AppColor> colors = const <AppColor>[
    const AppColor(const Color.fromRGBO(8, 72, 109, 0.7), 'Dark Blue'),
    const AppColor(const Color.fromRGBO(23, 102, 151, 1), 'Light Blue 1'),
    const AppColor(const Color.fromRGBO(210, 198, 1666, 1), 'Dark Vanilla'),
    const AppColor(const Color.fromRGBO(84, 153, 206, 1), 'Light Blue 2'),
    const AppColor(const Color.fromRGBO(27, 152, 224, 1), 'Light Grey'),
    const AppColor(const Color.fromRGBO(0, 97, 83, 1), 'Teal'),
    const AppColor(const Color.fromRGBO(0, 97, 83, 0.8), 'Teal 0.8'),
  ];
}
