import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import '../../../core/utils/logger.dart';
import '../../../domain/usecases/get_trip_logs_usecase.dart';
import 'trip_logs_event.dart';
import 'trip_logs_state.dart';

@injectable
class TripLogsBloc extends Bloc<TripLogsEvent, TripLogsState> {
  final GetTripLogsUseCase getTripLogsUseCase;

  TripLogsBloc({
    required this.getTripLogsUseCase,
  }) : super(const TripLogsInitial()) {
    on<GetTripLogsEvent>(_onGetTripLogs);
    on<RefreshTripLogsEvent>(_onRefreshTripLogs);
  }

  Future<void> _onGetTripLogs(
    GetTripLogsEvent event,
    Emitter<TripLogsState> emit,
  ) async {
    emit(const TripLogsLoading());
    
    final result = await getTripLogsUseCase(event.tripId);
    
    result.fold(
      (failure) {
        AppLogger.e('Failed to get trip logs: ${failure.message}');
        emit(TripLogsError(failure.message));
      },
      (response) {
        AppLogger.i('Successfully loaded ${response.data.length} trip logs');
        emit(TripLogsLoaded(response));
      },
    );
  }

  Future<void> _onRefreshTripLogs(
    RefreshTripLogsEvent event,
    Emitter<TripLogsState> emit,
  ) async {
    // Show refreshing state with current data if available
    if (state is TripLogsLoaded) {
      emit(TripLogsRefreshing((state as TripLogsLoaded).response));
    } else {
      emit(const TripLogsLoading());
    }
    
    final result = await getTripLogsUseCase(event.tripId);
    
    result.fold(
      (failure) {
        AppLogger.e('Failed to refresh trip logs: ${failure.message}');
        emit(TripLogsError(failure.message));
      },
      (response) {
        AppLogger.i('Successfully refreshed ${response.data.length} trip logs');
        emit(TripLogsLoaded(response));
      },
    );
  }
}