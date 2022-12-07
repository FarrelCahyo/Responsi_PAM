import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:responsi_124200064/matches_data_source.dart';
import 'package:responsi_124200064/detail_matches_model.dart';

class DetailMatch extends StatefulWidget {
  final String idMatch;
  const DetailMatch({Key? key, required this.idMatch}) : super(key: key);

  @override
  State<DetailMatch> createState() => _DetailMatchState();
}

class _DetailMatchState extends State<DetailMatch> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:
        Flexible(
            child: Text("Match ID : ${widget.idMatch}",
                style: TextStyle(
                  color: Colors.white,
                ))),
      ),
      body: ListView(
        children: [
          Column(
            children: [
              FutureBuilder(
                future: DetailListMatchesSource.instance.loadDetailMatches(widget.idMatch),
                builder:
                    (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                  if (snapshot.hasError) {
                    return _buildErrorSection();
                  }
                  if (snapshot.hasData) {
                    DetailMatchesModel detailModels = DetailMatchesModel.fromJson(snapshot.data);
                    return _buildSuccessSection(detailModels);
                  }
                  return _buildLoadingSection();
                },
              )
            ],
          ),
        ],
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

  Widget _buildSuccessSection (DetailMatchesModel match) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.network("https://countryflagsapi.com/png/${match.homeTeam?.name}", width: 190, height: 150,),
            SizedBox(width: 10,),
            Text("${match.homeTeam?.goals}"),
            SizedBox(width: 10,),
            Text(" - "),
            SizedBox(width: 10,),
            Text("${match.awayTeam?.goals}"),
            SizedBox(width: 10,),
            Image.network("https://countryflagsapi.com/png/${match.awayTeam?.name}", width: 190, height: 150,),
          ],
        ),
        SizedBox(height: 15,),
        Text("${match.homeTeam?.name}                                                           ${match.awayTeam?.name}"),
        SizedBox(height: 10,),
        Text("Stadium :  ${match.venue}"),
        SizedBox(height: 5,),
        Text("Location :  ${match.location} "),
        SizedBox(height: 10,),
        Container(
          decoration: BoxDecoration(
              border: Border.all(
                color: Colors.black,
                width: 2,
              ),
              borderRadius: BorderRadius.circular(0)
          ),
          padding: EdgeInsets.fromLTRB(15.0, 5.0, 15.0, 5.0),
          margin: EdgeInsets.all(5),
          width: double.infinity,
          height: 250,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("Statistics", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
              SizedBox(height: 15,),
              Text("${match.homeTeam?.statistics?.ballPossession}          Ball Possession          ${match.awayTeam?.statistics?.ballPossession}"),
              SizedBox(height: 5,),
              Text("${match.homeTeam?.statistics?.attemptsOnGoal}                           Shot                           ${match.awayTeam?.statistics?.attemptsOnGoal}"),
              SizedBox(height: 5,),
              Text("${match.homeTeam?.statistics?.kicksOnTarget}                    Shot On Goal                    ${match.awayTeam?.statistics?.kicksOnTarget}"),
              SizedBox(height: 5,),
              Text("${match.homeTeam?.statistics?.corners}                        Corners                         ${match.awayTeam?.statistics?.corners}"),
              SizedBox(height: 5,),
              Text("${match.homeTeam?.statistics?.offsides}                         Offside                         ${match.awayTeam?.statistics?.offsides}"),
              SizedBox(height: 5,),
              Text("${match.homeTeam?.statistics?.foulsReceived}                          Fouls                         ${match.awayTeam?.statistics?.foulsReceived}"),
              SizedBox(height: 5,),
              Text("${match.homeTeam?.statistics?.passesCompleted}              Passes Completed               ${match.awayTeam?.statistics?.passesCompleted}"),
              SizedBox(height: 10,)
            ],
          ),
        ),
        SizedBox(height: 15,),
        Text("Referees : ", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
        SizedBox(height: 10,),
        Container(
          alignment: Alignment.center,
          width: double.infinity,
          height: 125,
          child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: match.officials?.length,
              itemBuilder: (context, index) {
                return Container(
                  decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.black,
                        width: 2,
                      ),
                      borderRadius: BorderRadius.circular(0)
                  ),
                  margin: EdgeInsets.all(5),
                  width: 100,
                  height: 100,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        "FIFA",
                        style: TextStyle(
                            fontFamily: 'LeckerliOne',
                            fontSize: 40,
                            fontWeight: FontWeight.bold
                        ),
                      ),
                      SizedBox(width: 5,),
                      Flexible(
                        child: Text(
                          "${match.officials?[index].name}",
                          maxLines: 1,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              decoration: TextDecoration.underline
                          )
                        ),
                      ),
                      SizedBox(width: 5,),
                      Flexible(
                        child: Text(
                            "${match.officials?[index].role}",
                            maxLines: 1,
                            textAlign: TextAlign.center
                        ),
                      ),
                    ],
                  ),
                );
              }
          ),
        ),
      ],
    );
  }
}