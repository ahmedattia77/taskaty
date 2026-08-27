part of 'network_status_cubit.dart';

@immutable
sealed class NetworkStatusState {}

final class NetworkStatusInitial extends NetworkStatusState {}

final class NetworkStatusConnected extends NetworkStatusState {}

final class NetworkStatusDisConnected extends NetworkStatusState {}
