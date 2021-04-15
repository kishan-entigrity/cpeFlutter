import 'package:cpe_flutter/screens/intro_login_signup/model/city_list_model.dart';
import 'package:cpe_flutter/screens/intro_login_signup/model/country_list_model.dart';
import 'package:cpe_flutter/screens/intro_login_signup/model/industries_model.dart';
import 'package:cpe_flutter/screens/intro_login_signup/model/job_titles_model.dart';
import 'package:cpe_flutter/screens/intro_login_signup/model/prof_creds_model.dart';
import 'package:cpe_flutter/screens/intro_login_signup/model/state_list_model.dart';

class ConstSignUp {
  // SignUp Screen 1 Data..
  static var strFname = '';
  static var strLname = '';
  static var strEmail = '';
  static var strPhone = '';
  static var strExt = '';
  static var strMobile = '';
  static var strPass = '';
  static var strConfPass = '';

  // SignUp Screen 2 Data..
  static var strCompanyName = '';

  static List<String> orgSizeList = ['0-9', '10-15', '16-50', '51-500', '501-1000', '1000+'];
  // static var strOrgSize = '';
  static var organizationSize = '';
  static var isOrganizationSizeSelected = false;

  static List<Job_title> listJobTitle;
  static int arrCountJTitle = 0;
  static var jobTitleId;
  static var data_web_jtitle;
  static var dataJTitle;
  static var jobTitle = '';
  static var isJobTitleSelected = false;

  static List<Industries_list> listIndustries;
  static int arrCountIndustries = 0;
  static var industryId;
  static var data_web_industries;
  static var dataIndustries;
  static var industry = '';
  static var isIndustrySelected = false;

  static List<User_type> listProfCreds;
  static List<String> smallTitles = [];
  static List<String> smallTitlesId = [];
  static int arrCountProf = 0;
  static var data_web_prof;
  static var data_prof;
  static var user_type_ids = '';

  // SignUp screen 3 data..
  static List<Country> listCountry;
  static int arrCountCountry = 0;
  static var respCountry;
  static var respCountryData;
  static var selectedCountryName = '';
  static var selectedCountryId = 0;
  static bool isCountrySelected = false;

  static List<State_Name> listState;
  static int arrCountState = 0;
  static var respState;
  static var respStateData;
  static var selectedStateName = '';
  static var selectedStateId = 0;
  static bool isStateSelected = false;

  static List<City> listCity;
  static int arrCountCity = 0;
  static var respCity;
  static var respCityData;
  static var selectedCityName = '';
  static var selectedCityId = 0;
  static bool isCitySelected = false;

  static var strPTIN = '';
  static var strCTEC = '';
  static var strCFP = '';
  static var strZipCode = '';

  static bool isRegisterWebinarFromDetails = false;

  static bool isGuestRegisterWebinar = false;

  static void cleanSignUpData() {
    // Reset screen 1 data..
    ConstSignUp.strFname = '';
    ConstSignUp.strLname = '';
    ConstSignUp.strEmail = '';
    ConstSignUp.strPhone = '';
    ConstSignUp.strExt = '';
    ConstSignUp.strMobile = '';
    ConstSignUp.strPass = '';
    ConstSignUp.strConfPass = '';

    // Reset screen 2 data..
    ConstSignUp.strCompanyName = '';
    ConstSignUp.organizationSize = '';
    ConstSignUp.isOrganizationSizeSelected = false;

    ConstSignUp.arrCountJTitle = 0;
    ConstSignUp.jobTitleId = 0;
    ConstSignUp.jobTitle = '';
    ConstSignUp.isJobTitleSelected = false;

    ConstSignUp.arrCountIndustries = 0;
    ConstSignUp.industryId = 0;
    ConstSignUp.industry = '';
    ConstSignUp.isIndustrySelected = false;

    ConstSignUp.smallTitles.clear();
    ConstSignUp.smallTitlesId.clear();
    ConstSignUp.arrCountProf = 0;
    ConstSignUp.user_type_ids = '';

    ConstSignUp.arrCountCountry = 0;
    ConstSignUp.selectedCountryName = '';
    ConstSignUp.selectedCountryId = 0;
    ConstSignUp.isCountrySelected = false;

    ConstSignUp.arrCountState = 0;
    ConstSignUp.selectedStateName = '';
    ConstSignUp.selectedStateId = 0;
    ConstSignUp.isStateSelected = false;

    ConstSignUp.arrCountCity = 0;
    ConstSignUp.selectedCityName = '';
    ConstSignUp.selectedCityId = 0;
    ConstSignUp.isCitySelected = false;

    ConstSignUp.strPTIN = '';
    ConstSignUp.strCTEC = '';
    ConstSignUp.strCFP = '';
    ConstSignUp.strZipCode = '';
  }

  static var strSelectedMonth = '';
  static var strSelectedYear = '';

  static List<String> monthList = ['01', '02', '03', '04', '05', '06', '07', '08', '09', '10', '11', '12'];
  static List<String> yearList = [
    '2021',
    '2022',
    '2023',
    '2024',
    '2025',
    '2026',
    '2027',
    '2028',
    '2029',
    '2030',
    '2031',
    '2032',
    '2033',
    '2034',
    '2035',
    '2036',
    '2037',
    '2038',
    '2039',
    '2040',
    '2041',
    '2042',
    '2043',
    '2044',
    '2045',
    '2046',
    '2047',
    '2048',
    '2049',
    '2050'
  ];
}
