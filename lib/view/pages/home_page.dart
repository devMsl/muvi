import 'package:movie/view/pages/movie_list_page.dart';

import '../../utils/index.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final bodyOptions = [
    MovieListPage(),
    MovieListPage(),
    MovieListPage(),
  ];

  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: bodyOptions.elementAt(selectedIndex),
      bottomNavigationBar: BottomNavigationBar(
        onTap: onTapItem,
        currentIndex: selectedIndex,
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(icon: Icon(CupertinoIcons.house,), label: '',activeIcon: Icon(CupertinoIcons.house_fill) ),
          BottomNavigationBarItem(icon: Icon(CupertinoIcons.ticket),label: '', activeIcon: Icon(CupertinoIcons.ticket_fill)),
           BottomNavigationBarItem(icon: Icon(CupertinoIcons.person), label: '', activeIcon: Icon(CupertinoIcons.person_fill)),
        ],
      ),
    );
  }

  onTapItem(int index) {
    setState(() {
      selectedIndex = index;
    });
  }
}
