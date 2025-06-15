import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../../domain/entities/trip_log_entity.dart';

class TripLogDetailSheet extends StatelessWidget {
  final TripLogEntity tripLog;

  const TripLogDetailSheet({
    super.key,
    required this.tripLog,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Handle bar
          Center(
            child: Container(
              width: 40.0,
              height: 4.0,
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(2.0),
              ),
            ),
          ),
          const SizedBox(height: 20.0),
          
          // Title
          Text(
            'Log Details',
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 20.0),
          
          // Activity type
          _buildDetailRow(
            context,
            'Activity Type',
            tripLog.formattedActivityType,
            Icons.category,
          ),
          
          // Duration
          _buildDetailRow(
            context,
            'Duration',
            _formatDuration(tripLog.duration),
            Icons.timer,
          ),
          
          // Start time
          _buildDetailRow(
            context,
            'Start Time',
            DateFormat('MMM dd, yyyy HH:mm').format(tripLog.startTime),
            Icons.play_arrow,
          ),
          
          // End time
          _buildDetailRow(
            context,
            'End Time',
            DateFormat('MMM dd, yyyy HH:mm').format(tripLog.endTime),
            Icons.stop,
          ),
          
          // Log ID
          _buildDetailRow(
            context,
            'Log ID',
            tripLog.logId,
            Icons.fingerprint,
            isMonospace: true,
          ),
          
          // Trip ID
          _buildDetailRow(
            context,
            'Trip ID',
            tripLog.tripId,
            Icons.route,
            isMonospace: true,
          ),
          
          // Created at
          _buildDetailRow(
            context,
            'Created At',
            DateFormat('MMM dd, yyyy HH:mm:ss').format(tripLog.createdAt),
            Icons.access_time,
          ),
          
          // Updated at
          _buildDetailRow(
            context,
            'Updated At',
            DateFormat('MMM dd, yyyy HH:mm:ss').format(tripLog.updatedAt),
            Icons.update,
          ),
          
          const SizedBox(height: 20.0),
          
          // Close button
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Close'),
            ),
          ),
          
          // Safe area padding
          SizedBox(height: MediaQuery.of(context).padding.bottom),
        ],
      ),
    );
  }

  Widget _buildDetailRow(
    BuildContext context,
    String label,
    String value,
    IconData icon, {
    bool isMonospace = false,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            icon,
            size: 20.0,
            color: Theme.of(context).primaryColor,
          ),
          const SizedBox(width: 12.0),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: Colors.grey[600],
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 4.0),
                Text(
                  value,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                    fontFamily: isMonospace ? 'monospace' : null,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
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