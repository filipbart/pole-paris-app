import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:pole_paris_app/models/user_carnet.dart';
import 'package:pole_paris_app/repositories/user_carnet_repository.dart';
import 'package:pole_paris_app/screens/teacher/accepted_carnets.dart';
import 'package:pole_paris_app/styles/button.dart';
import 'package:pole_paris_app/styles/color.dart';
import 'package:pole_paris_app/widgets/base/app_bar.dart';
import 'package:pole_paris_app/widgets/input.dart';
import 'package:pole_paris_app/widgets/student/carnet.dart';

class PendingCarnetsScreen extends StatefulWidget {
  const PendingCarnetsScreen({super.key});

  @override
  State<PendingCarnetsScreen> createState() => _PendingCarnetsScreenState();
}

class _PendingCarnetsScreenState extends State<PendingCarnetsScreen> {
  bool _loading = false;
  final searchController = TextEditingController();
  List<UserCarnet> _pendingCarnets = [];
  List<UserCarnet>? _filteredList;
  final Future<List<UserCarnet>> _fetchCarnets =
      UserCarnetRepository.getCarnetsToAccept();

  _initFilteredList() => _filteredList ??= _pendingCarnets;

  Future<void> acceptCarnet(UserCarnet carnet) async {
    setState(() {
      _loading = true;
    });
    await UserCarnetRepository.acceptUserCarnet(carnet).then((value) async {
      await UserCarnetRepository.getCarnetsToAccept().then((value) {
        setState(() {
          _filteredList = value;
          _loading = false;
        });
      }).whenComplete(() {
        setState(() {
          _loading = false;
        });
      });
    }).whenComplete(() {
      setState(() {
        _loading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BaseAppBar(
        title: 'Karnety do akceptacji',
        appBar: AppBar(),
      ),
      body: SafeArea(
        child: FutureBuilder(
          future: _fetchCarnets,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              _pendingCarnets = snapshot.data!;
              _initFilteredList();
              if (_loading) {
                return const Center(
                  child: CircularProgressIndicator(color: CustomColors.text),
                );
              } else {
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
                                _filteredList = _pendingCarnets
                                    .where((element) =>
                                        element.user.fullName
                                            .toLowerCase()
                                            .contains(value.toLowerCase()) ||
                                        element.membership.name
                                            .toLowerCase()
                                            .contains(value.toLowerCase()))
                                    .toList();
                              } else {
                                _filteredList = _pendingCarnets;
                              }
                            });
                          },
                        ),
                        const Padding(
                          padding: EdgeInsets.symmetric(vertical: 15),
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
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
                        const Padding(
                          padding: EdgeInsets.symmetric(vertical: 20.0),
                          child: Text(
                            'Nie posiadasz więcej karnetów do zaakceptowania.',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: CustomColors.buttonAdditional,
                              fontSize: 14,
                              fontFamily: 'Satoshi',
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20.0),
                          child: ElevatedButton(
                            onPressed: () => Navigator.of(context).push(
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const AcceptedCarnetsScreen())),
                            style: CustomButtonStyle.primary,
                            child: const Text('ZAAKCEPTOWANE KARNETY'),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }
            } else if (snapshot.hasError) {
              print(snapshot.error);
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
            UserCarnetWidget(
              carnet: carnet,
              onPressed: () => acceptCarnet(carnet),
              buttonText: 'AKCEPTUJ',
            ),
          ],
        ),
      );
}
