import 'package:movie/view/widgets/back_button_widget.dart';
import 'package:movie/view/widgets/movie_info_widget.dart';
import '../../controller/movie_controller.dart';
import '../../utils/index.dart';

class MovieDetailPage extends StatefulWidget {
  final String uniqueId;

  const MovieDetailPage(this.uniqueId, {Key? key}) : super(key: key);

  @override
  State<MovieDetailPage> createState() => _MovieDetailPageState();
}

class _MovieDetailPageState extends State<MovieDetailPage> {
  final MovieController movieController = Get.put(MovieController());
  bool isError = false;

  @override
  void initState() {
    super.initState();
    movieController.fetchMovieDetail(widget.uniqueId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: 
      Obx(() {
        if(movieController.isError.value){
          return NoConnectionWidget(function: (){
            movieController.fetchMovieDetail(widget.uniqueId);
          },);
        }
        else if(movieController.isLoadingDetail.value){
          return LoadingWidget();
        } else {
          return CustomScrollView(physics: BouncingScrollPhysics(), slivers: [
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
                movieController.movie.value.coverImageUrl??'',
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
                  Text(movieController.movie.value.title??'',
                    style: Theme.of(context).textTheme.headline1,
                  ),
                  const MySizedBox(
                    height: 8,
                  ),
                  Row(
                    children: [
                      Text(movieController.movie.value.type??'',
                        style: Theme.of(context).textTheme.headline3,
                      ),
                      if(movieController.movie.value.releaseDate !=null)
                        Text('   ${movieController.movie.value.releaseDate!.split('-').first??''}', //split release date into year
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
                  if(movieController.movie.value.synopsis!=null)
                    const MySizedBox(
                      height: 28,
                    ),
                  Text(movieController.movie.value.synopsis??'',
                    style: Theme.of(context).textTheme.bodyText1,
                  ),
                  MovieInfoWidget(title: 'Cast', value: movieController.movie.value.cast),
                  MovieInfoWidget(title: 'Directed By', value: movieController.movie.value.director),
                  MovieInfoWidget(title: 'Produced By', value: movieController.movie.value.production),
                  MovieInfoWidget(title: 'Run Time', value: '${movieController.movie.value.runTime??''} mins'),
                ],
              ),
            ),
          ),
        ]);
        }
      }),
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
