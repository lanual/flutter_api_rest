import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class IconContainer extends StatelessWidget {
  final double size;

  const IconContainer({
    Key key,
    @required this.size,
  })  : assert(size != null && size > 0),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: this.size,
      width: this.size,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(this.size * 0.2),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: this.size * 0.2,
            spreadRadius: size * 0.1,
            offset: Offset(0, size * 0.1),
          ),
        ],
      ),
      child: Center(
        child: SvgPicture.asset(
          'assets/icons/hi.svg',
          height: this.size * 0.7,
          width: this.size * 0.7,
        ),
      ),
    );
  }
}
