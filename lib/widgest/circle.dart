import 'package:flutter/material.dart';

class Circle extends StatelessWidget {
  final double size;
  final List<Color> colors;

  const Circle({
    Key key,
    @required this.size,
    @required this.colors,
  })  : assert(size != null && size > 0),
        assert(colors != null && colors.length > 1),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: this.size,
      width: this.size,
      decoration: BoxDecoration(
        color: Colors.black38,
        shape: BoxShape.circle,
        gradient: LinearGradient(
          colors: this.colors,
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
    );
  }
}
