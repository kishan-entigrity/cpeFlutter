import 'package:cpe_flutter/screens/intro_login_signup/model/industries_model.dart';
import 'package:cpe_flutter/screens/intro_login_signup/model/job_titles_model.dart';
import 'package:cpe_flutter/screens/intro_login_signup/model/prof_creds_model.dart';

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
  static var data_web_jtitle;
  static var dataJTitle;
  static var jobTitle = '';
  static var isJobTitleSelected = false;

  static List<Industries_list> listIndustries;
  static int arrCountIndustries = 0;
  static var data_web_industries;
  static var dataIndustries;
  static var industry = '';
  static var isIndustrySelected = false;

  static List<User_type> listProfCreds;
  static List<String> smallTitles = [];
  static int arrCountProf = 0;
  static var data_web_prof;
  static var data_prof;

  // SignUp screen 3 data..

}
