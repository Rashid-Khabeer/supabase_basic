import 'package:flutter/material.dart';

class SimpleStreamBuilder<T> extends StreamBuilder<T> {
  SimpleStreamBuilder({
    Key? key,
    required BuildContext context,
    required Stream<T> stream,
    required Widget noneChild,
    Widget? noDataChild,
    required Widget activeChild,
    required Widget waitingChild,
    required Widget unknownChild,
    String? noDataMessage,
    required Function(String) errorBuilder,
    required Function(T) builder,
    required VoidCallback noData,
  }) : super(
          key: key,
          stream: stream,
          builder: (context, AsyncSnapshot<T> snapshot) {
            if (snapshot.hasData) {
              switch (snapshot.connectionState) {
                case ConnectionState.none:
                  return noneChild;
                case ConnectionState.waiting:
                  return waitingChild;
                case ConnectionState.done:
                  return activeChild;
                case ConnectionState.active:
                  if (snapshot.hasData) {
                    if (snapshot.data is List) {
                      if ((snapshot.data as List).isEmpty) {
                        noData();
                        return noDataChild ??
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: const <Widget>[
                                Center(
                                  child: Icon(
                                    Icons.search,
                                    size: 40,
                                    color: Colors.grey,
                                  ),
                                ),
                                Center(
                                  child: Text(
                                    'No Results',
                                    style: TextStyle(
                                      color: Colors.grey,
                                      fontSize: 22,
                                    ),
                                  ),
                                ),
                              ],
                            );
                      }
                    }
                    return builder(snapshot.data as T);
                  } else {
                    noData();
                    return noDataChild ??
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: const <Widget>[
                            Center(
                              child: Icon(
                                Icons.search,
                                size: 40,
                                color: Colors.grey,
                              ),
                            ),
                            Center(
                              child: Text(
                                'No Results',
                                style: TextStyle(
                                  color: Colors.grey,
                                  fontSize: 22,
                                ),
                              ),
                            ),
                          ],
                        );
                  }
              }
            } else if (snapshot.hasError) {
              return errorBuilder(snapshot.error.toString());
            }
            return waitingChild;
          },
        );

  SimpleStreamBuilder.simpler({
    Key? key,
    required Stream<T> stream,
    required BuildContext context,
    required Function(T) builder,
    VoidCallback? noData,
  }) : this(
          key: key,
          context: context,
          noData: noData ?? () {},
          stream: stream,
          noneChild: const Text('No Connection was found'),
          noDataChild: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: const <Widget>[
              Center(
                child: Icon(
                  Icons.search,
                  size: 40,
                  color: Colors.grey,
                ),
              ),
              Center(
                child: Text(
                  'No Results',
                  style: TextStyle(color: Colors.grey, fontSize: 20),
                ),
              ),
            ],
          ),
          unknownChild: const Text('Unknown Error Occurred'),
          activeChild: const Align(
            alignment: Alignment.center,
            child: CircularProgressIndicator(),
          ),
          waitingChild: const Align(
            alignment: Alignment.center,
            child: CircularProgressIndicator(),
          ),
          errorBuilder: (String error) => Align(
            alignment: Alignment.center,
            child: Text(error.toString()),
          ),
          builder: builder,
        );

  SimpleStreamBuilder.simplerSliver({
    Key? key,
    required Stream<T> stream,
    required BuildContext context,
    required Function(T) builder,
    VoidCallback? noData,
  }) : this(
          key: key,
          context: context,
          stream: stream,
          noData: noData ?? () {},
          noneChild: const SliverToBoxAdapter(
            child: Center(child: Text('No Connection was found')),
          ),
          noDataChild: const SliverToBoxAdapter(
            child: Center(child: Text('No Results')),
          ),
          unknownChild: const SliverToBoxAdapter(
            child: Center(child: Text('Unknown Error Occurred')),
          ),
          activeChild: const SliverToBoxAdapter(
            child: Align(
              alignment: Alignment.center,
              child: CircularProgressIndicator(),
            ),
          ),
          waitingChild: const SliverToBoxAdapter(
            child: Align(
              alignment: Alignment.center,
              child: CircularProgressIndicator(),
            ),
          ),
          errorBuilder: (String error) => SliverToBoxAdapter(
            child: Align(
              alignment: Alignment.center,
              child: Text(error.toString()),
            ),
          ),
          builder: builder,
        );
}
