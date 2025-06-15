import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../../domain/entities/trip_log_entity.dart';

class TripLogCardWidget extends StatelessWidget {
  final TripLogEntity tripLog;
  final VoidCallback? onTap;

  const TripLogCardWidget({
    super.key,
    required this.tripLog,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      elevation: 2.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12.0),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header with activity type and duration
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12.0,
                      vertical: 6.0,
                    ),
                    decoration: BoxDecoration(
                      color: _getActivityColor(tripLog.activityType).withOpacity(0.1),
                      borderRadius: BorderRadius.circular(20.0),
                      border: Border.all(
                        color: _getActivityColor(tripLog.activityType),
                        width: 1.0,
                      ),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          _getActivityIcon(tripLog.activityType),
                          size: 16.0,
                          color: _getActivityColor(tripLog.activityType),
                        ),
                        const SizedBox(width: 6.0),
                        Text(
                          tripLog.formattedActivityType,
                          style: TextStyle(
                            color: _getActivityColor(tripLog.activityType),
                            fontWeight: FontWeight.w600,
                            fontSize: 12.0,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Spacer(),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8.0,
                      vertical: 4.0,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.blue.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(6.0),
                    ),
                    child: Text(
                      _formatDuration(tripLog.duration),
                      style: TextStyle(
                        color: Colors.blue[700],
                        fontWeight: FontWeight.w500,
                        fontSize: 11.0,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12.0),
              
              // Time information
              Row(
                children: [
                  Expanded(
                    child: _buildTimeInfo(
                      context,
                      'Start Time',
                      tripLog.startTime,
                      Icons.play_arrow,
                    ),
                  ),
                  const SizedBox(width: 16.0),
                  Expanded(
                    child: _buildTimeInfo(
                      context,
                      'End Time',
                      tripLog.endTime,
                      Icons.stop,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12.0),
              
              // Footer with timestamps
              Row(
                children: [
                  Icon(
                    Icons.access_time,
                    size: 14.0,
                    color: Colors.grey[600],
                  ),
                  const SizedBox(width: 6.0),
                  Text(
                    'Created: ${DateFormat('MMM dd, yyyy HH:mm').format(tripLog.createdAt)}',
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: Colors.grey[600],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTimeInfo(
    BuildContext context,
    String label,
    DateTime time,
    IconData icon,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(
              icon,
              size: 14.0,
              color: Colors.grey[600],
            ),
            const SizedBox(width: 4.0),
            Text(
              label,
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: Colors.grey[600],
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
        const SizedBox(height: 4.0),
        Text(
          DateFormat('HH:mm').format(time),
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
            fontWeight: FontWeight.w600,
          ),
        ),
        Text(
          DateFormat('MMM dd, yyyy').format(time),
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
            color: Colors.grey[600],
          ),
        ),
      ],
    );
  }

  Color _getActivityColor(String activityType) {
    switch (activityType.toLowerCase()) {
      case 'lunch':
        return Colors.orange;
      case 'break':
        return Colors.blue;
      case 'meeting':
        return Colors.purple;
      case 'travel':
        return Colors.green;
      case 'work':
        return Colors.indigo;
      default:
        return Colors.grey;
    }
  }

  IconData _getActivityIcon(String activityType) {
    switch (activityType.toLowerCase()) {
      case 'lunch':
        return Icons.restaurant;
      case 'break':
        return Icons.coffee;
      case 'meeting':
        return Icons.people;
      case 'travel':
        return Icons.directions_car;
      case 'work':
        return Icons.work;
      default:
        return Icons.schedule;
    }
  }

  String _formatDuration(Duration duration) {
    final hours = duration.inHours;
    final minutes = duration.inMinutes.remainder(60);
    
    if (hours > 0) {
      return '${hours}h ${minutes}m';
    } else {
      return '${minutes}m';
    }
  }
}
