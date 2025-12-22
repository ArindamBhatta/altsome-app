import 'package:flutter/material.dart';
import '../../../../../../model/model_three.dart';
import 'sector_card.dart';

class SectorsList extends StatefulWidget {
  const SectorsList({super.key});

  @override
  State<SectorsList> createState() {
    return _SectorsListState();
  }
}

class _SectorsListState extends State<SectorsList> {
  Future<ModelThree?>? _dataFuture;
  Future<ModelThree?>? get dataFuture {
    return _dataFuture;
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<ModelThree?>(
      future: dataFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Container(
            alignment: Alignment.center,
            height: 100.0,
            color: Colors.white,
            child: CircularProgressIndicator(
              strokeWidth: 2.0,
              color: Colors.black,
            ),
          );
        } else if (snapshot.hasError) {
          return const Center(
            child: Text('Error loading data'),
          );
        } else if (snapshot.hasData) {
          final data = snapshot.data!;
          return ListView.builder(
            scrollDirection: Axis.vertical,
            physics: const AlwaysScrollableScrollPhysics(),
            shrinkWrap: true,
            padding: const EdgeInsets.all(4.0),
            itemCount: data.data!.length,
            itemBuilder: (
              context,
              index,
            ) {
              return SectorCard(
                index: index,
                containerName: data.data![index].n ?? 'N/A',
                avgChange: (data.data![index].apc).toString(),
                avgChangePositive: data.data![index].apc! > 0 ? true : false,
                marketCap: data.data![index].mc.toString(),
                volume: data.data![index].v.toString(),
                gainers: data.data![index].g.toString(),
                topGainer: data.data![index].tg.toString(),
                gainerPercentage: data.data![index].gp.toString(),
                looser: data.data![index].l.toString(),
                loserPercentage: data.data![index].lp.toString(),
                dominance: data.data![index].d.toString(),
              );
            },
          );
        } else {
          return Scaffold(
            body: const Center(
              child: Text('No data available'),
            ),
          );
        }
      },
    );
  }
}
