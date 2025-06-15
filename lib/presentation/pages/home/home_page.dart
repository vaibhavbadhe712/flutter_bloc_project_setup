// lib/presentation/pages/home/home_page.dart - Updated with Trip Logs access
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_project/presentation/routes/app_routes.dart';
import '../../../core/di/injection.dart';
import '../../bloc/user/user_bloc.dart';
import '../../bloc/user/user_event.dart';
import '../../bloc/user/user_state.dart';
import '../../widgets/common/error_widget.dart';
import '../../widgets/common/loading_widget.dart';
import '../../widgets/user/user_card_widget.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<UserBloc>()..add(const GetUsersEvent()),
      child: const HomeView(),
    );
  }
}

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Flutter BLoC Demo'),
        centerTitle: true,
        elevation: 0,
        actions: [
          BlocBuilder<UserBloc, UserState>(
            builder: (context, state) {
              return IconButton(
                onPressed: () {
                  context.read<UserBloc>().add(const RefreshUsersEvent());
                },
                icon: const Icon(Icons.refresh),
              );
            },
          ),
        ],
      ),
      body: Column(
        children: [
          // Quick access section
          Container(
            margin: const EdgeInsets.all(16.0),
            padding: const EdgeInsets.all(20.0),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Theme.of(context).primaryColor,
                  Theme.of(context).primaryColor.withOpacity(0.8),
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(16.0),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Quick Access',
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 16.0),
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton.icon(
                        onPressed: () {
                          // Navigate to trip logs with default trip ID
                          context.pushTripLogs('bfabb4c0-62cc-4a9d-b319-67b64276a141');
                        },
                        icon: const Icon(Icons.assignment),
                        label: const Text('Trip Logs'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                          foregroundColor: Theme.of(context).primaryColor,
                          padding: const EdgeInsets.symmetric(vertical: 12.0),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          
          // Users section
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Row(
              children: [
                Text(
                  'Users',
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 8.0),
          
          // Users list
          Expanded(
            child: BlocBuilder<UserBloc, UserState>(
              builder: (context, state) {
                if (state is UserLoading) {
                  return const LoadingWidget();
                } else if (state is UserRefreshing) {
                  return RefreshIndicator(
                    onRefresh: () async {
                      context.read<UserBloc>().add(const RefreshUsersEvent());
                    },
                    child: ListView.builder(
                      itemCount: state.users.length,
                      itemBuilder: (context, index) {
                        final user = state.users[index];
                        return UserCardWidget(
                          user: user,
                          onTap: () {
                            context.pushUserDetail(user.id);
                          },
                        );
                      },
                    ),
                  );
                } else if (state is UsersLoaded) {
                  return RefreshIndicator(
                    onRefresh: () async {
                      context.read<UserBloc>().add(const RefreshUsersEvent());
                    },
                    child: ListView.builder(
                      itemCount: state.users.length,
                      itemBuilder: (context, index) {
                        final user = state.users[index];
                        return UserCardWidget(
                          user: user,
                          onTap: () {
                            context.pushUserDetail(user.id);
                          },
                        );
                      },
                    ),
                  );
                } else if (state is UserError) {
                  return CustomErrorWidget(
                    message: state.message,
                    onRetry: () {
                      context.read<UserBloc>().add(const GetUsersEvent());
                    },
                  );
                }
                return const SizedBox.shrink();
              },
            ),
          ),
        ],
      ),
    );
  }
}