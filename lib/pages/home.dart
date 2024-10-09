import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:users_list_bloc/data/dataSource/remote_data_source.dart';
import 'package:users_list_bloc/pages/bloc/user_bloc.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => UserBloc(remoteDataSource: RemoteDataSource())..add(LoadUser()),
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Data User"),
        ),
        body: BlocBuilder<UserBloc, UserState>(
          builder: (context, state) {
            if (state is UserLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is UserLoaded) {
              final data = state.users;
              return ListView.builder(
                  itemCount: data.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      leading: CircleAvatar(
                        backgroundImage: NetworkImage(data[index].avatar),
                      ),
                      title: Text(
                          "${data[index].firstName} ${data[index].lastName}"),
                      subtitle: Text(data[index].email),
                    );
                  });
            } else if (state is UserEror) {
              return Center(
                child: Text(
                  "Eror Wak : ${state.error}",
                  style: const TextStyle(fontSize: 20),
                ),
              );
            }
            return const SizedBox();
          },
        ),
      ),
    );
  }
}
