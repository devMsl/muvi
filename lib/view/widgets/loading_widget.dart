
import '../../utils/index.dart';

class LoadingWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: 55,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/muvi.png',
              width: 50,
              height: 30,
            ),
            const SizedBox(
              height: 20,
            ),
            const LinearProgressIndicator(
              backgroundColor: unselectedItemColor,
              minHeight: 3,
              color: selectedItemColor,
            ),
          ],
        ),
      ),
    );
  }
}
