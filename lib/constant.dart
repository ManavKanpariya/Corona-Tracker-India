import 'package:flutter/material.dart';

// Colors
const kBackgroundColor = Color(0xFFFEFEFE);
const kTitleTextColor = Color(0xFF303030);
const kBodyTextColor = Color(0xFF4B4B4B);
const kTextLightColor = Color(0xFF959595);
const kInfectedColor = Color(0xFFFF8748);
const kDeathColor = Color(0xFFFF4848);
const kRecovercolor = Color(0xFF36C12C);
const kPrimaryColor = Color(0xFF3382CC);
const kAppBarHeadingColor = Color(0xFF1a1c6b);
final kShadowColor = Color(0xFFB7B7B7).withOpacity(.16);
final kActiveShadowColor = Color(0xFF4056C6).withOpacity(.15);

AppBar kAppBar =  AppBar(
        backgroundColor: kAppBarHeadingColor,
        title: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 20),
       
              child: Text("Corona Tracker".toUpperCase(),style: TextStyle(
                fontSize: 30,
              ),),
           
          ),
        ),
      );

// Text Style
const kHeadingTextStyle = TextStyle(
  fontSize: 22,
  fontWeight: FontWeight.w600,
);

const kSubTextStyle = TextStyle(fontSize: 16, color: kTextLightColor);

const kTitleTextstyle = TextStyle(
  fontSize: 18,
  color: kTitleTextColor,
  fontWeight: FontWeight.bold,
);

const Map<String,String> kDropDownMenuList={
 'Gujarat':'GJ',
'Andhra Pradesh':'AP',
'Arunachal Pradesh':'AR',
'Assam':'AS',
'Bihar':'BR',
'Chhattisgarh':'CH',
'Goa':'GA',
'Delhi':'DL',
'Haryana':'HR',
'Himachal Pradesh':'HP',
'Jharkhand':'JH',
'Jammu Kashmir':'JK',
'Karnataka':'KA',
'Kerala':'KL',
'Leh Ladakh':'LA',
'Madhya Pradesh':'MP',	
'Maharashtra':'MH',
'Manipur':'MN',
'Meghalaya':'ML',
'Mizoram':'MZ',
'Nagaland':'NL',
'Odisha':'OR',
'Punjab':'PB',
'Rajasthan':'RJ',
'Sikkim':'SK',
'Tamil Nadu':'TN',
'Telangana':'TG',
'Tripura':'TR',
'Uttar Pradesh':'UP',
'Uttarakhand':'UT',
'West Bengal':'WB',
};
