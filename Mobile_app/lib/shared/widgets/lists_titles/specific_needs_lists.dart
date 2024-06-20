import 'package:flutter/material.dart';

class SpecificNeedsPreviewList extends StatelessWidget {
  const SpecificNeedsPreviewList({
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
          'Our primary care doctors can help you with a broad range of health issues, medications and more by video appointment.',
          style: textTheme.bodyLarge?.copyWith(color: colorScheme.onBackground),
        ),
        const SizedBox(height: 16.0),
        _buildCard(
          context,
          icon: Icons.female,
          iconColor: Colors.pink,
          circleColor: Colors.pink.withOpacity(0.1),
          title: 'Women’s Health',
          subtitle:
              'UTI, Birth control, Menopause, Period problems, Yeast infections, & more.',
          onTap: () {
            // TODO: Implement Talk to a Doctor action
          },
        ),
        _buildCard(
          context,
          icon: Icons.child_care,
          iconColor: const Color.fromARGB(255, 254, 199, 0),
          circleColor: const Color.fromARGB(255, 254, 199, 0).withOpacity(0.1),
          title: 'Children’s Health',
          subtitle:
              'Cold & flu symptoms, Diarrhea or Constipation, Skin rashed, & Allergies.',
          onTap: () {
            // TODO: Implement Request Urgent Care action
          },
        ),
        _buildCard(
          context,
          icon: Icons.male,
          iconColor: Colors.blueAccent,
          circleColor: Colors.blueAccent.withOpacity(0.1),
          title: 'Men’s Health',
          subtitle:
              'STI symptoms, Erection issues, Bladder or Bowel issues, Skin & hair care.',
          onTap: () {
            // TODO: Implement Locate a Pharmacy action
          },
        ),
        _buildCard(
          context,
          icon: Icons.elderly,
          iconColor: Colors.blueGrey,
          circleColor: Colors.blueGrey.withOpacity(0.1),
          title: 'Senior Health',
          subtitle:
              'Muscle or joint pain, Medication management, Preventive health method.',
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
            offset: const Offset(0, 4),
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
