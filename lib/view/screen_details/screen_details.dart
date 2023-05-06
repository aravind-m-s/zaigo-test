import 'package:flutter/material.dart';
import 'package:zaigo_test/model/lawyer_model.dart';

class ScreenDetails extends StatelessWidget {
  const ScreenDetails({super.key, required this.lawyer});

  final LawyerModel lawyer;

  @override
  Widget build(BuildContext context) {
    const kHeight10 = SizedBox(height: 10);
    const kHeight20 = SizedBox(height: 20);
    return Scaffold(
      backgroundColor: Colors.grey[300],
      appBar: AppBar(
        title: Text(lawyer.name),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            children: [
              const SizedBox(height: 50),
              ImageWidget(lawyer: lawyer),
              kHeight20,
              lawyer.name.isNotEmpty
                  ? NameAndRating(lawyer: lawyer)
                  : const SizedBox(),
              lawyer.fieldOfExpertise.isNotEmpty
                  ? lawyer.level.isEmpty
                      ? Text(
                          '${lawyer.fieldOfExpertise} Lawyer',
                          style: const TextStyle(fontSize: 15),
                        )
                      : Text(
                          '${lawyer.level} level - ${lawyer.fieldOfExpertise} Lawyer',
                          style: const TextStyle(fontSize: 15),
                        )
                  : const SizedBox(),
              kHeight20,
              lawyer.bio.isNotEmpty
                  ? Column(
                      children: [
                        const Text(
                          'Lawyer description',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        kHeight10,
                        Text(lawyer.bio),
                        kHeight10,
                      ],
                    )
                  : const SizedBox(),
              lawyer.state != '' && lawyer.address != ''
                  ? Location(lawyer: lawyer)
                  : const SizedBox(),
              kHeight20,
              lawyer.phoneNo.isNotEmpty
                  ? Mobile(lawyer: lawyer)
                  : const SizedBox(),
              kHeight20,
              lawyer.email.isNotEmpty
                  ? Email(lawyer: lawyer)
                  : const SizedBox(),
            ],
          ),
        ),
      ),
    );
  }
}

class Email extends StatelessWidget {
  const Email({
    super.key,
    required this.lawyer,
  });

  final LawyerModel lawyer;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Icon(
          Icons.mail,
          size: 30,
          color: Colors.purple,
        ),
        const SizedBox(width: 10),
        Text(
          lawyer.email,
          style: const TextStyle(fontSize: 18),
        )
      ],
    );
  }
}

class Mobile extends StatelessWidget {
  const Mobile({
    super.key,
    required this.lawyer,
  });

  final LawyerModel lawyer;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Icon(
          Icons.phone,
          size: 30,
          color: Colors.purple,
        ),
        const SizedBox(width: 10),
        Text(
          lawyer.phoneNo,
          style: const TextStyle(fontSize: 18),
        )
      ],
    );
  }
}

class Location extends StatelessWidget {
  const Location({
    super.key,
    required this.lawyer,
  });

  final LawyerModel lawyer;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Text(
          'Location:  ',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        Text('${lawyer.address}, ${lawyer.state}')
      ],
    );
  }
}

class NameAndRating extends StatelessWidget {
  const NameAndRating({
    super.key,
    required this.lawyer,
  });

  final LawyerModel lawyer;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          '${lawyer.name}   -',
          style: const TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(width: 20),
        Text(
          lawyer.rating,
          style: const TextStyle(fontSize: 20),
        ),
        const SizedBox(width: 5),
        const Icon(
          Icons.star,
          color: Colors.orange,
        )
      ],
    );
  }
}

class ImageWidget extends StatelessWidget {
  const ImageWidget({
    super.key,
    required this.lawyer,
  });

  final LawyerModel lawyer;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 150,
      width: 150,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Colors.grey[200],
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
        image: DecorationImage(
          image: NetworkImage(lawyer.profilePicture),
          fit: BoxFit.contain,
        ),
      ),
    );
  }
}
