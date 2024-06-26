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
            onPressed: () {},
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
    );
  }
}

// class _DoctorCategories extends StatelessWidget {
//   const _DoctorCategories();

//   @override
//   Widget build(BuildContext context) {
//     return BlocBuilder<HomeBloc, HomeState>(
//       builder: (context, state) {
//         return Column(
//           children: [
//             SectionTitle(
//               title: 'Categories',
//               action: 'See all',
//               onPressed: () {},
//             ),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.start,
//               children: state.doctorCategories
//                   // Take 5 could be added in the bloc calculation
//                   .take(5)
//                   .map(
//                     (category) => Expanded(
//                       child: CircleAvatarWithTextLabel(
//                         icon: category.icon,
//                         label: category.name,
//                       ),
//                     ),
//                   )
//                   .toList(),
//             ),
//           ],
//         );
//       },
//     );
//   }
// }

// class _MySchedule extends StatelessWidget {
//   const _MySchedule();

//   @override
//   Widget build(BuildContext context) {
//     return BlocBuilder<HomeBloc, HomeState>(
//       builder: (context, state) {
//         return Column(
//           children: [
//             SectionTitle(
//               title: 'My Schedule',
//               action: 'See all',
//               onPressed: () {},
//             ),
//             AppointmentPreviewCard(
//               appointment: state.myAppointments.firstOrNull,
//             ),
//           ],
//         );
//       },
//     );
//   }
// }

// class _NearbyDoctors extends StatelessWidget {
//   const _NearbyDoctors();

//   @override
//   Widget build(BuildContext context) {
//     final colorScheme = Theme.of(context).colorScheme;

//     return BlocBuilder<HomeBloc, HomeState>(
//       builder: (context, state) {
//         return Column(
//           children: [
//             SectionTitle(
//               title: 'Nearby Doctors',
//               action: 'See all',
//               onPressed: () {},
//             ),
//             const SizedBox(height: 8.0),
//             ListView.separated(
//               physics: const NeverScrollableScrollPhysics(),
//               shrinkWrap: true,
//               separatorBuilder: (context, index) {
//                 return Divider(
//                   height: 24.0,
//                   color: colorScheme.surfaceVariant,
//                 );
//               },
//               itemCount: state.nearbyDoctors.length,
//               itemBuilder: (context, index) {
//                 final doctor = state.nearbyDoctors[index];
//                 return DoctorListTile(doctor: doctor);
//               },
//             ),
//           ],
//         );
//       },
//     );
//   }
// }
