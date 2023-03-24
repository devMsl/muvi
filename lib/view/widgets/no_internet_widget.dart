
import '../../utils/index.dart';

class NoConnectionWidget extends StatelessWidget {
  Function? function;

  NoConnectionWidget({this.function,Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            'assets/no_connection.png',
            width: 70,
            height: 70,
            color: selectedItemColor,
          ),
          const SizedBox(
            height: 20,
          ),
          Text(
            "Please check your connection!",
            style: Theme.of(context).textTheme.bodyText1,
          ),
          const SizedBox(
            height: 30,
          ),
          SizedBox(
            height: 40,
            width: 130,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: selectedItemColor
              ),
              onPressed: () {
                function!();
              },
              child: Text(
                "Try Again",
                style: Theme.of(context).textTheme.bodyText1,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
