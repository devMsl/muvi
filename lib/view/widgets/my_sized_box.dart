import 'package:flutter/cupertino.dart';

class MySizedBox extends StatelessWidget { //for spacing
  final double? width;
  final double? height;
  const MySizedBox({Key? key, this.width, this.height}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  SizedBox(
      width: width,
      height: height,
    );
  }
}
