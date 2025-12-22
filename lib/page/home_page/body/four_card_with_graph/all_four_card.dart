import 'package:flutter/material.dart';
import 'card_structure.dart';
import '../../../../../model/model_one.dart';

class MCapCard extends StatefulWidget {
  const MCapCard({super.key});

  @override
  State<MCapCard> createState() {
    return _MCapCardState();
  }
}

class _MCapCardState extends State<MCapCard> {
  late Future<ModelOne?> _dataFuture;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<ModelOne?>(
      future: _dataFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Container(
            alignment: Alignment.center,
            height: 100.0,
            color: Colors.white,
            child: CircularProgressIndicator(
              valueColor: const AlwaysStoppedAnimation<Color>(Colors.green),
              strokeWidth: 2.0,
            ),
          );
        } else if (snapshot.hasError) {
          return const Center(
            child: Text('Error loading data'),
          );
        } else if (snapshot.hasData && snapshot.data != null) {
          final data = snapshot.data!;
          return Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              CardStructure(
                title: 'Total M.cap',
                value: data.data?.mc?.v.toString() ?? '404',
                change: data.data?.mc?.c.toString() ?? '404',
              ),
              CardStructure(
                title: '24h Vol',
                value: data.data?.v?.v.toString() ?? '404',
                change: data.data?.v?.c.toString() ?? '404',
              ),
              CardStructure(
                title: 'BTC.D',
                value: data.data?.b?.v?.toString() ?? '404',
                change: data.data?.b?.c?.toString() ?? '404',
              ),
              CardStructure(
                title: 'ETH.D',
                value: data.data?.e?.v?.toString() ?? '404',
                change: data.data?.e?.c?.toString() ?? '404',
              ),
            ],
          );
        } else {
          return const Center(child: Text('No data available'));
        }
      },
    );
  }
}
