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
          "Select your prefered language": "Select your prefered language"
        },
        'si_LK': {"Select your prefered language": "ඔබේ කැමති භාෂාව තෝරන්න"},
        'ta_LK': {
          "Select your prefered language":
              "உங்களுக்கு விருப்பமான மொழியைத் தேர்ந்தெடுக்கவும்"
        },
      };
}
