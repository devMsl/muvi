import '../../utils/index.dart';

class MovieInfoWidget extends StatelessWidget {
  final String title;
  final String? value;
  const MovieInfoWidget({required this.title, this.value, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const MySizedBox(
          height: 28,
        ),
        Text(title,
          style: Theme.of(context).textTheme.bodyText1!.copyWith(fontWeight: FontWeight.bold),
        ),
        const MySizedBox(
          height: 8,
        ),
        Text(value??'',
          style: Theme.of(context).textTheme.bodyText2,
        ),
      ],
    );
  }
}
