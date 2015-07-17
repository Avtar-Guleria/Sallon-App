package com.h;
public class Scoring {
	
	private String risk_category;
	private String score_date;
	private String exception_code;
	private String final_score;
	public String getRisk_category() {
		return risk_category;
	}
	public void setRisk_category(String risk_category) {
		this.risk_category = risk_category;
	}
	public String getScore_date() {
		return score_date;
	}
	public void setScore_date(String score_date) {
		this.score_date = score_date;
	}
	public String getException_code() {
		return exception_code;
	}
	public void setException_code(String exception_code) {
		this.exception_code = exception_code;
	}
	public String getFinal_score() {
		return final_score;
	}
	public void setFinal_score(String final_score) {
		this.final_score = final_score;
	}
}