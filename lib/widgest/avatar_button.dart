import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_api_ret/utils/responsive.dart';

class AvatarButton extends StatelessWidget {
  const AvatarButton({
    Key key,
    @required this.responsive,
  }) : super(key: key);

  final Responsive responsive;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                blurRadius: 20,
                color: Colors.black12,
                offset: Offset(0, 20),
              ),
            ],
          ),
          child: ClipOval(
            child: Image.network(
              'https://images.vexels.com/media/users/3/129616/isolated/preview/fb517f8913bd99cd48ef00facb4a67c0-silueta-de-avatar-de-hombre-de-negocios-by-vexels.png',
              width: responsive.wp(30),
              height: responsive.wp(30),
            ),
          ),
        ),
        Positioned(
          right: 0,
          bottom: 0,
          child: Container(
            decoration: BoxDecoration(
              border: Border.all(
                color: Colors.white,
                width: responsive.dp(0.5),
              ),
              shape: BoxShape.circle,
            ),
            child: CupertinoButton(
              onPressed: () {},
              child: Icon(Icons.add_a_photo),
              borderRadius: BorderRadius.circular(
                responsive.dp(10),
              ),
              color: Colors.redAccent,
              padding: EdgeInsets.zero,
            ),
          ),
        ),
      ],
    );
  }
}
