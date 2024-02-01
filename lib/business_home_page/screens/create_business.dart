import 'package:bizissue/business_home_page/screens/controller/create_business_controller.dart';
import 'package:bizissue/home/screens/controllers/home_controller.dart';
import 'package:bizissue/widgets/buttons/custom_back_button.dart';
import 'package:bizissue/widgets/custom_text_field.dart';
import 'package:bizissue/widgets/submit_button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CreateBusinessPage extends StatefulWidget {
  @override
  _CreateBusinessPageState createState() => _CreateBusinessPageState();
}

class _CreateBusinessPageState extends State<CreateBusinessPage> {

  @override
  Widget build(BuildContext context) {
    final homeController = Provider.of<HomeProvider>(context, listen: false);

    final createBusinessController = Provider.of<CreateBusinessProvider>(context, listen: false);

    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(height * .19),
        child: Padding(
          padding: EdgeInsets.symmetric(
              vertical: height * 0.02, horizontal: width * .04),
          child: Row(
            children: [
              CustomBackButton(
              ),
              SizedBox(width: 20),
              Text(
                "Create Business",
                style: TextStyle(
                    color: Colors.black,
                    fontFamily: "Poppins",
                    fontWeight: FontWeight.bold,
                    fontSize: 18),
              ),
            ],
          ),
        ),
      ),

      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(left: 15, right: 15),
          child: Column(
            children: [

              CustomTextField(
                controller: createBusinessController.nameController,
                onChanged: (p0) => createBusinessController.updateBusinessName(p0 ?? ""),
                labelText: "Name*",
              ),
              SizedBox(height: height * 0.02),

              CustomTextField(
                controller: createBusinessController.industryTypeController,
                onChanged: (p0) => createBusinessController.updateBusinessIndustryType(p0 ?? ""),
                labelText: "Industry type",
              ),
              SizedBox(height: height * 0.02),

              CustomTextField(
                controller: createBusinessController.cityController,
                onChanged: (p0) => createBusinessController.updateBusinessCity(p0 ?? ""),
                labelText: "City",
              ),
              SizedBox(height: height * 0.02),

              CustomTextField(
                controller: createBusinessController.countryController,
                onChanged: (p0) => createBusinessController.updateBusinessCountry(p0 ?? ""),
                labelText: "Country",
              ),
              SizedBox(height: height * 0.02),

              SubmitButton(
                onPressed: () {
                  createBusinessController.createBusiness(context);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
