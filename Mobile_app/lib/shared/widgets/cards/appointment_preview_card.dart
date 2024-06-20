import 'package:flutter/material.dart';

class AppointmentPreviewCard extends StatelessWidget {
  const AppointmentPreviewCard({
    super.key,
    this.appointment,
  });

  // TODO: Create the Appointment class
  final dynamic appointment;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;

    return Column(
      children: [
        Container(
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
                    width: 48.0,
                    height: 48.0,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: colorScheme.secondary.withOpacity(0.5),
                    ),
                  ),
                  Icon(
                    Icons.calendar_month_rounded,
                    color: colorScheme.primary,
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
                      'You currently don’t have an\nappointment scheduled.',
                      style: textTheme.bodyMedium!.copyWith(
                        color: colorScheme.onSurface,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8.0),
                    GestureDetector(
                      onTap: () {
                        // TODO: Implement booking appointment action
                      },
                      child: Text(
                        'Book an appointment today!',
                        style: textTheme.bodyMedium!.copyWith(
                          color: colorScheme.primary,
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
        ),
      ],
    );
  }
}
