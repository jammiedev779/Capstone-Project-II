import 'package:doc_care/screens/home/notification_page.dart';
import 'package:doc_care/shared/widgets/cards/appointment_preview_card.dart';
import 'package:doc_care/shared/widgets/widgets.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Create a bloc and provide it to the HomeView
    return const HomeView();
  }
}

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    // Create the HomeView UI
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 80,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Welcome',
              style: textTheme.bodyMedium,
            ),
            const SizedBox(height: 4.0),
            Text(
              'John Doe',
              style: textTheme.bodyLarge!.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 4.0),
            Row(
              children: [
                Icon(
                  Icons.location_on,
                  color: colorScheme.secondary,
                ),
                const SizedBox(width: 4.0),
                Text(
                  'Dubai, UAE',
                  style: textTheme.bodySmall!.copyWith(
                    color: colorScheme.secondary,
                  ),
                ),
                const SizedBox(width: 4.0),
                Icon(
                  Icons.expand_more,
                  color: colorScheme.secondary,
                ),
              ],
            ),
          ],
        ),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => NotificationPage()),
            );
            },
            icon: const Icon(Icons.notifications_outlined),
          ),
          const SizedBox(width: 8.0),
        ],
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(64.0),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
              decoration: InputDecoration(
                hintText: 'Search for doctors...',
                prefixIcon: const Icon(Icons.search),
                suffixIcon: Container(
                  margin: const EdgeInsets.all(4.0),
                  padding: const EdgeInsets.all(8.0),
                  decoration: BoxDecoration(
                    color: colorScheme.onSurfaceVariant,
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  child: Icon(
                    Icons.filter_alt_outlined,
                    color: colorScheme.surfaceVariant,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
      body: const SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(8.0),
          child: Column(
            children: <Widget>[
              _MyAppointment(),
              SizedBox(height: 24.0),
              _GeneralNeeds(),
              SizedBox(height: 24.0),
            ],
          ),
        ),
      ),
    );
  }
}

class _MyAppointment extends StatelessWidget {
  const _MyAppointment();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SectionTitle(
          title: 'Upcoming Appointments',
          action: '',
          onPressed: () {},
        ),
        const AppointmentPreviewCard(),
      ],
    );
  }
}

class _GeneralNeeds extends StatelessWidget {
  const _GeneralNeeds();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SectionTitle(
          title: 'For General Neededs',
          action: '',
          onPressed: () {},
        ),
        const GeneralNeedsPreviewList(),
      ],
    );
  }
}
