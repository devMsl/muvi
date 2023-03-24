import '../../utils/index.dart';

class BackButtonWidget extends StatelessWidget {
  const BackButtonWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  InkWell(
      onTap: (){
        context.backed();
      },
      child: Container(
        margin: const EdgeInsets.only(left:6),
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.white,
        ),
        child: const Icon(CupertinoIcons.left_chevron, color: Colors.black,),
      ),
    );
  }
}
