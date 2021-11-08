import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:get/get.dart';

class LocalString extends Translations {
  @override
  Map<String, Map<String, String>> get keys => {
        // 'en_US':
        //     json.decode(rootBundle.loadString('assets/lan/en.json').toString()),
        // 'si_LK':
        //     json.decode(rootBundle.loadString('assets/lan/si.json').toString()),
        // 'ta_lk':
        //     json.decode(rootBundle.loadString('assets/lan/ta.json').toString()),
        'en_US': {
          "Select your prefered language": "Select your prefered language",
          "gettingStart": "Let's get started now",
          "otpConfirm": "Confirm your number",
          "otpConfirmText": "Enter the 6-digit code, just sent to ",
          "chooseVehicle": "Choose your vehicle type",
          "driver-profileComplete-subtitle":
              "Complete following steps to set up your account",
          "driver-profileComplete-profile-picture": "Profile picture",
          "driver-profileComplete-driving-license": "Driving License",
          "driver-profileComplete-vehicle-insurance":
              "Vehicle insurance (Third party/ Private/ Hiring)",
          "driver-profileComplete-revenue-license": "Revenue License",
          "driver-profileComplete-vehicle-reg": "Vehicle Registration Document",
        },
        'si_LK': {
          "Select your prefered language": "ඔබේ කැමති භාෂාව තෝරන්න",
          "gettingStart": "ලීයාපදිංචි වීම අරඹන්න",
          "otpConfirm": "ඔබගේ අංකය තහවුරු කරන්න",
          "otpConfirmText": "ඉලක්කම්-6ක කේතය ඇතුළත් කරන්න. ",
          "chooseVehicle": "ඔබේ වාහන වර්ගය තෝරන්න",
          "driver-profileComplete-subtitle":
              "ඔබගේ ගිණුම පිහිටුවීමට පහත පියවර සම්පූර්ණ කරන්න",
          "driver-profileComplete-profile-picture": "ඔබගේ පින්තූරයක්",
          "driver-profileComplete-driving-license": "රියැදුරු බලපත්‍රය",
          "driver-profileComplete-vehicle-insurance":
              "වාහන රක්ෂණය (තෙවන පාර්ශවය/ පුද්ගලික/ කුලියට ගැනීම)",
          "driver-profileComplete-revenue-license": "ආදායම් බලපත්‍රය",
          "driver-profileComplete-vehicle-reg": "වාහන ලියාපදිංචි ලේඛනය",
        },
        'ta_LK': {
          "Select your prefered language":
              "உங்களுக்கு விருப்பமான மொழியைத் தேர்ந்தெடுக்கவும்",
          "gettingStart": "இப்போது தொடங்குவோம்",
          "otpConfirm": "உங்கள் எண்ணை உறுதிப்படுத்தவும்",
          "otpConfirmText":
              "6 இலக்கக் குறியீட்டை உள்ளிடவும், இப்போது அனுப்பப்பட்டது",
          "chooseVehicle": "உங்கள் வாகன வகையைத் தேர்வு செய்யவும்",
          "driver-profileComplete-subtitle":
              "உங்கள் கணக்கை அமைக்க பின்வரும் படிகளை முடிக்கவும்",
          "driver-profileComplete-profile-picture": "சுயவிவர படம்",
          "driver-profileComplete-driving-license": "ஓட்டுனர் உரிமம்",
          "driver-profileComplete-vehicle-insurance":
              "வாகன காப்பீடு (மூன்றாம் நபர்/ தனியார்/ பணியமர்த்தல்)",
          "driver-profileComplete-revenue-license": "வருவாய் உரிமம்",
          "driver-profileComplete-vehicle-reg": "வாகனப் பதிவு ஆவணம்",
        },
      };
}
