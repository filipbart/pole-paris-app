import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:pole_paris_app/models/user_carnet.dart';
import 'package:pole_paris_app/repositories/user_carnet_repository.dart';
import 'package:pole_paris_app/styles/color.dart';
import 'package:pole_paris_app/utils/membership_helper.dart';
import 'package:pole_paris_app/widgets/base/app_bar.dart';
import 'package:pole_paris_app/widgets/input.dart';

class AcceptedCarnetsScreen extends StatefulWidget {
  const AcceptedCarnetsScreen({super.key});

  @override
  State<AcceptedCarnetsScreen> createState() => _AcceptedCarnetsScreenState();
}

class _AcceptedCarnetsScreenState extends State<AcceptedCarnetsScreen> {
  final searchController = TextEditingController();
  List<UserCarnet> _acceptedCarnets = [];
  List<UserCarnet>? _filteredList;
  final Future<List<UserCarnet>> _fetchCarnets =
      UserCarnetRepository.getAcceptedCarnets();

  _initFilteredList() => _filteredList ??= _acceptedCarnets;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BaseAppBar(
        title: 'Zaakceptowane karnety',
        appBar: AppBar(),
      ),
      body: SafeArea(
        child: FutureBuilder(
          future: _fetchCarnets,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              _acceptedCarnets = snapshot.data!;
              _initFilteredList();
              return SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Input(
                        controller: searchController,
                        hint: 'Szukaj ...',
                        suffixIcon: const Icon(
                          Icons.search_outlined,
                          color: CustomColors.hintText,
                          size: 30,
                        ),
                        onChanged: (value) {
                          setState(() {
                            if (value != '') {
                              _filteredList = _acceptedCarnets
                                  .where((element) =>
                                      element.user.fullName
                                          .toLowerCase()
                                          .contains(value.toLowerCase()) ||
                                      element.membership.name
                                          .toLowerCase()
                                          .contains(value.toLowerCase()))
                                  .toList();
                            } else {
                              _filteredList = _acceptedCarnets;
                            }
                          });
                        },
                      ),
                      const Padding(
                        padding: EdgeInsets.symmetric(vertical: 15),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                FittedBox(
                                  fit: BoxFit.fitWidth,
                                  child: Text(
                                    'Imię i nazwisko kursanta',
                                    style: TextStyle(
                                      color: CustomColors.hintText,
                                      fontSize: 14,
                                      fontFamily: 'Satoshi',
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                                FittedBox(
                                  fit: BoxFit.fitWidth,
                                  child: Text(
                                    'Data wybrania karnetu',
                                    style: TextStyle(
                                      color: CustomColors.hintText,
                                      fontSize: 14,
                                      fontFamily: 'Satoshi',
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Divider(
                              color: CustomColors.hintText,
                              thickness: 0.25,
                            ),
                          ],
                        ),
                      ),
                      ..._filteredList!.map((e) => _buildCarnetForAccept(e)),
                      if (_acceptedCarnets.isEmpty)
                        const Center(
                          child: Text('Brak zaakceptowanych karnetów'),
                        ),
                    ],
                  ),
                ),
              );
            } else if (snapshot.hasError) {
              return const Center(
                child: Text('Błąd przy pobieraniu listy karnetów'),
              );
            } else {
              return const Center(
                child: CircularProgressIndicator(
                  color: CustomColors.text,
                ),
              );
            }
          },
        ),
      ),
    );
  }

  Widget _buildCarnetForAccept(UserCarnet carnet) => Padding(
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    carnet.user.fullName,
                    style: const TextStyle(
                      color: Color(0xFF1E1E1E),
                      fontSize: 16,
                      fontFamily: 'Satoshi',
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Text(
                    DateFormat('dd.MM.yyyy').format(carnet.dateCreatedUtc),
                    style: const TextStyle(
                      color: Color(0xFF1E1E1E),
                      fontSize: 16,
                      fontFamily: 'Satoshi',
                      fontWeight: FontWeight.w900,
                    ),
                  )
                ],
              ),
            ),
            Container(
              decoration: BoxDecoration(
                color: const Color(0xFFABABAB),
                border: Border.all(color: const Color(0xFFABABAB)),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Flexible(
                      flex: 2,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            carnet.membership.name,
                            style: const TextStyle(
                              color: CustomColors.text,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            MembershipHelper.entriesText(carnet.membership),
                            style: const TextStyle(
                              color: CustomColors.text3,
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 5.0),
                            child: Text(
                              'Ważny przez ${carnet.membership.validDays} dni od dnia zakupu',
                              style: const TextStyle(
                                color: CustomColors.text3,
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Flexible(
                      flex: 2,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            '${carnet.membership.price} PLN',
                            style: const TextStyle(
                              color: CustomColors.text,
                              fontSize: 20,
                              fontFamily: 'Satoshi',
                              fontWeight: FontWeight.w900,
                            ),
                          ),
                          const Text(
                            'ZAAKCEPTOWANO',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 16,
                              fontFamily: 'Satoshi',
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      );
}
