part of 'search_service_bloc.dart';

abstract class SearchServiceEvent {}

class FetchServiceEvent extends SearchServiceEvent {}

class UpdateDataSearchServiceEvent extends SearchServiceEvent {}
