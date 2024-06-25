import 'package:flutter/material.dart';

class GeneralNeedsPreviewList extends StatelessWidget {
  const GeneralNeedsPreviewList({
    super.key,
    this.needs,
  });

  // TODO: Create the Needs class
  final dynamic needs;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Get medical advice, prescriptions, test & referrals by video appointment with our doctors.',
          style: textTheme.bodyLarge?.copyWith(color: colorScheme.onBackground),
        ),
        const SizedBox(height: 16.0),
        _buildCard(
          context,
          icon: Icons.video_call,
          iconColor: colorScheme.primary,
          circleColor: Colors.blue.withOpacity(0.1),
          title: 'Talk to a Doctor',
          subtitle: 'Get medical advice, prescriptions, test & more.',
          onTap: () {
            // TODO: Implement Talk to a Doctor action
          },
        ),
        _buildCard(
          context,
          icon: Icons.local_hospital,
          iconColor: Colors.red,
          circleColor: Colors.red.withOpacity(0.1),
          title: 'Request Urgent Care',
          subtitle: 'Chat by video with the next available doctor.',
          onTap: () {
            // TODO: Implement Request Urgent Care action
          },
        ),
        _buildCard(
          context,
          icon: Icons.local_pharmacy,
          iconColor: Colors.green,
          circleColor: Colors.green.withOpacity(0.1),
          title: 'Locate a Pharmacy',
          subtitle:
              'Locate a Pharmacy within your area to purchase medications.',
          onTap: () {
            // TODO: Implement Locate a Pharmacy action
          },
        ),
        _buildCard(
          context,
          icon: Icons.calendar_today,
          iconColor: Colors.purple,
          circleColor: Colors.purple.withOpacity(0.1),
          title: 'Book an Appointment',
          subtitle:
              'Choose a Primary Care Doctor and complete your first video appointment.',
          onTap: () {
            // TODO: Implement Book an Appointment action
          },
        ),
        const SizedBox(height: 4.0),
        GestureDetector(
          onTap: () {
            // TODO: Implement See more actions
          },
          child: Text(
            'See more actions',
            style: textTheme.bodyLarge?.copyWith(
              color: colorScheme.primary,
              decoration: TextDecoration.underline,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildCard(
    BuildContext context, {
    required IconData icon,
    required Color iconColor,
    required Color circleColor,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;

    return Container(
      margin: const EdgeInsets.only(bottom: 16.0),
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.0),
        color: colorScheme.surface,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10.0,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Stack(
            alignment: Alignment.center,
            children: [
              Container(
                width: 40.0,
                height: 40.0,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: circleColor,
                ),
              ),
              Icon(
                icon,
                color: iconColor,
                size: 24.0,
              ),
            ],
          ),
          const SizedBox(width: 16.0),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: textTheme.bodyMedium!.copyWith(
                    color: colorScheme.onSurface,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4.0),
                GestureDetector(
                  onTap: onTap,
                  child: Text(
                    subtitle,
                    style: textTheme.bodyMedium!.copyWith(
                      color: colorScheme.onSurfaceVariant,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const Icon(
            Icons.arrow_forward_ios,
            color: Colors.grey,
            size: 16.0,
          ),
        ],
      ),
    );
  }
}
