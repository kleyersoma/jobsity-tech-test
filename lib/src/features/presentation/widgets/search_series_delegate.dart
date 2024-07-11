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
          _clearSearchResults();
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
        _clearSearchResults();
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    searchBloc.add(SearchTextChanged(text: query));
    return BlocBuilder<SearchBloc, SearchState>(builder: (context, state) {
      return switch (state) {
        SearchStateEmpty() => Container(
            alignment: Alignment.topCenter,
            padding: const EdgeInsets.only(top: 24),
            child: Text(query.isEmpty
                ? 'Please enter a term to begin'
                : 'Fetching results..')),
        SearchStateLoading() =>
          const Center(child: CircularProgressIndicator.adaptive()),
        SearchStateError() => Center(child: Text(state.error)),
        SearchStateSuccess() => state.searchResultsItems.isEmpty
            ? Container(
                padding: const EdgeInsets.only(top: 24),
                alignment: Alignment.topCenter,
                child: const Text('No Results'))
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
                        _clearSearchResults();

                        close(context, searchResultItem);
                        Navigator.pushNamed(context, SeriesView.routeName,
                            arguments: searchResultItem);
                      });
                },
              )
      };
    });
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return Container(
      alignment: Alignment.topCenter,
      padding: const EdgeInsets.only(top: 12),
      child: const Text('Enter a movie or series name'),
    );
  }

  Future<void> _clearSearchResults() async {
    query = '';
    searchBloc.add(SearchLeave());
  }
}
