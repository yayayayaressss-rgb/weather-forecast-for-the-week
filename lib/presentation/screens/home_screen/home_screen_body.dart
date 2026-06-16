import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:forecast_app_pet_proj/domain/entities/meteo_enity/meteo_enity.dart';
import 'package:forecast_app_pet_proj/presentation/state_management/bloc/bloc.dart';
import 'package:forecast_app_pet_proj/presentation/state_management/bloc/events/events.dart';
import '../../custom_widgets/cards/home_cards/chart_cards/daily_chart_card/daily_chart_card.dart';
import '../../custom_widgets/cards/home_cards/chart_cards/hourly_chart_card/hourly_chart_card.dart';
import '../../custom_widgets/cards/home_cards/top_card/empty_card/empty_top_card.dart';
import '../../custom_widgets/cards/home_cards/top_card/failure_card/failure_card.dart';
import '../../custom_widgets/cards/home_cards/top_card/loading_card/loading_card.dart';
import '../../custom_widgets/cards/home_cards/top_card/main_info_top_card.dart';
import '../../custom_widgets/search_bar/bar/search_bar.dart';
import '../../custom_widgets/smooth_page_indicator/smooth_page_indicator.dart';
import '../../state_management/bloc/states/states.dart';

class HomeScreenBody extends StatelessWidget {
  final bool isMetric;

  const HomeScreenBody({super.key, required this.isMetric});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MyBloc, StateW>(
      builder: (context, state) {
        return switch (state) {
          EmptyState() => EmptyTopCard(),
          LoadingState() => LoadingCard(),
          LoadedSingle() => SingleMeteoScreen(
            state: state,
            isMetric: state.isMetric,
          ),
          FailureState() => FailureCard(failure: state.failure),
          LoadedAllFavoritesCityData() => AllFavoritesBody(
            isMetric: state.isMetric,
            listCurrentData: state.listCurrentData,
          ),
          LoadedDataFromCache() => AllFavoritesBody(
            isMetric: state.isMetric,
            listCurrentData: state.listCurrentData,
          ),
        };
      },
    );
  }
}

class AllFavoritesBody extends StatefulWidget {
  final bool isMetric;
  final List<MeteoEntity> listCurrentData;

  const AllFavoritesBody({
    super.key,
    required this.listCurrentData,
    required this.isMetric,
  });

  @override
  State<AllFavoritesBody> createState() => _AllFavoritesBodyState();
}

class _AllFavoritesBodyState extends State<AllFavoritesBody> {
  late PageController _controller;

  @override
  void initState() {
    super.initState();
    _controller = PageController();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final itemCount = widget.listCurrentData.length;
    List<MeteoEntity> currentList = widget.listCurrentData;

    if (itemCount <= 0) {
      context.read<MyBloc>().add(GetByGeoEvent(isMetric: widget.isMetric));
    }

    void removeItemInPageView(int index) {
      setState(() {
        currentList.removeAt(index);
      });
    }

    return Column(
      children: [
        MySearchBar(isMetric: widget.isMetric),
        if (itemCount > 1) ...[
          Smooth(controller: _controller, counter: itemCount),
          const SizedBox(height: 5.0),
        ],
        Expanded(
          child: Padding(
            padding: EdgeInsetsGeometry.all(8.0),
            child: PageView.builder(
              // allowImplicitScrolling: true,
              controller: _controller,
              itemCount: itemCount,
              itemBuilder: (context, index) {
                const sizeBox = SizedBox(height: 20.0);
                final currentData = currentList[index];
                return ClipRRect(
                  borderRadius: BorderRadius.circular(20.0),
                  child: SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        ///
                        sizeBox,

                        ///
                        TopCard(
                          actionRemove: () => removeItemInPageView(index),
                          currentWeather: currentData,
                          isMetric: widget.isMetric,
                        ),

                        ///
                        sizeBox,

                        ///
                        Padding(
                          padding: EdgeInsetsGeometry.only(bottom: 20.0),
                          child: HourlyChart(
                            data: currentData,
                            isMetric: widget.isMetric,
                          ),
                        ),

                        ///
                        Padding(
                          padding: EdgeInsetsGeometry.only(bottom: 8.0),
                          child: DailyChart(
                            data: currentData,
                            isMetric: widget.isMetric,
                          ),
                        ),

                        ///
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      ],
    );
  }
}

class SingleMeteoScreen extends StatelessWidget {
  final bool isMetric;
  final LoadedSingle state;

  const SingleMeteoScreen({
    super.key,
    required this.state,
    required this.isMetric,
  });

  @override
  Widget build(BuildContext context) {
    final currentData = state.data;
    const sizeBox = SizedBox(height: 20.0);
    return Column(
      children: [
        ///
        MySearchBar(isMetric: isMetric),

        ///
        Expanded(
          child: Padding(
            padding: EdgeInsetsGeometry.all(8.0),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(16.0),
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    ///
                    const SizedBox(height: 10.0),

                    ///
                    TopCard(
                      currentWeather: currentData,
                      actionRemove: () {},
                      isMetric: isMetric,
                    ),

                    ///
                    sizeBox,

                    ///
                    Padding(
                      padding: EdgeInsetsGeometry.only(bottom: 20.0),
                      child: HourlyChart(data: currentData, isMetric: isMetric),
                    ),

                    ///
                    Padding(
                      padding: EdgeInsetsGeometry.only(bottom: 8.0),
                      child: DailyChart(data: currentData, isMetric: isMetric),

                      ///
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
