import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_tech_assignment/src/features/domain/entities/series.dart';
import 'package:flutter_tech_assignment/src/features/presentation/bloc/search/search_bloc.dart';
import 'package:flutter_tech_assignment/src/features/presentation/bloc/search/search_event.dart';
import 'package:flutter_tech_assignment/src/features/presentation/bloc/search/search_state.dart';
import 'package:flutter_tech_assignment/src/features/presentation/series_view.dart';

class SearchSeriesDelegate extends SearchDelegate<Series?> {
  final Bloc<SearchEvent, SearchState> searchBloc;

  SearchSeriesDelegate({required this.searchBloc});

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        onPressed: () {
          query = '';
        },
        icon: AnimatedIcon(
            icon: AnimatedIcons.menu_close, progress: transitionAnimation),
      ),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(
        Icons.arrow_back,
      ),
      onPressed: () {
        query = '';
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    searchBloc.add(SearchTextChanged(text: query));

    return BlocBuilder<SearchBloc, SearchState>(builder: (context, state) {
      return switch (state) {
        SearchStateEmpty() => const Align(
            alignment: Alignment.topCenter,
            child: Text('Please enter a term to begin')),
        SearchStateLoading() =>
          const Center(child: CircularProgressIndicator.adaptive()),
        SearchStateError() => Center(child: Text(state.error)),
        SearchStateSuccess() => state.searchResultsItems.isEmpty
            ? const Text('No Results')
            : ListView.builder(
                itemCount: state.searchResultsItems.length,
                itemBuilder: (BuildContext context, int index) {
                  final searchResultItem =
                      state.searchResultsItems.elementAt(index);
                  return ListTile(
                      leading: searchResultItem.image != null
                          ? CachedNetworkImage(
                              imageUrl: searchResultItem.image!,
                              width: 50 * 0.75,
                              height: 50,
                              fit: BoxFit.fitHeight,
                            )
                          : const SizedBox(
                              width: 50 * 0.75,
                              height: 50,
                              child: Icon(Icons.movie),
                            ),
                      title: Text(searchResultItem.name),
                      onTap: () {
                        state.searchResultsItems.clear();
                        close(
                            context, state.searchResultsItems.elementAt(index));
                        Navigator.pushNamed(context, SeriesView.routeName,
                            arguments: searchResultItem);
                        query = '';
                      });
                },
              )
      };
    });
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return const SizedBox.shrink();
  }
}
