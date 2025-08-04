import 'package:comnote/data.dart';
import 'package:comnote/loginbrowser.dart';
import 'package:comnote/models/generic.dart';
import 'package:comnote/ui/components.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final Loginbrowser _loginbrowser = Loginbrowser();

  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
      GlobalKey<RefreshIndicatorState>();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _loadInitialData();
    });
  }

  Future<void> _loadInitialData() async {
    var handler = Provider.of<AppHandler>(context, listen: false);
    if (!handler.homePageInitialized) {
      var elementDraw = Provider.of<ElementsDraw>(context, listen: false);
      elementDraw.refreshIndicatorKey = _refreshIndicatorKey;

      // Ensure app state is loaded
      await handler.loadData();

      // Trigger refresh indicator animation
      _refreshIndicatorKey.currentState?.show();


      // Fetch the initial homepage data
      await handler.loadHomePageData(
        ranking: SearchRanking.top10Airing,
        updateChosenList: true,
      );
    }
    handler.homePageInitialized = true;
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Stack(
        children: [
          // Cards display
          Consumer<AppHandler>(
            builder: (context, handler, child) {
              final list = handler.state.topLists[handler.state.currentTopList];

              if (list == null || handler.elementsState.showLoading) {
                return const SizedBox.shrink();
              }

              final children = list.list
                  .map<Widget>(
                    (summary) => RecommendationCard(
                      title: summary.node.title,
                      description: summary.node.synopsis,
                      popularity: summary.node.rankInLists,
                      poster: summary.node.mainPicture.large,
                      rank: summary.node.rank,
                      rating: summary.node.rating,
                    ),
                  )
                  .toList();

              return RefreshIndicator(
                key: _refreshIndicatorKey,
                onRefresh: () async {
                  await handler.loadHomePageData(
                    ranking: handler.state.currentTopList,
                    dataRefresh: true,
                  );
                },
                child: ListView.separated(
                  physics: const BouncingScrollPhysics(
                    parent: AlwaysScrollableScrollPhysics(),
                  ),
                  padding: const EdgeInsets.all(10.0),
                  itemCount: children.length,
                  itemBuilder: (context, i) => children[i],
                  separatorBuilder: (context, i) => const SizedBox(height: 10),
                ),
              );
            },
          ),
          // Full-screen circular loader with background (to give the illusion of navigating to a new page and the loader appearing!)
          Consumer<ElementsDraw>(
            builder: (context, draw, child) {
              if (draw.showLoading) {
                return Container(
                  width: double.maxFinite,
                  height: double.maxFinite,
                  alignment: Alignment.center,
                  color: Theme.of(context).colorScheme.surfaceDim,
                  child: const Padding(
                    padding: EdgeInsets.all(20),
                    child: CircularProgressIndicator(),
                  ),
                );
              }

              return const SizedBox.shrink();
            },
          ),
        ],
      ),
    );
  }
}

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  final Loginbrowser _loginbrowser = Loginbrowser();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[const Text("Rich bitch")],
      ),
    );
  }
}
