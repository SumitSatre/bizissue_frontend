// ignore_for_file: depend_on_referenced_packages
/*
import 'package:bizissue/business_home_page/models/user_profile_model.model.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:toggle_switch/toggle_switch.dart';

class ProfileCard extends StatelessWidget {
  const ProfileCard(
      {super.key,
        required this.userProfile,);
  final UserProfile userProfile;
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Stack(children: [
      Column(
        children: [
          SizedBox(
            height: height * 0.05,
          ),
          Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: GlobalVariables.secondaryColor),
            child: Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: width * 0.04, vertical: height * 0.02),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  InkWell(
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => LiveLocation(uid: id)));
                    },
                    child: Row(
                      children: [
                        const Icon(Icons.location_searching),
                        SizedBox(
                          width: width * 0.01,
                        ),
                        Text(
                          "Live Location",
                          style: GoogleFonts.openSans(
                            fontSize: width * 0.037,
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                          ),
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: height * 0.04,
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => EditEmployee(
                            uid: id,
                          ),
                        ),
                      );
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          name,
                          style: GoogleFonts.openSans(
                              fontWeight: FontWeight.bold,
                              fontSize: width * 0.06,
                              color: Colors.white),
                        ),
                        SizedBox(
                          width: width * 0.01,
                        ),
                        const Icon(
                          Icons.edit_note_rounded,
                          color: Colors.white,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: height * 0.02,
                  ),
                  Text(
                    jobTitle,
                    style: GoogleFonts.openSans(
                        fontSize: width * 0.038, color: Colors.white),
                  ),
                  const Divider(
                    color: Colors.grey,
                    thickness: 1,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        mobileNumber,
                        style: GoogleFonts.openSans(
                            fontSize: width * 0.038, color: Colors.white),
                      ),
                      Text(
                        email,
                        style: GoogleFonts.openSans(
                            fontSize: width * 0.038, color: Colors.white),
                      ),
                    ],
                  ),
                  const Divider(
                    color: Colors.grey,
                    thickness: 1,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Date of Joining',
                        style: GoogleFonts.openSans(
                            fontSize: width * 0.038, color: Colors.white),
                      ),
                      Text(
                        '10/10/2003',
                        style: GoogleFonts.openSans(
                            fontSize: width * 0.038, color: Colors.white),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: height * 0.01,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Date of Birth',
                        style: GoogleFonts.openSans(
                            fontSize: width * 0.038, color: Colors.white),
                      ),
                      Text(
                        dob,
                        style: GoogleFonts.openSans(
                            fontSize: width * 0.038, color: Colors.white),
                      ),
                    ],
                  ),
                  const Divider(
                    color: Colors.grey,
                    thickness: 1,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Monthly Salary',
                        style: GoogleFonts.openSans(
                            fontSize: width * 0.038, color: Colors.white),
                      ),
                      Text(
                        salary,
                        style: GoogleFonts.openSans(
                            fontSize: width * 0.038, color: Colors.white),
                      ),
                    ],
                  ),
                  const Divider(
                    color: Colors.grey,
                    thickness: 1,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Lock/Unlock Attendance',
                        style: GoogleFonts.openSans(
                            fontSize: width * 0.038, color: Colors.white),
                      ),
                      ToggleSwitch(
                        minHeight: height * 0.04,
                        minWidth: width * 0.2,
                        cornerRadius: 20.0,
                        activeBgColors: [
                          [Colors.red[800]!],
                          [Colors.green[800]!],
                        ],
                        activeFgColor: Colors.white,
                        inactiveBgColor: Colors.grey,
                        inactiveFgColor: Colors.white,
                        initialLabelIndex: isFreezed == true ? 1 : 0,
                        totalSwitches: 2,
                        labels: const ['Lock', 'Unlock'],
                        radiusStyle: true,
                        onToggle: (index) async {
                          if (index == 0) {
                            await EmpDataRepo().freezeAttendace(token, id);
                            // context.read<EmpProfileBloc>().add(
                            //     EmpProfileOnFreezeAttendancePressed(
                            //         token: token, id: id));
                          } else {
                            await EmpDataRepo().unFreezeAttendace(token, id);
                            // context.read<EmpProfileBloc>().add(
                            //     EmpProfileOnUnFreezeAttendancePressed(
                            //         token: token, id: id));
                          }
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    ]);
  }
}
*/