package com.parser;
import com.h.Payment_history;
import com.h.Account_status;
import com.h.Payment_headers;
import com.h.Consumer_accounts;
import com.h.Adverse;
import com.h.Property;
import com.h.Enquiries;
import com.h.Summary;
import org.json.JSONArray;
import org.json.JSONObject;
import java.util.ArrayList;
import com.h.Judgements;
import com.h.Personal_details;
import com.h.Scoring;
import com.h.Default_listing;
import com.h.Court_notices;
import com.h.Fraud_indicators;
import com.h.Consumer_account_types;
import com.h.Val;
public class ValParser extends BaseParser{
	private final static String JSON_KEY_DEBT_REVIEW_STATUS="debt_review_status";
	private final static String JSON_KEY_ARREARS_AMOUNT="arrears_amount";
	private final static String JSON_KEY_JUDGEMENTS="judgements";
	private final static String JSON_KEY_PAYMENT_HEADERS="payment_headers";
	private final static String JSON_KEY_FINAL_SCORE="final_score";
	private final static String JSON_KEY_LOAN_ACCOUNTS_CLOSED="loan_accounts_closed";
	private final static String JSON_KEY_LOAN_ENQUIRIES="loan_enquiries";
	private final static String JSON_KEY_O="O";
	private final static String JSON_KEY_#="#";
	private final static String JSON_KEY_LOAN_MAX_MONTH_IN_ARREARS="loan_max_month_in_arrears";
	private final static String JSON_KEY_11="11";
	private final static String JSON_KEY_LOAN_INSTALMENTS="loan_instalments";
	private final static String JSON_KEY_CONSUMER_ADVERSE_AMOUNT="consumer_adverse_amount";
	private final static String JSON_KEY_PERSONAL_DETAILS="personal_details";
	private final static String JSON_KEY_TITLE="title";
	private final static String JSON_KEY_FRAUD_NOTICES="fraud_notices";
	private final static String JSON_KEY_01="01";
	private final static String JSON_KEY_LOAN_SELF_ENQUIRIES="loan_self_enquiries";
	private final static String JSON_KEY_14="14";
	private final static String JSON_KEY_REFERENCE_NO="reference_no";
	private final static String JSON_KEY_09="09";
	private final static String JSON_KEY_DEFAULT_LISTINGS="default_listings";
	private final static String JSON_KEY_CONSUMER_SELF_ENQUIRIES="consumer_self_enquiries";
	private final static String JSON_KEY_R="R";
	private final static String JSON_KEY_CONSUMER_INSTALMENTS="consumer_instalments";
	private final static String JSON_KEY_CONSUMER_ACCOUNTS_IN_GOOD="consumer_accounts_in_good";
	private final static String JSON_KEY_DECEASED_DATE="deceased_date";
	private final static String JSON_KEY_COUNT="count";
	private final static String JSON_KEY_MIDDLE_NAME="middle_name";
	private final static String JSON_KEY_LOAN_ADVERSE_AMOUNT="loan_adverse_amount";
	private final static String JSON_KEY_MARITAL_STATUS="marital_status";
	private final static String JSON_KEY_AB="AB";
	private final static String JSON_KEY_CONSUMER_ENQUIRIES="consumer_enquiries";
	private final static String JSON_KEY_U="U";
	private final static String JSON_KEY_SUMMARY="summary";
	private final static String JSON_KEY_CREATED="created";
	private final static String JSON_KEY_T="T";
	private final static String JSON_KEY_GENDER="gender";
	private final static String JSON_KEY_LOAN_ARREARS="loan_arrears";
	private final static String JSON_KEY_04="04";
	private final static String JSON_KEY_EMPLOYER_FRAUD_VERIFICATION="employer_fraud_verification";
	private final static String JSON_KEY_CONSUMER_ACCOUNTS_IN_ARREARS="consumer_accounts_in_arrears";
	private final static String JSON_KEY_LOAN_ACCOUNTS="loan_accounts";
	private final static String JSON_KEY_16="16";
	private final static String JSON_KEY_06="06";
	private final static String JSON_KEY_LOAN_DEBT="loan_debt";
	private final static String JSON_KEY_22="22";
	private final static String JSON_KEY_AA="AA";
	private final static String JSON_KEY_SCORE_DATE="score_date";
	private final static String JSON_KEY_PROPERTY="property";
	private final static String JSON_KEY_ENQUIRIES="enquiries";
	private final static String JSON_KEY_RISK_CATEGORY="risk_category";
	private final static String JSON_KEY_LOAN_ACCOUNTS_ACTIVE="loan_accounts_active";
	private final static String JSON_KEY_ID_NUMBER="id_number";
	private final static String JSON_KEY_POSTAL_ADDRESS="postal_address";
	private final static String JSON_KEY_B="B";
	private final static String JSON_KEY_CREDIT_PROVDER_TYPE="credit_provder_type";
	private final static String JSON_KEY_CONSUMER_NEW_ACCOUNTS="consumer_new_accounts";
	private final static String JSON_KEY_CREDIT_PROVIDER="credit_provider";
	private final static String JSON_KEY_PROTECTIVE_VERIFICATION="protective_verification";
	private final static String JSON_KEY_I="I";
	private final static String JSON_KEY_S="S";
	private final static String JSON_KEY_CONSUMER_ACCOUNTS_CLOSED="consumer_accounts_closed";
	private final static String JSON_KEY_NEGATIVE_INFORMATION="negative_information";
	private final static String JSON_KEY_CONSUMER_ACCOUNTS="consumer_accounts";
	private final static String JSON_KEY_DISPUTE_STATUS="dispute_status";
	private final static String JSON_KEY_CURRENT_EMPLOYER="current_employer";
	private final static String JSON_KEY_18="18";
	private final static String JSON_KEY_SURNAME="surname";
	private final static String JSON_KEY_EMAIL="email";
	private final static String JSON_KEY_DEFAULT_LISTING="default_listing";
	private final static String JSON_KEY_DECEASED_STATUS="deceased_status";
	private final static String JSON_KEY_WORK_PHONE="work_phone";
	private final static String JSON_KEY_LAST_PAYMENT="last_payment";
	private final static String JSON_KEY_15="15";
	private final static String JSON_KEY_24="24";
	private final static String JSON_KEY_17="17";
	private final static String JSON_KEY_TYPE="type";
	private final static String JSON_KEY_PASSPORT_NUMBER="passport_number";
	private final static String JSON_KEY_STATUS="status";
	private final static String JSON_KEY_03="03";
	private final static String JSON_KEY_X="X";
	private final static String JSON_KEY_SUBSCRIBER_ID="subscriber_id";
	private final static String JSON_KEY_08="08";
	private final static String JSON_KEY_G="G";
	private final static String JSON_KEY_21="21";
	private final static String JSON_KEY_1-9="1-9";
	private final static String JSON_KEY_E="E";
	private final static String JSON_KEY_*="*";
	private final static String JSON_KEY_12="12";
	private final static String JSON_KEY_ADMIN_ORDERS="admin_orders";
	private final static String JSON_KEY_05="05";
	private final static String JSON_KEY_ID="id";
	private final static String JSON_KEY_Z="Z";
	private final static String JSON_KEY_V="V";
	private final static String JSON_KEY_C="C";
	private final static String JSON_KEY_HOME_PHONE="home_phone";
	private final static String JSON_KEY_LOAN_ACCOUNTS_IN_ARREARS="loan_accounts_in_arrears";
	private final static String JSON_KEY_CONSUMER_ACCOUNTS_ACTIVE="consumer_accounts_active";
	private final static String JSON_KEY_ADVERSE_DEFAULTS="adverse_defaults";
	private final static String JSON_KEY_PAYMENT_HISTORY="payment_history";
	private final static String JSON_KEY_REHABILITATION_ORDERS="rehabilitation_orders";
	private final static String JSON_KEY_DEBT_REVIEW="debt_review";
	private final static String JSON_KEY_LOAN_NEW_ACCOUNTS="loan_new_accounts";
	private final static String JSON_KEY_PAYMENT_NOTIFICATIONS="payment_notifications";
	private final static String JSON_KEY_02="02";
	private final static String JSON_KEY_LINK="link";
	private final static String JSON_KEY_FIRST_NAME="first_name";
	private final static String JSON_KEY_INSTALMENT_AMOUNT="instalment_amount";
	private final static String JSON_KEY_CURRENT_BALANCE="current_balance";
	private final static String JSON_KEY_SITE_ID="site_id";
	private final static String JSON_KEY_CONSUMER_MAX_MONTH_IN_ARREARS="consumer_max_month_in_arrears";
	private final static String JSON_KEY_N="N";
	private final static String JSON_KEY_SEQUESTRATIONS="sequestrations";
	private final static String JSON_KEY_RESIDENTIAL_ADDRESS="residential_address";
	private final static String JSON_KEY_FRAUD_INDICATORS="fraud_indicators";
	private final static String JSON_KEY_10="10";
	private final static String JSON_KEY_23="23";
	private final static String JSON_KEY_19="19";
	private final static String JSON_KEY_CREDIT_LIMIT="credit_limit";
	private final static String JSON_KEY_LOAN_ACCOUNTS_IN_GOOD="loan_accounts_in_good";
	private final static String JSON_KEY_MOBILE_PHONE="mobile_phone";
	private final static String JSON_KEY_REASON="reason";
	private final static String JSON_KEY_ACCOUNT_STATUS="account_status";
	private final static String JSON_KEY_COURT_NOTICES="court_notices";
	private final static String JSON_KEY_L="L";
	private final static String JSON_KEY_EXTERNAL_REFERENCE="external_reference";
	private final static String JSON_KEY_W="W";
	private final static String JSON_KEY_13="13";
	private final static String JSON_KEY_CONSUMER_DEBT="consumer_debt";
	private final static String JSON_KEY_SCORING="scoring";
	private final static String JSON_KEY_J="J";
	private final static String JSON_KEY_ADVERSE="adverse";
	private final static String JSON_KEY_M="M";
	private final static String JSON_KEY_20="20";
	private final static String JSON_KEY_D="D";
	private final static String JSON_KEY_F="F";
	private final static String JSON_KEY_CONSUMER_ACCOUNT_TYPES="consumer_account_types";
	private final static String JSON_KEY_H="H";
	private final static String JSON_KEY_SUBSCRIBER_NAME="subscriber_name";
	private final static String JSON_KEY_DATE_OF_BIRTH="date_of_birth";
	private final static String JSON_KEY_AMOUNT="amount";
	private final static String JSON_KEY_07="07";
	private final static String JSON_KEY_HOME_AFFAIRS_VERIFICATION="home_affairs_verification";
	private final static String JSON_KEY_EXCEPTION_CODE="exception_code";
	private final static String JSON_KEY_SAFPS_LISTING="safps_listing";
	private final static String JSON_KEY_0="0";
	private final static String JSON_KEY_P="P";
	private final static String JSON_KEY_CONSUMER_ARREARS="consumer_arrears";
	private final static String JSON_KEY_PAYMENT_HISTORY_TYPES="payment_history_types";
	private final static String JSON_KEY_DATE="date";
	private final static String JSON_KEY_K="K";
	private final static String JSON_KEY_ACCOUNT_NUMBER="account_number";



//Invoke this method to parse response json string
	public static Val parseVal(String responseJson){
		JSONObject jsonObject=new JSONObject(responseJson);
		Val val=new Val();
		if(jsonObject!=null)
		{
			
			val.setSummary(parseSummary(getJSONObject(jsonObject,JSON_KEY_SUMMARY)));
			val.setAdverse_defaults(parseAdverse_defaults(getJSONArray(jsonObject,JSON_KEY_ADVERSE_DEFAULTS)));
			val.setAdmin_orders(parseAdmin_orders(getJSONArray(jsonObject,JSON_KEY_ADMIN_ORDERS)));
			val.setPayment_history_types(parsePayment_history_types(getJSONObject(jsonObject,JSON_KEY_PAYMENT_HISTORY_TYPES)));
			val.setSequestrations(parseSequestrations(getJSONArray(jsonObject,JSON_KEY_SEQUESTRATIONS)));
			val.setLink(getString(jsonObject,JSON_KEY_LINK));
			val.setConsumer_account_types(parseConsumer_account_types(getJSONObject(jsonObject,JSON_KEY_CONSUMER_ACCOUNT_TYPES)));
			val.setPersonal_details(parsePersonal_details(getJSONObject(jsonObject,JSON_KEY_PERSONAL_DETAILS)));
			val.setSite_id(getString(jsonObject,JSON_KEY_SITE_ID));
			val.setAccount_status(parseAccount_status(getJSONObject(jsonObject,JSON_KEY_ACCOUNT_STATUS)));
			val.setConsumer_accounts(parseConsumer_accounts(getJSONArray(jsonObject,JSON_KEY_CONSUMER_ACCOUNTS)));
			val.setScoring(parseScoring(getJSONObject(jsonObject,JSON_KEY_SCORING)));
			val.setId(getString(jsonObject,JSON_KEY_ID));
			val.setJudgements(parseJudgements(getJSONArray(jsonObject,JSON_KEY_JUDGEMENTS)));
			val.setDebt_review(parseDebt_review(getJSONArray(jsonObject,JSON_KEY_DEBT_REVIEW)));
			val.setPayment_notifications(parsePayment_notifications(getJSONArray(jsonObject,JSON_KEY_PAYMENT_NOTIFICATIONS)));
			val.setCreated(getString(jsonObject,JSON_KEY_CREATED));
			val.setDefault_listings(parseDefault_listings(getJSONArray(jsonObject,JSON_KEY_DEFAULT_LISTINGS)));
			val.setFraud_indicators(parseFraud_indicators(getJSONObject(jsonObject,JSON_KEY_FRAUD_INDICATORS)));
			val.setRehabilitation_orders(parseRehabilitation_orders(getJSONArray(jsonObject,JSON_KEY_REHABILITATION_ORDERS)));
			val.setEnquiries(parseEnquiries(getJSONArray(jsonObject,JSON_KEY_ENQUIRIES)));
			val.setPayment_headers(parsePayment_headers(getJSONObject(jsonObject,JSON_KEY_PAYMENT_HEADERS)));
			val.setLoan_accounts(parseLoan_accounts(getJSONArray(jsonObject,JSON_KEY_LOAN_ACCOUNTS)));
			
		}
	return val;
	}
	public static Summary parseSummary(JSONObject jsonObject){
		Summary summary=new Summary();
		if(jsonObject!=null)
		{
			
			summary.setConsumer_adverse_amount(getString(jsonObject,JSON_KEY_CONSUMER_ADVERSE_AMOUNT));
			summary.setLoan_enquiries(getString(jsonObject,JSON_KEY_LOAN_ENQUIRIES));
			summary.setConsumer_new_accounts(getString(jsonObject,JSON_KEY_CONSUMER_NEW_ACCOUNTS));
			summary.setLoan_accounts_in_arrears(getString(jsonObject,JSON_KEY_LOAN_ACCOUNTS_IN_ARREARS));
			summary.setLoan_new_accounts(getString(jsonObject,JSON_KEY_LOAN_NEW_ACCOUNTS));
			summary.setAdverse(parseAdverse(getJSONObject(jsonObject,JSON_KEY_ADVERSE)));
			summary.setDispute_status(getString(jsonObject,JSON_KEY_DISPUTE_STATUS));
			summary.setConsumer_instalments(getString(jsonObject,JSON_KEY_CONSUMER_INSTALMENTS));
			summary.setLoan_accounts_closed(getString(jsonObject,JSON_KEY_LOAN_ACCOUNTS_CLOSED));
			summary.setJudgements(parseJudgements(getJSONObject(jsonObject,JSON_KEY_JUDGEMENTS)));
			summary.setConsumer_self_enquiries(getString(jsonObject,JSON_KEY_CONSUMER_SELF_ENQUIRIES));
			summary.setConsumer_accounts_active(getString(jsonObject,JSON_KEY_CONSUMER_ACCOUNTS_ACTIVE));
			summary.setFraud_notices(getLong(jsonObject,JSON_KEY_FRAUD_NOTICES));
			summary.setCourt_notices(parseCourt_notices(getJSONObject(jsonObject,JSON_KEY_COURT_NOTICES)));
			summary.setDefault_listing(parseDefault_listing(getJSONObject(jsonObject,JSON_KEY_DEFAULT_LISTING)));
			summary.setLoan_debt(getString(jsonObject,JSON_KEY_LOAN_DEBT));
			summary.setLoan_instalments(getString(jsonObject,JSON_KEY_LOAN_INSTALMENTS));
			summary.setEnquiries(getLong(jsonObject,JSON_KEY_ENQUIRIES));
			summary.setNegative_information(getLong(jsonObject,JSON_KEY_NEGATIVE_INFORMATION));
			summary.setLoan_max_month_in_arrears(getString(jsonObject,JSON_KEY_LOAN_MAX_MONTH_IN_ARREARS));
			summary.setLoan_adverse_amount(getString(jsonObject,JSON_KEY_LOAN_ADVERSE_AMOUNT));
			summary.setConsumer_enquiries(getString(jsonObject,JSON_KEY_CONSUMER_ENQUIRIES));
			summary.setConsumer_accounts_closed(getString(jsonObject,JSON_KEY_CONSUMER_ACCOUNTS_CLOSED));
			summary.setDebt_review_status(getString(jsonObject,JSON_KEY_DEBT_REVIEW_STATUS));
			summary.setConsumer_debt(getString(jsonObject,JSON_KEY_CONSUMER_DEBT));
			summary.setProperty(parseProperty(getJSONObject(jsonObject,JSON_KEY_PROPERTY)));
			summary.setLoan_accounts_active(getString(jsonObject,JSON_KEY_LOAN_ACCOUNTS_ACTIVE));
			summary.setConsumer_accounts_in_arrears(getString(jsonObject,JSON_KEY_CONSUMER_ACCOUNTS_IN_ARREARS));
			summary.setConsumer_arrears(getString(jsonObject,JSON_KEY_CONSUMER_ARREARS));
			summary.setLoan_arrears(getString(jsonObject,JSON_KEY_LOAN_ARREARS));
			summary.setConsumer_max_month_in_arrears(getString(jsonObject,JSON_KEY_CONSUMER_MAX_MONTH_IN_ARREARS));
			summary.setLoan_accounts_in_good(getString(jsonObject,JSON_KEY_LOAN_ACCOUNTS_IN_GOOD));
			summary.setLoan_self_enquiries(getString(jsonObject,JSON_KEY_LOAN_SELF_ENQUIRIES));
			summary.setConsumer_accounts_in_good(getString(jsonObject,JSON_KEY_CONSUMER_ACCOUNTS_IN_GOOD));
			
		}
	return summary;
	}
	public static Consumer_account_types parseConsumer_account_types(JSONObject jsonObject){
		Consumer_account_types consumer_account_types=new Consumer_account_types();
		if(jsonObject!=null)
		{
			
			consumer_account_types.setD(getString(jsonObject,JSON_KEY_D));
			consumer_account_types.setE(getString(jsonObject,JSON_KEY_E));
			consumer_account_types.setF(getString(jsonObject,JSON_KEY_F));
			consumer_account_types.setG(getString(jsonObject,JSON_KEY_G));
			consumer_account_types.setB(getString(jsonObject,JSON_KEY_B));
			consumer_account_types.setC(getString(jsonObject,JSON_KEY_C));
			consumer_account_types.setL(getString(jsonObject,JSON_KEY_L));
			consumer_account_types.setN(getString(jsonObject,JSON_KEY_N));
			consumer_account_types.setO(getString(jsonObject,JSON_KEY_O));
			consumer_account_types.setH(getString(jsonObject,JSON_KEY_H));
			consumer_account_types.setI(getString(jsonObject,JSON_KEY_I));
			consumer_account_types.setJ(getString(jsonObject,JSON_KEY_J));
			consumer_account_types.setK(getString(jsonObject,JSON_KEY_K));
			consumer_account_types.setU(getString(jsonObject,JSON_KEY_U));
			consumer_account_types.setT(getString(jsonObject,JSON_KEY_T));
			consumer_account_types.setV(getString(jsonObject,JSON_KEY_V));
			consumer_account_types.setP(getString(jsonObject,JSON_KEY_P));
			consumer_account_types.setS(getString(jsonObject,JSON_KEY_S));
			consumer_account_types.setR(getString(jsonObject,JSON_KEY_R));
			
		}
	return consumer_account_types;
	}
	public static Personal_details parsePersonal_details(JSONObject jsonObject){
		Personal_details personal_details=new Personal_details();
		if(jsonObject!=null)
		{
			
			personal_details.setCurrent_employer(getString(jsonObject,JSON_KEY_CURRENT_EMPLOYER));
			personal_details.setId_number(getString(jsonObject,JSON_KEY_ID_NUMBER));
			personal_details.setMiddle_name(getString(jsonObject,JSON_KEY_MIDDLE_NAME));
			personal_details.setDate_of_birth(getString(jsonObject,JSON_KEY_DATE_OF_BIRTH));
			personal_details.setSurname(getString(jsonObject,JSON_KEY_SURNAME));
			personal_details.setPostal_address(getString(jsonObject,JSON_KEY_POSTAL_ADDRESS));
			personal_details.setFirst_name(getString(jsonObject,JSON_KEY_FIRST_NAME));
			personal_details.setMobile_phone(getString(jsonObject,JSON_KEY_MOBILE_PHONE));
			personal_details.setTitle(getString(jsonObject,JSON_KEY_TITLE));
			personal_details.setExternal_reference(getString(jsonObject,JSON_KEY_EXTERNAL_REFERENCE));
			personal_details.setEmail(getString(jsonObject,JSON_KEY_EMAIL));
			personal_details.setResidential_address(getString(jsonObject,JSON_KEY_RESIDENTIAL_ADDRESS));
			personal_details.setWork_phone(getString(jsonObject,JSON_KEY_WORK_PHONE));
			personal_details.setPassport_number(getString(jsonObject,JSON_KEY_PASSPORT_NUMBER));
			personal_details.setHome_phone(getString(jsonObject,JSON_KEY_HOME_PHONE));
			personal_details.setGender(getString(jsonObject,JSON_KEY_GENDER));
			personal_details.setReference_no(getString(jsonObject,JSON_KEY_REFERENCE_NO));
			personal_details.setMarital_status(getString(jsonObject,JSON_KEY_MARITAL_STATUS));
			
		}
	return personal_details;
	}
	public static Account_status parseAccount_status(JSONObject jsonObject){
		Account_status account_status=new Account_status();
		if(jsonObject!=null)
		{
			
			account_status.setD(getString(jsonObject,JSON_KEY_D));
			account_status.setE(getString(jsonObject,JSON_KEY_E));
			account_status.setF(getString(jsonObject,JSON_KEY_F));
			account_status.setG(getString(jsonObject,JSON_KEY_G));
			account_status.setB(getString(jsonObject,JSON_KEY_B));
			account_status.setC(getString(jsonObject,JSON_KEY_C));
			account_status.setL(getString(jsonObject,JSON_KEY_L));
			account_status.setM(getString(jsonObject,JSON_KEY_M));
			account_status.setN(getString(jsonObject,JSON_KEY_N));
			account_status.setH(getString(jsonObject,JSON_KEY_H));
			account_status.setI(getString(jsonObject,JSON_KEY_I));
			account_status.setJ(getString(jsonObject,JSON_KEY_J));
			account_status.setK(getString(jsonObject,JSON_KEY_K));
			account_status.setT(getString(jsonObject,JSON_KEY_T));
			account_status.setW(getString(jsonObject,JSON_KEY_W));
			account_status.setAA(getString(jsonObject,JSON_KEY_AA));
			account_status.setV(getString(jsonObject,JSON_KEY_V));
			account_status.setAB(getString(jsonObject,JSON_KEY_AB));
			account_status.setP(getString(jsonObject,JSON_KEY_P));
			account_status.setS(getString(jsonObject,JSON_KEY_S));
			account_status.setR(getString(jsonObject,JSON_KEY_R));
			account_status.setX(getString(jsonObject,JSON_KEY_X));
			account_status.setZ(getString(jsonObject,JSON_KEY_Z));
			
		}
	return account_status;
	}
	public static Scoring parseScoring(JSONObject jsonObject){
		Scoring scoring=new Scoring();
		if(jsonObject!=null)
		{
			
			scoring.setRisk_category(getString(jsonObject,JSON_KEY_RISK_CATEGORY));
			scoring.setScore_date(getString(jsonObject,JSON_KEY_SCORE_DATE));
			scoring.setException_code(getString(jsonObject,JSON_KEY_EXCEPTION_CODE));
			scoring.setFinal_score(getString(jsonObject,JSON_KEY_FINAL_SCORE));
			
		}
	return scoring;
	}
	public static Fraud_indicators parseFraud_indicators(JSONObject jsonObject){
		Fraud_indicators fraud_indicators=new Fraud_indicators();
		if(jsonObject!=null)
		{
			
			fraud_indicators.setDeceased_date(getString(jsonObject,JSON_KEY_DECEASED_DATE));
			fraud_indicators.setEmployer_fraud_verification(getString(jsonObject,JSON_KEY_EMPLOYER_FRAUD_VERIFICATION));
			fraud_indicators.setProtective_verification(getString(jsonObject,JSON_KEY_PROTECTIVE_VERIFICATION));
			fraud_indicators.setHome_affairs_verification(getString(jsonObject,JSON_KEY_HOME_AFFAIRS_VERIFICATION));
			fraud_indicators.setDeceased_status(getString(jsonObject,JSON_KEY_DECEASED_STATUS));
			fraud_indicators.setSafps_listing(getString(jsonObject,JSON_KEY_SAFPS_LISTING));
			
		}
	return fraud_indicators;
	}
	public static Payment_headers parsePayment_headers(JSONObject jsonObject){
		Payment_headers payment_headers=new Payment_headers();
		if(jsonObject!=null)
		{
			
			payment_headers.set08(getString(jsonObject,JSON_KEY_08));
			payment_headers.set09(getString(jsonObject,JSON_KEY_09));
			payment_headers.set19(getString(jsonObject,JSON_KEY_19));
			payment_headers.set04(getString(jsonObject,JSON_KEY_04));
			payment_headers.set22(getString(jsonObject,JSON_KEY_22));
			payment_headers.set17(getString(jsonObject,JSON_KEY_17));
			payment_headers.set05(getString(jsonObject,JSON_KEY_05));
			payment_headers.set23(getString(jsonObject,JSON_KEY_23));
			payment_headers.set18(getString(jsonObject,JSON_KEY_18));
			payment_headers.set06(getString(jsonObject,JSON_KEY_06));
			payment_headers.set24(getString(jsonObject,JSON_KEY_24));
			payment_headers.set15(getString(jsonObject,JSON_KEY_15));
			payment_headers.set07(getString(jsonObject,JSON_KEY_07));
			payment_headers.set16(getString(jsonObject,JSON_KEY_16));
			payment_headers.set13(getString(jsonObject,JSON_KEY_13));
			payment_headers.set01(getString(jsonObject,JSON_KEY_01));
			payment_headers.set14(getString(jsonObject,JSON_KEY_14));
			payment_headers.set02(getString(jsonObject,JSON_KEY_02));
			payment_headers.set11(getString(jsonObject,JSON_KEY_11));
			payment_headers.set03(getString(jsonObject,JSON_KEY_03));
			payment_headers.set12(getString(jsonObject,JSON_KEY_12));
			payment_headers.set21(getString(jsonObject,JSON_KEY_21));
			payment_headers.set20(getString(jsonObject,JSON_KEY_20));
			payment_headers.set10(getString(jsonObject,JSON_KEY_10));
			
		}
	return payment_headers;
	}
	public static Adverse parseAdverse(JSONObject jsonObject){
		Adverse adverse=new Adverse();
		if(jsonObject!=null)
		{
			
			adverse.setAmount(getString(jsonObject,JSON_KEY_AMOUNT));
			adverse.setDate(getString(jsonObject,JSON_KEY_DATE));
			
		}
	return adverse;
	}
	public static Judgements parseJudgements(JSONObject jsonObject){
		Judgements judgements=new Judgements();
		if(jsonObject!=null)
		{
			
			judgements.setAmount(getString(jsonObject,JSON_KEY_AMOUNT));
			judgements.setCount(getString(jsonObject,JSON_KEY_COUNT));
			judgements.setDate(getString(jsonObject,JSON_KEY_DATE));
			
		}
	return judgements;
	}
	public static Court_notices parseCourt_notices(JSONObject jsonObject){
		Court_notices court_notices=new Court_notices();
		if(jsonObject!=null)
		{
			
			court_notices.setAmount(getString(jsonObject,JSON_KEY_AMOUNT));
			court_notices.setCount(getString(jsonObject,JSON_KEY_COUNT));
			court_notices.setDate(getString(jsonObject,JSON_KEY_DATE));
			
		}
	return court_notices;
	}
	public static Default_listing parseDefault_listing(JSONObject jsonObject){
		Default_listing default_listing=new Default_listing();
		if(jsonObject!=null)
		{
			
			default_listing.setAmount(getString(jsonObject,JSON_KEY_AMOUNT));
			default_listing.setCount(getString(jsonObject,JSON_KEY_COUNT));
			default_listing.setDate(getString(jsonObject,JSON_KEY_DATE));
			
		}
	return default_listing;
	}
	public static Property parseProperty(JSONObject jsonObject){
		Property property=new Property();
		if(jsonObject!=null)
		{
			
			property.setAmount(getString(jsonObject,JSON_KEY_AMOUNT));
			property.setCount(getString(jsonObject,JSON_KEY_COUNT));
			
		}
	return property;
	}
	public static ArrayList<Consumer_accounts> parseConsumer_accounts(JSONArray jsonArray) {
		ArrayList<Consumer_accounts> consumer_accountss = new ArrayList<Consumer_accounts>();
		if (jsonArray != null) {
			for(int i=0;i<jsonArray.length();i++){
				 try{
					JSONObject jsonObject=jsonArray.getJSONObject(i);
				consumer_accountss.add(parseConsumer_accounts(jsonObject));
				} catch(Exception e){
				e.printStackTrace();
				}
			}
		}
		return consumer_accountss;
	}
	public static ArrayList<Enquiries> parseEnquiries(JSONArray jsonArray) {
		ArrayList<Enquiries> enquiriess = new ArrayList<Enquiries>();
		if (jsonArray != null) {
			for(int i=0;i<jsonArray.length();i++){
				 try{
					JSONObject jsonObject=jsonArray.getJSONObject(i);
				enquiriess.add(parseEnquiries(jsonObject));
				} catch(Exception e){
				e.printStackTrace();
				}
			}
		}
		return enquiriess;
	}
	public static Consumer_accounts parseConsumer_accounts(JSONObject jsonObject){
		Consumer_accounts consumer_accounts=new Consumer_accounts();
		if(jsonObject!=null)
		{
			
			consumer_accounts.setLast_payment(getString(jsonObject,JSON_KEY_LAST_PAYMENT));
			consumer_accounts.setArrears_amount(getString(jsonObject,JSON_KEY_ARREARS_AMOUNT));
			consumer_accounts.setCredit_limit(getString(jsonObject,JSON_KEY_CREDIT_LIMIT));
			consumer_accounts.setAccount_number(getString(jsonObject,JSON_KEY_ACCOUNT_NUMBER));
			consumer_accounts.setStatus(getString(jsonObject,JSON_KEY_STATUS));
			consumer_accounts.setCreated(getString(jsonObject,JSON_KEY_CREATED));
			consumer_accounts.setPayment_history(parsePayment_history(getJSONObject(jsonObject,JSON_KEY_PAYMENT_HISTORY)));
			consumer_accounts.setCurrent_balance(getString(jsonObject,JSON_KEY_CURRENT_BALANCE));
			consumer_accounts.setSubscriber_name(getString(jsonObject,JSON_KEY_SUBSCRIBER_NAME));
			consumer_accounts.setSubscriber_id(getString(jsonObject,JSON_KEY_SUBSCRIBER_ID));
			consumer_accounts.setInstalment_amount(getString(jsonObject,JSON_KEY_INSTALMENT_AMOUNT));
			consumer_accounts.setType(getString(jsonObject,JSON_KEY_TYPE));
			
		}
	return consumer_accounts;
	}
	public static Enquiries parseEnquiries(JSONObject jsonObject){
		Enquiries enquiries=new Enquiries();
		if(jsonObject!=null)
		{
			
			enquiries.setReason(getString(jsonObject,JSON_KEY_REASON));
			enquiries.setCredit_provder_type(getString(jsonObject,JSON_KEY_CREDIT_PROVDER_TYPE));
			enquiries.setCredit_provider(getString(jsonObject,JSON_KEY_CREDIT_PROVIDER));
			enquiries.setDate(getString(jsonObject,JSON_KEY_DATE));
			
		}
	return enquiries;
	}
	public static Payment_history parsePayment_history(JSONObject jsonObject){
		Payment_history payment_history=new Payment_history();
		if(jsonObject!=null)
		{
			
			payment_history.set08(getString(jsonObject,JSON_KEY_08));
			payment_history.set09(getString(jsonObject,JSON_KEY_09));
			payment_history.set19(getString(jsonObject,JSON_KEY_19));
			payment_history.set04(getString(jsonObject,JSON_KEY_04));
			payment_history.set22(getString(jsonObject,JSON_KEY_22));
			payment_history.set17(getString(jsonObject,JSON_KEY_17));
			payment_history.set05(getString(jsonObject,JSON_KEY_05));
			payment_history.set23(getString(jsonObject,JSON_KEY_23));
			payment_history.set18(getString(jsonObject,JSON_KEY_18));
			payment_history.set06(getString(jsonObject,JSON_KEY_06));
			payment_history.set24(getString(jsonObject,JSON_KEY_24));
			payment_history.set15(getString(jsonObject,JSON_KEY_15));
			payment_history.set07(getString(jsonObject,JSON_KEY_07));
			payment_history.set16(getString(jsonObject,JSON_KEY_16));
			payment_history.set13(getString(jsonObject,JSON_KEY_13));
			payment_history.set01(getString(jsonObject,JSON_KEY_01));
			payment_history.set14(getString(jsonObject,JSON_KEY_14));
			payment_history.set02(getString(jsonObject,JSON_KEY_02));
			payment_history.set11(getString(jsonObject,JSON_KEY_11));
			payment_history.set03(getString(jsonObject,JSON_KEY_03));
			payment_history.set12(getString(jsonObject,JSON_KEY_12));
			payment_history.set21(getString(jsonObject,JSON_KEY_21));
			payment_history.set20(getString(jsonObject,JSON_KEY_20));
			payment_history.set10(getString(jsonObject,JSON_KEY_10));
			
		}
	return payment_history;
	}
}