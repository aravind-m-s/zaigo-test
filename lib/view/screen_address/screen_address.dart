import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zaigo_test/controller/address/address_bloc.dart';

class ScreenAddress extends StatelessWidget {
  const ScreenAddress({super.key});

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<AddressBloc>(context).add(GetAddress());
    return Scaffold(
      appBar: AppBar(
        title: const Text('Address'),
      ),
      backgroundColor: Colors.grey[300],
      body: SafeArea(
        child: Center(
          child: Container(
            height: 250,
            width: MediaQuery.of(context).size.width - 40,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: Colors.grey[100],
              boxShadow: const [
                BoxShadow(
                  color: Colors.grey,
                  spreadRadius: 0.5,
                  blurRadius: 10,
                  offset: Offset(10, 10),
                ),
                BoxShadow(
                  color: Colors.white,
                  spreadRadius: 0.5,
                  blurRadius: 10,
                  offset: Offset(-10, -10),
                )
              ],
            ),
            child: BlocBuilder<AddressBloc, AddressState>(
              builder: (context, state) {
                if (state.isLoading) {
                  return const Center(
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      color: Colors.orange,
                    ),
                  );
                } else if (state.isError.isNotEmpty) {
                  return Center(
                      child: Column(
                    children: [
                      Text(
                        state.isError,
                        style: const TextStyle(fontSize: 24),
                        textAlign: TextAlign.center,
                      ),
                      ElevatedButton(
                        onPressed: () {
                          BlocProvider.of<AddressBloc>(context)
                              .add(GetAddress());
                        },
                        child: const Text('Retry'),
                      )
                    ],
                  ));
                }
                return Center(
                  child: Text(
                    state.address,
                    style: const TextStyle(fontSize: 24),
                    textAlign: TextAlign.center,
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
