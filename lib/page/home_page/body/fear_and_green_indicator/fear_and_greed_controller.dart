import 'dart:async';

import 'package:flutter/material.dart';
import 'package:altsome_app/page/home_page/body/fear_and_green_indicator/heading_and_download_button.dart';
import 'package:altsome_app/page/home_page/body/fear_and_green_indicator/static_image_indicator.dart';
import 'data_percentage.dart';

import '../../../../model/model_one.dart';

class FearAndGreedIndex extends StatefulWidget {
  const FearAndGreedIndex({super.key});

  @override
  State<FearAndGreedIndex> createState() {
    return _FearAndGreedIndexState();
  }
}

class _FearAndGreedIndexState extends State<FearAndGreedIndex> {
  late Future<ModelOne?> _dataFuture;
  double _progressValue = 0.0;
  Timer? _timer;

  Color getColorFromCode(String colorCode) {
    switch (colorCode) {
      case 'red-400':
        return Colors.red.shade400;
      case 'green-400':
        return Colors.green.shade400;
      case 'blue-400':
        return Colors.blue.shade400;
      default:
        return Colors.black;
    }
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            //* Constant heading and download button
            const HeadingAndDownloadButton(),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                //* Constant static needle indicator
                const StaticImageIndicator(),

                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(right: 18.0),
                    child: FutureBuilder<ModelOne?>(
                      future: _dataFuture,
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return Container(
                            alignment: Alignment.center,
                            height: 200.0,
                            child: CircularProgressIndicator(
                              value: _progressValue,
                              backgroundColor: Colors.grey,
                              strokeWidth: 2.0,
                            ),
                          );
                        } else if (snapshot.hasError) {
                          return const Center(
                            child: Text(
                              'Error loading data',
                            ),
                          );
                        } else if (snapshot.hasData && snapshot.data != null) {
                          final data = snapshot.data!;
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              //* 1st container
                              DataPercentage(
                                title: (data.data?.fg?.h?[0].t).toString(),
                                textData: (data.data?.fg?.h?[0].c).toString(),
                                percentageData:
                                    (data.data?.fg?.h?[0].v).toString(),
                                defineColor: getColorFromCode(
                                  (data.data?.fg?.h?[0].cc).toString(),
                                ),
                              ),
                              const SizedBox(height: 8),
                              //* 2nd container
                              DataPercentage(
                                title: (data.data?.fg?.h?[1].t).toString(),
                                textData: (data.data?.fg?.h?[1].c).toString(),
                                percentageData:
                                    (data.data?.fg?.h?[1].v).toString(),
                                defineColor: getColorFromCode(
                                  (data.data?.fg?.h?[1].cc).toString(),
                                ),
                              ),
                              const SizedBox(height: 8),
                              //* 3rd container
                              DataPercentage(
                                title: (data.data?.fg?.h?[2].t).toString(),
                                textData: (data.data?.fg?.h?[2].c).toString(),
                                percentageData:
                                    (data.data?.fg?.h?[2].v).toString(),
                                defineColor: getColorFromCode(
                                  (data.data?.fg?.h?[2].cc).toString(),
                                ),
                              ),
                            ],
                          );
                        } else {
                          return const Center(
                            child: Text(
                              'No data available',
                            ),
                          );
                        }
                      },
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
