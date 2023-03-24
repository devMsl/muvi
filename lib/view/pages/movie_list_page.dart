import 'package:movie/view/pages/movie_detail_page.dart';
import 'package:movie/models/movie_ob.dart';

import '../../models/response_ob.dart';
import '../../utils/index.dart';

class MovieListPage extends StatefulWidget {
  const MovieListPage({Key? key}) : super(key: key);

  @override
  State<MovieListPage> createState() => _MovieListPageState();
}

class _MovieListPageState extends State<MovieListPage> {

  List<MovieOb>? movieListOb;
  bool isError = false;
  late MovieBloc _bloc;
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _bloc = MovieBloc(getList, ObType.list);
    _bloc.getMovieData();
    _bloc.movieStream().listen((event) {
      if (event.responseState == ResponseState.data) {
        movieListOb = event.data;
        isError = false;
        setState(() {});
      }
      if(event.responseState == ResponseState.error){
        isError = true;
        _bloc.getMovieData();
        setState(() {});
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(centerTitle: false,
        title: Image.asset('assets/muvi.png'),
        actions: [
          IconButton(onPressed: (){}, icon: const Icon(CupertinoIcons.bell)),
          IconButton(onPressed: (){}, icon: const Icon(CupertinoIcons.settings_solid)),
        ],
        bottom: PreferredSize(
          preferredSize: const Size(double.infinity, 78),
          child: Container(
            padding: const EdgeInsets.fromLTRB(20, 8, 20, 20),
            child: TextFormField(
              controller: _searchController,
              decoration: InputDecoration(
                prefixIcon: const Icon(CupertinoIcons.search, color: searchIconTextColor),
                hintText: 'Search',
                hintStyle: const TextStyle( color: searchIconTextColor),
                fillColor: const Color(0xff1F2937),
                filled: true,
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(20))
              ),
            ),
          ),
        ),
      ),
      body: isError ? NoConnectionWidget(function: (){
        _bloc.getMovieData();
      },):movieListOb != null ? GridView.count(
        padding: const EdgeInsets.all(20),
        crossAxisCount: 2,
        shrinkWrap: true,
        childAspectRatio: context.width / (context.height / 0.77),
        crossAxisSpacing: 22,
        mainAxisSpacing: 20,
        children: movieListOb!.map((e) {
          return InkWell(
            onTap: (){
              context.pushed(MovieDetailPage(e.uniqueID??''));
            },
            child: SizedBox(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: CachedNetworkImage(
                        height: context.height /3,
                        fit: BoxFit.cover,
                        maxHeightDiskCache: 600,
                        maxWidthDiskCache: 400,
                        imageUrl: e.imageUrls?.first ??'',
                        errorWidget: (context, string, _) {
                          return Container(
                            color: Colors.grey,
                          );
                        },
                        placeholder: (context, string) {
                          return Container(
                            color: Colors.grey,
                          );
                        }),
                  ),
                  const SizedBox(height: 10,),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: List.generate(5, (index) {
                      return const Icon(
                         Icons.star,
                        color: Colors.yellow,
                        size: 17,
                      );
                    }),
                  ),
                  if(e.title != null)
                  Text(e.title!,
                  style: Theme.of(context).textTheme.headline2,
                    textAlign: TextAlign.left,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 5,),

                  Row(
                    children: [
                      if(e.type != null && e.type != '-')
                        Flexible(
                          child: Text('${e.type}  ',
                            style: Theme.of(context).textTheme.subtitle1,
                          ),
                        ),
                      if(e.type != null && e.type != '-' && e.releaseDate!=null)
                      Icon(CupertinoIcons.circle_fill,
                        size: 6,
                        color: Theme.of(context).textTheme.subtitle1!.color,
                      ),
                      if(e.releaseDate!=null)
                      Text('  ${e.releaseDate!.split('-').first}',
                        style: Theme.of(context).textTheme.subtitle1,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        }).toList(),
      ) : LoadingWidget(),
    );
  }
}
