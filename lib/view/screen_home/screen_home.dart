import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:zaigo_test/controller/home/home_bloc.dart';
import 'package:zaigo_test/controller/login/login_bloc.dart';
import 'package:zaigo_test/model/lawyer_model.dart';
import 'package:zaigo_test/view/screen_address/screen_address.dart';
import 'package:zaigo_test/view/screen_details/screen_details.dart';
import 'package:zaigo_test/view/screen_login/screen_login.dart';

class ScreenHome extends StatelessWidget {
  const ScreenHome({super.key});

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<HomeBloc>(context).add(GetAllLawyers());
    return Scaffold(
      backgroundColor: Colors.grey[300],
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text('Lawyers'),
        actions: const [
          LogOutButton(),
        ],
      ),
      body: SafeArea(
        child: BlocBuilder<HomeBloc, HomeState>(
          builder: (context, state) {
            if (state.isLoading) {
              return const Center(
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                ),
              );
            } else if (state.lawyers.isEmpty) {
              return const Center(
                child: Text(
                  'No Lawyers found',
                  style: TextStyle(fontSize: 24),
                ),
              );
            }
            return ListView.separated(
              itemBuilder: (context, index) => LawyerCard(
                lawyer: state.lawyers[index],
              ),
              separatorBuilder: (context, index) => const SizedBox(),
              itemCount: state.lawyers.length,
            );
          },
        ),
      ),
      floatingActionButton: const FAB(),
    );
  }
}

class FAB extends StatelessWidget {
  const FAB({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => const ScreenAddress(),
          ),
        );
      },
      child: const Icon(Icons.document_scanner),
    );
  }
}

class LawyerCard extends StatelessWidget {
  const LawyerCard({
    super.key,
    required this.lawyer,
  });

  final LawyerModel lawyer;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => ScreenDetails(lawyer: lawyer),
          ),
        );
      },
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Container(
          height: 130,
          width: double.infinity,
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
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ImageWidget(image: lawyer.profilePicture),
              Details(lawyer: lawyer),
            ],
          ),
        ),
      ),
    );
  }
}

class Details extends StatelessWidget {
  const Details({
    super.key,
    required this.lawyer,
  });

  final LawyerModel lawyer;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          lawyer.name,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 5),
        Text(
          lawyer.fieldOfExpertise,
          style: TextStyle(
            fontSize: 16,
            color: Colors.grey[600],
          ),
        ),
      ],
    );
  }
}

class ImageWidget extends StatelessWidget {
  const ImageWidget({
    super.key,
    required this.image,
  });

  final String image;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      width: 100,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        image: DecorationImage(
          image: NetworkImage(image),
          fit: BoxFit.contain,
        ),
        color: Colors.white,
      ),
    );
  }
}

class LogOutButton extends StatelessWidget {
  const LogOutButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () async {
        BlocProvider.of<LoginBloc>(context).add(Reset());
        final prefs = await SharedPreferences.getInstance();
        prefs.setString('token', '').then((value) {
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(
              builder: (context) => const ScreenLogin(),
            ),
          );
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text('Log Out Successfull'),
            backgroundColor: Colors.green,
          ));
        });
      },
      icon: const Icon(
        Icons.logout_outlined,
      ),
    );
  }
}
