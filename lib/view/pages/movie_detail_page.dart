import 'package:movie/view/widgets/back_button_widget.dart';
import 'package:movie/view/widgets/movie_info_widget.dart';

import '../../models/movie_ob.dart';
import '../../models/response_ob.dart';
import '../../utils/index.dart';

class MovieDetailPage extends StatefulWidget {
  final String uniqueId;

  const MovieDetailPage(this.uniqueId, {Key? key}) : super(key: key);

  @override
  State<MovieDetailPage> createState() => _MovieDetailPageState();
}

class _MovieDetailPageState extends State<MovieDetailPage> {

  late MovieBloc _bloc;
  MovieOb? _movieOb;
  bool isError = false;

  @override
  void initState() {
    super.initState();
    _bloc = MovieBloc(detail + widget.uniqueId, ObType.detail);
    _bloc.getMovieData();
    _bloc.movieStream().listen((event) {
      if (event.responseState == ResponseState.data) {
        _movieOb = event.data;
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
    return Scaffold(
      body: isError ? NoConnectionWidget(function: (){
        _bloc.getMovieData();
      }) : _movieOb != null ? CustomScrollView(physics: BouncingScrollPhysics(), slivers: [
        SliverAppBar(leading: const BackButtonWidget(),
          leadingWidth: 44,
          titleSpacing: 0,
          elevation: 0,
          primary: true,
          centerTitle: true,
          pinned: true,
          actions: [
            IconButton(onPressed: (){}, icon: const Icon(CupertinoIcons.bookmark),),
            IconButton(onPressed: (){}, icon: const Icon(CupertinoIcons.share)),
          ],
          flexibleSpace: FlexibleSpaceBar(
            titlePadding: EdgeInsets.zero,

            background: CachedNetworkImage(
              imageUrl:
                  _movieOb?.coverImageUrl??'',
              fit: BoxFit.fill,
              placeholder: (context, url) => Text(". . ."),
              errorWidget: (context, url, err) => const Icon(Icons.error),
            ),
          ),
          expandedHeight: 200,
        ),
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const MySizedBox(
                  height: 4,
                ),
                Text(_movieOb?.title??'',
                style: Theme.of(context).textTheme.headline1,
                ),
                const MySizedBox(
                  height: 8,
                ),
                Row(
                  children: [
                    Text(_movieOb?.type??'',
                      style: Theme.of(context).textTheme.headline3,
                    ),
                    if(_movieOb?.releaseDate !=null)
                    Text('   ${_movieOb?.releaseDate!.split('-').first??''}', //split release date into year
                      style: Theme.of(context).textTheme.headline3,
                    ),
                  ],
                ),
                const MySizedBox(
                  height: 14,
                ),
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
                if(_movieOb?.synopsis!=null)
                const MySizedBox(
                  height: 28,
                ),
                Text(_movieOb?.synopsis??'',
                  style: Theme.of(context).textTheme.bodyText1,
                ),
                MovieInfoWidget(title: 'Cast', value: _movieOb?.cast),
                MovieInfoWidget(title: 'Directed By', value: _movieOb?.director),
                MovieInfoWidget(title: 'Produced By', value: _movieOb?.production),
                MovieInfoWidget(title: 'Run Time', value: '${_movieOb?.runTime??''} mins'),
              ],
            ),
          ),
        ),
      ]) : LoadingWidget(),
      persistentFooterButtons: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
               Padding(
                 padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 8),
                 child: TextButton(
                    style: TextButton.styleFrom(padding: const EdgeInsets.symmetric(vertical: 18),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      backgroundColor: selectedItemColor, primary: Colors.white,),
                    onPressed: (){}, child:  Text('Buy Tickets',
                 style: Theme.of(context).textTheme.bodyText1,
                 )),
               ),
          ],
        )
      ],
    );
  }
}
