import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/di/injection.dart';
import '../../bloc/trip_logs/trip_logs_bloc.dart';
import '../../bloc/trip_logs/trip_logs_event.dart';
import '../../bloc/trip_logs/trip_logs_state.dart';
import '../../widgets/common/error_widget.dart';
import '../../widgets/common/loading_widget.dart';
import '../../widgets/trip_logs/trip_log_card_widget.dart';
import '../../widgets/trip_logs/trip_log_detail_sheet.dart';
import '../../widgets/trip_logs/trip_logs_summary_widget.dart';

class TripLogsPage extends StatelessWidget {
  final String tripId;

  const TripLogsPage({
    super.key,
    required this.tripId,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<TripLogsBloc>()..add(GetTripLogsEvent(tripId)),
      child: TripLogsView(tripId: tripId),
    );
  }
}

class TripLogsView extends StatelessWidget {
  final String tripId;
  
  const TripLogsView({
    super.key,
    required this.tripId,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Trip Logs'),
        centerTitle: true,
        elevation: 0,
        actions: [
          BlocBuilder<TripLogsBloc, TripLogsState>(
            builder: (context, state) {
              return IconButton(
                onPressed: () {
                  context.read<TripLogsBloc>().add(RefreshTripLogsEvent(tripId));
                },
                icon: const Icon(Icons.refresh),
                tooltip: 'Refresh',
              );
            },
          ),
        ],
      ),
      body: BlocBuilder<TripLogsBloc, TripLogsState>(
        builder: (context, state) {
          if (state is TripLogsLoading) {
            return const LoadingWidget(
              itemCount: 5,
              showCircularIndicator: false,
            );
          } else if (state is TripLogsRefreshing) {
            return _buildTripLogsContent(context, state.response, isRefreshing: true);
          } else if (state is TripLogsLoaded) {
            return _buildTripLogsContent(context, state.response);
          } else if (state is TripLogsError) {
            return CustomErrorWidget(
              message: state.message,
              onRetry: () {
                context.read<TripLogsBloc>().add(GetTripLogsEvent(tripId));
              },
            );
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }

  Widget _buildTripLogsContent(
    BuildContext context,
    response,
    {bool isRefreshing = false}
  ) {
    if (response.data.isEmpty) {
      return const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.assignment_outlined,
              size: 80.0,
              color: Colors.grey,
            ),
            SizedBox(height: 16.0),
            Text(
              'No Trip Logs Found',
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.w600,
                color: Colors.grey,
              ),
            ),
            SizedBox(height: 8.0),
            Text(
              'There are no logs for this trip yet.',
              style: TextStyle(
                color: Colors.grey,
              ),
            ),
          ],
        ),
      );
    }

    return RefreshIndicator(
      onRefresh: () async {
        context.read<TripLogsBloc>().add(RefreshTripLogsEvent(tripId));
      },
      child: CustomScrollView(
        slivers: [
          // Summary section
          SliverToBoxAdapter(
            child: TripLogsSummaryWidget(response: response),
          ),
          
          // Trip ID section
          SliverToBoxAdapter(
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
              padding: const EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                color: Colors.grey[50],
                borderRadius: BorderRadius.circular(12.0),
                border: Border.all(color: Colors.grey[200]!),
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.info_outline,
                    color: Colors.grey[600],
                    size: 20.0,
                  ),
                  const SizedBox(width: 8.0),
                  Text(
                    'Trip ID: ',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      fontWeight: FontWeight.w500,
                      color: Colors.grey[600],
                    ),
                  ),
                  Expanded(
                    child: Text(
                      tripId,
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        fontWeight: FontWeight.w600,
                        fontFamily: 'monospace',
                      ),
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      // Copy trip ID to clipboard
                      // You can implement clipboard functionality here
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Trip ID copied to clipboard'),
                          duration: Duration(seconds: 2),
                        ),
                      );
                    },
                    icon: Icon(
                      Icons.copy,
                      size: 18.0,
                      color: Colors.grey[600],
                    ),
                    tooltip: 'Copy Trip ID',
                  ),
                ],
              ),
            ),
          ),
          
          // Headers
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 8.0),
              child: Row(
                children: [
                  Text(
                    'Activity Logs',
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const Spacer(),
                  if (isRefreshing)
                    const SizedBox(
                      width: 16.0,
                      height: 16.0,
                      child: CircularProgressIndicator(strokeWidth: 2.0),
                    ),
                ],
              ),
            ),
          ),
          
          // Trip logs list
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                final tripLog = response.data[index];
                return TripLogCardWidget(
                  tripLog: tripLog,
                  onTap: () {
                    _showTripLogDetails(context, tripLog);
                  },
                );
              },
              childCount: response.data.length,
            ),
          ),
          
          // Bottom padding
          const SliverToBoxAdapter(
            child: SizedBox(height: 16.0),
          ),
        ],
      ),
    );
  }

  void _showTripLogDetails(BuildContext context, tripLog) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20.0)),
      ),
      builder: (context) => TripLogDetailSheet(tripLog: tripLog),
    );
  }
}
