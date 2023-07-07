import 'package:flutter/material.dart';
import 'package:pole_paris_app/models/membership.dart';
import 'package:pole_paris_app/repositories/membership_repository.dart';
import 'package:pole_paris_app/screens/student/payment.dart';
import 'package:pole_paris_app/styles/button.dart';
import 'package:pole_paris_app/styles/color.dart';
import 'package:pole_paris_app/widgets/base/app_bar.dart';
import 'package:pole_paris_app/widgets/input.dart';
import 'package:pole_paris_app/widgets/student/buy_carnet.dart';

class BuyMembershipScreen extends StatefulWidget {
  const BuyMembershipScreen({super.key});

  @override
  State<BuyMembershipScreen> createState() => _BuyMembershipScreenState();
}

String entriesText(Membership membership) {
  if (membership.poleEntries != null && membership.fitnessEntries != null) {
    return "${membership.poleEntries} ${membership.poleEntries! < 5 ? 'wejścia' : 'wejść'} pole dance oraz ${membership.fitnessEntries} ${membership.fitnessEntries! < 5 ? 'wejścia' : 'wejść'} s+f";
  } else if (membership.poleEntries == null &&
      membership.fitnessEntries == null) {
    return 'Nielimitowane wejścia';
  } else if (membership.fitnessEntries == 0) {
    return 'Jedno wejście dziennie';
  } else {
    var entries = membership.poleEntries ?? membership.fitnessEntries;
    switch (entries!) {
      case > 4:
        return '$entries wejść';
      case > 1:
        return '$entries wejścia';
      default:
        return '$entries wejście';
    }
  }
}

class _BuyMembershipScreenState extends State<BuyMembershipScreen> {
  List<Membership> _memberships = [];
  List<Membership> _filteredList = [];
  final _searchController = TextEditingController();
  final Future<List<Membership>> _fetchMemberships =
      MembershipRepository.getAllMemberships();

  _confirmModal(Membership membership) {
    Future.delayed(
      Duration.zero,
      () => showModalBottomSheet<Membership>(
        context: context,
        builder: (context) => Container(
          width: double.infinity,
          height: MediaQuery.of(context).size.height * 0.45,
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: Container(
                    width: 62,
                    height: 4,
                    decoration: ShapeDecoration(
                      color: const Color(0xFFC4C4C4),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(4.50),
                      ),
                    ),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.only(top: 20.0),
                  child: Text(
                    'Wybrany karnet',
                    style: TextStyle(
                      color: Color(0xFF404040),
                      fontSize: 16,
                      fontFamily: 'Satoshi',
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 25.0),
                  child: Container(
                    width: 290,
                    decoration: ShapeDecoration(
                      color: Colors.white,
                      shape: RoundedRectangleBorder(
                        side: const BorderSide(
                            width: 0.50, color: Color(0xFFD9D9D9)),
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            membership.name,
                            style: const TextStyle(
                              color: Color(0xFFEE90E4),
                              fontSize: 16,
                              fontFamily: 'Satoshi',
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          Text(
                            entriesText(membership),
                            style: const TextStyle(
                              color: Color(0xFF404040),
                              fontSize: 14,
                              fontFamily: 'Satoshi',
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          Text(
                            'Ważny przez ${membership.validDays} dni od dnia zakupu',
                            style: const TextStyle(
                              color: Color(0xFF808080),
                              fontSize: 14,
                              fontFamily: 'Satoshi',
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          Text(
                            '${membership.price} PLN',
                            style: const TextStyle(
                              color: Color(0xFFEE90E4),
                              fontSize: 20,
                              fontFamily: 'Satoshi',
                              fontWeight: FontWeight.w900,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10, bottom: 15.0),
                  child: ElevatedButton(
                    onPressed: () => Navigator.of(context).pop(membership),
                    style: CustomButtonStyle.primary,
                    child: const Text('PRZEJDŹ DO PŁATNOŚCI'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ).then((value) {
        if (value != null) {
          Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => PaymentScreen(membership: membership)));
        }
      }),
    );
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _filteredList = _memberships;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BaseAppBar(
        title: 'Wykup karnet',
        appBar: AppBar(),
      ),
      body: SafeArea(
        child: FutureBuilder(
          future: _fetchMemberships,
          builder: (context, snapshot) {
            Widget result;
            if (snapshot.hasData) {
              _memberships = snapshot.data!;
              result = SingleChildScrollView(
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(
                          left: 20,
                          right: 20,
                          bottom: 20,
                        ),
                        child: Input(
                          controller: _searchController,
                          hint: 'Szukaj ...',
                          onChanged: (value) {
                            setState(() {
                              if (value.isNotEmpty) {
                                _filteredList = _memberships
                                    .where((element) => element.name
                                        .toLowerCase()
                                        .contains(value.toLowerCase()))
                                    .toList();
                              } else {
                                _filteredList = _memberships;
                              }
                            });
                          },
                          suffixIcon: const Icon(
                            Icons.search_outlined,
                            color: CustomColors.hintText,
                            size: 30,
                          ),
                        ),
                      ),
                      ...(_filteredList.isEmpty ? _memberships : _filteredList)
                          .map(
                        (e) => Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10.0),
                          child: BuyMembershipWidget(
                            membership: e,
                            onPressed: () {
                              _confirmModal(e);
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            } else if (snapshot.hasError) {
              result = const Center(
                child: Text('Błąd przy pobieraniu listy karnetów'),
              );
            } else {
              result = const Center(
                child: CircularProgressIndicator(
                  color: CustomColors.text,
                ),
              );
            }
            return result;
          },
        ),
      ),
    );
  }
}
