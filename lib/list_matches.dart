import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:responsi_124200064/matches_data_source.dart';
import 'package:responsi_124200064/matches_model.dart';
import 'package:responsi_124200064/detail_matches.dart';

class ListPage extends StatefulWidget {
  const ListPage({Key? key}) : super(key: key);

  @override
  State<ListPage> createState() => _ListPageState();
}

class _ListPageState extends State<ListPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: Text("Fifa World Cup Qatar 2022"),
      // ),
      body: _buildListPilDunBody(),
    );
  }

  Widget _buildListPilDunBody(){
    return Container(
      padding: EdgeInsets.all(8),
      child: FutureBuilder(
        future:
        ListMatchesSource.instance.loadMatches(),

        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          if (snapshot.hasError) {
            debugPrint(snapshot.data);
            return _buildErrorSection();
          }
          if (snapshot.hasData) {
            return _buildSuccessSection(snapshot.data);
          }
          return _buildLoadingSection();
        },
      ),
    );
  }

  Widget _buildErrorSection() {
    return Text("Error");
  }

  Widget _buildLoadingSection() {
    return Center(
      child: CircularProgressIndicator(),
    );
  }

  Widget _buildSuccessSection(List<dynamic> data) {
    return Scaffold(
      body: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return <Widget>[
            SliverAppBar(
              expandedHeight: 300.0,
              floating: false,
              pinned: true,
              stretch: true,
              flexibleSpace: FlexibleSpaceBar(
                  // centerTitle: true,
                  collapseMode: CollapseMode.parallax,
                  title: const Text("Fifa World Cup Qatar 2022",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w500,
                        fontSize: 16.0,
                      )),
                  background: Image.network(
                    "https://thinkmarketingmagazine.com/wp-content/uploads/2019/09/FIFA-World-Cup-Qatar-2022%E2%84%A2-Official-Emblem-revealed-.jpg",
                    fit: BoxFit.cover,
                  )),
            ),
          ];
        },
        body: Padding(
          padding: const EdgeInsets.all(10.0),
          child:
          ListView.builder(
            itemBuilder: (context, index) {
              MatchesModel matchesModel = MatchesModel.fromJson(data[index]);
              return InkWell(
                onTap: () => Navigator.push(context, MaterialPageRoute(
                    builder: ((context) {
                      return DetailMatch(idMatch: matchesModel.id.toString());
                    })
                )),
                child: Card(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Column(
                        children: [
                          Image.network("https://countryflagsapi.com/png/${matchesModel.homeTeam?.name}",width: 150,height: 150,),
                          Text("${matchesModel.homeTeam?.name}"),
                        ],
                      ),
                      SizedBox(width: 20,),
                      Text("${matchesModel.homeTeam?.goals}"),
                      SizedBox(width: 20,),
                      Text("-"),
                      SizedBox(width: 20,),
                      Text("${matchesModel.awayTeam?.goals}"),
                      SizedBox(width: 20,),
                      Column(
                        children: [
                          Image.network("https://countryflagsapi.com/png/${matchesModel.awayTeam?.name}",width: 150,height: 150,),
                          Text("${matchesModel.awayTeam?.name}"),
                        ],
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
