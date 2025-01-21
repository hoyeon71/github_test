package com.ghayoun.ezjobs.comm.domain;

import java.io.Serializable;

public class DgbFwaBean implements Serializable {
	
	private int row_num 		= 0;
	
	private String crdt = "";
	private String scpt_file_nm = "";
	private String scpt_file_cn = "";
	
	private String gb = "";
	private String mem_name = "";
	private String job_name = "";
	private String job_no = "";
	private String runcount = "";
	private String author = "";
	private String job_status = "";
	private String start_time = "";
	private String end_time = "";
	private String npc_ncse = "";
	private String npc_amt = "";
	private String erh_ncse = "";
	private String erh_amt = "";
	private String sum_dlng_trget_ncse = "";
	private String sum_npc_ncse = "";
	private String sum_erh_ncse = "";
	private String sum_dlng_trget_amt = "";
	private String sum_npc_amt = "";
	private String sum_erh_amt = "";
	private String avg_npc_ncse = "";
	private String avg_npc_amt = "";
	private String uplmt_ect_rate = "";
	private String uplmt_err_amt_rate = "";
	private String lwtlm_ect_rate = "";
	private String lwtlm_err_amt_rate = "";
	
	private String description = "";
	private String until = "";
	private String confirm = "";
	private String cyclic = "";
	private String days_cal = "";
	private String daystr = "";
	private String monthstr = "";
	private String weeks_cal = "";
	private String week_days = "";
	
	private String prgrm_id = "";
	private String log_yn = "";
	private String log_levl_val = "";
	private String input_cridd_tpcd = "";
	private String max_dlng_pmsn_hr = "";
	private String parl_dlng_yn = "";
	private String parl_dlng_ncse = "";
	private String rpc_psblyn = "";
	private String re_strt_dvcd = "";
	private String max_rty_tms = "";
	private String cmmt_prd_cnt = "";
	private String cgp_enob = "";
	private String cmmt_ncse_chk_yn = "";
	private String cgp_mpno = "";
	private String lt_cmmt_dlng_yn = "";
	private String head_trail_chk_dvcd = "";
	private String ncse_amt_chk_dvcd = "";
	private String av_dlng_ncse = "";
	private String av_dlng_amt  = "";
	
	public int getRow_num() {
		return row_num;
	}

	public void setRow_num(int row_num) {
		this.row_num = row_num;
	}

	public String getScpt_file_nm() {
		return scpt_file_nm;
	}

	public void setScpt_file_nm(String scpt_file_nm) {
		this.scpt_file_nm = scpt_file_nm;
	}

	public String getScpt_file_cn() {
		return scpt_file_cn;
	}

	public void setScpt_file_cn(String scpt_file_cn) {
		this.scpt_file_cn = scpt_file_cn;
	}

	public String getGb() {
		return gb;
	}

	public void setGb(String gb) {
		this.gb = gb;
	}

	public String getJob_name() {
		return job_name;
	}

	public void setJob_name(String job_name) {
		this.job_name = job_name;
	}

	public String getJob_no() {
		return job_no;
	}

	public void setJob_no(String job_no) {
		this.job_no = job_no;
	}

	public String getRuncount() {
		return runcount;
	}

	public void setRuncount(String runcount) {
		this.runcount = runcount;
	}

	public String getAuthor() {
		return author;
	}

	public void setAuthor(String author) {
		this.author = author;
	}

	public String getJob_status() {
		return job_status;
	}

	public void setJob_status(String job_status) {
		this.job_status = job_status;
	}

	public String getStart_time() {
		return start_time;
	}

	public void setStart_time(String start_time) {
		this.start_time = start_time;
	}

	public String getEnd_time() {
		return end_time;
	}

	public void setEnd_time(String end_time) {
		this.end_time = end_time;
	}

	public String getNpc_ncse() {
		return npc_ncse;
	}

	public void setNpc_ncse(String npc_ncse) {
		this.npc_ncse = npc_ncse;
	}

	public String getNpc_amt() {
		return npc_amt;
	}

	public void setNpc_amt(String npc_amt) {
		this.npc_amt = npc_amt;
	}

	public String getErh_ncse() {
		return erh_ncse;
	}

	public void setErh_ncse(String erh_ncse) {
		this.erh_ncse = erh_ncse;
	}

	public String getErh_amt() {
		return erh_amt;
	}

	public void setErh_amt(String erh_amt) {
		this.erh_amt = erh_amt;
	}

	public String getSum_npc_ncse() {
		return sum_npc_ncse;
	}

	public void setSum_npc_ncse(String sum_npc_ncse) {
		this.sum_npc_ncse = sum_npc_ncse;
	}

	public String getSum_npc_amt() {
		return sum_npc_amt;
	}

	public void setSum_npc_amt(String sum_npc_amt) {
		this.sum_npc_amt = sum_npc_amt;
	}

	public String getAvg_npc_ncse() {
		return avg_npc_ncse;
	}

	public void setAvg_npc_ncse(String avg_npc_ncse) {
		this.avg_npc_ncse = avg_npc_ncse;
	}

	public String getAvg_npc_amt() {
		return avg_npc_amt;
	}

	public void setAvg_npc_amt(String avg_npc_amt) {
		this.avg_npc_amt = avg_npc_amt;
	}

	public String getUplmt_ect_rate() {
		return uplmt_ect_rate;
	}

	public void setUplmt_ect_rate(String uplmt_ect_rate) {
		this.uplmt_ect_rate = uplmt_ect_rate;
	}

	public String getUplmt_err_amt_rate() {
		return uplmt_err_amt_rate;
	}

	public void setUplmt_err_amt_rate(String uplmt_err_amt_rate) {
		this.uplmt_err_amt_rate = uplmt_err_amt_rate;
	}

	public String getLwtlm_ect_rate() {
		return lwtlm_ect_rate;
	}

	public void setLwtlm_ect_rate(String lwtlm_ect_rate) {
		this.lwtlm_ect_rate = lwtlm_ect_rate;
	}

	public String getLwtlm_err_amt_rate() {
		return lwtlm_err_amt_rate;
	}

	public void setLwtlm_err_amt_rate(String lwtlm_err_amt_rate) {
		this.lwtlm_err_amt_rate = lwtlm_err_amt_rate;
	}

	public String getMem_name() {
		return mem_name;
	}

	public void setMem_name(String mem_name) {
		this.mem_name = mem_name;
	}

	public String getDescription() {
		return description;
	}

	public void setDescription(String description) {
		this.description = description;
	}

	public String getUntil() {
		return until;
	}

	public void setUntil(String until) {
		this.until = until;
	}

	public String getConfirm() {
		return confirm;
	}

	public void setConfirm(String confirm) {
		this.confirm = confirm;
	}

	public String getCyclic() {
		return cyclic;
	}

	public void setCyclic(String cyclic) {
		this.cyclic = cyclic;
	}

	public String getDays_cal() {
		return days_cal;
	}

	public void setDays_cal(String days_cal) {
		this.days_cal = days_cal;
	}

	public String getDaystr() {
		return daystr;
	}

	public void setDaystr(String daystr) {
		this.daystr = daystr;
	}

	public String getMonthstr() {
		return monthstr;
	}

	public void setMonthstr(String monthstr) {
		this.monthstr = monthstr;
	}

	public String getWeeks_cal() {
		return weeks_cal;
	}

	public void setWeeks_cal(String weeks_cal) {
		this.weeks_cal = weeks_cal;
	}

	public String getWeek_days() {
		return week_days;
	}

	public void setWeek_days(String week_days) {
		this.week_days = week_days;
	}

	public String getCrdt() {
		return crdt;
	}

	public void setCrdt(String crdt) {
		this.crdt = crdt;
	}

	public String getSum_dlng_trget_ncse() {
		return sum_dlng_trget_ncse;
	}

	public void setSum_dlng_trget_ncse(String sum_dlng_trget_ncse) {
		this.sum_dlng_trget_ncse = sum_dlng_trget_ncse;
	}

	public String getSum_erh_ncse() {
		return sum_erh_ncse;
	}

	public void setSum_erh_ncse(String sum_erh_ncse) {
		this.sum_erh_ncse = sum_erh_ncse;
	}

	public String getSum_dlng_trget_amt() {
		return sum_dlng_trget_amt;
	}

	public void setSum_dlng_trget_amt(String sum_dlng_trget_amt) {
		this.sum_dlng_trget_amt = sum_dlng_trget_amt;
	}

	public String getSum_erh_amt() {
		return sum_erh_amt;
	}

	public void setSum_erh_amt(String sum_erh_amt) {
		this.sum_erh_amt = sum_erh_amt;
	}

	public String getPrgrm_id() {
		return prgrm_id;
	}

	public void setPrgrm_id(String prgrm_id) {
		this.prgrm_id = prgrm_id;
	}

	public String getLog_yn() {
		return log_yn;
	}

	public void setLog_yn(String log_yn) {
		this.log_yn = log_yn;
	}

	public String getLog_levl_val() {
		return log_levl_val;
	}

	public void setLog_levl_val(String log_levl_val) {
		this.log_levl_val = log_levl_val;
	}

	public String getInput_cridd_tpcd() {
		return input_cridd_tpcd;
	}

	public void setInput_cridd_tpcd(String input_cridd_tpcd) {
		this.input_cridd_tpcd = input_cridd_tpcd;
	}

	public String getMax_dlng_pmsn_hr() {
		return max_dlng_pmsn_hr;
	}

	public void setMax_dlng_pmsn_hr(String max_dlng_pmsn_hr) {
		this.max_dlng_pmsn_hr = max_dlng_pmsn_hr;
	}

	public String getParl_dlng_yn() {
		return parl_dlng_yn;
	}

	public void setParl_dlng_yn(String parl_dlng_yn) {
		this.parl_dlng_yn = parl_dlng_yn;
	}

	public String getParl_dlng_ncse() {
		return parl_dlng_ncse;
	}

	public void setParl_dlng_ncse(String parl_dlng_ncse) {
		this.parl_dlng_ncse = parl_dlng_ncse;
	}

	public String getRe_strt_dvcd() {
		return re_strt_dvcd;
	}

	public void setRe_strt_dvcd(String re_strt_dvcd) {
		this.re_strt_dvcd = re_strt_dvcd;
	}

	public String getMax_rty_tms() {
		return max_rty_tms;
	}

	public void setMax_rty_tms(String max_rty_tms) {
		this.max_rty_tms = max_rty_tms;
	}

	public String getCmmt_prd_cnt() {
		return cmmt_prd_cnt;
	}

	public void setCmmt_prd_cnt(String cmmt_prd_cnt) {
		this.cmmt_prd_cnt = cmmt_prd_cnt;
	}

	public String getCgp_enob() {
		return cgp_enob;
	}

	public void setCgp_enob(String cgp_enob) {
		this.cgp_enob = cgp_enob;
	}

	public String getCmmt_ncse_chk_yn() {
		return cmmt_ncse_chk_yn;
	}

	public void setCmmt_ncse_chk_yn(String cmmt_ncse_chk_yn) {
		this.cmmt_ncse_chk_yn = cmmt_ncse_chk_yn;
	}

	public String getCgp_mpno() {
		return cgp_mpno;
	}

	public void setCgp_mpno(String cgp_mpno) {
		this.cgp_mpno = cgp_mpno;
	}

	public String getLt_cmmt_dlng_yn() {
		return lt_cmmt_dlng_yn;
	}

	public void setLt_cmmt_dlng_yn(String lt_cmmt_dlng_yn) {
		this.lt_cmmt_dlng_yn = lt_cmmt_dlng_yn;
	}

	public String getHead_trail_chk_dvcd() {
		return head_trail_chk_dvcd;
	}

	public void setHead_trail_chk_dvcd(String head_trail_chk_dvcd) {
		this.head_trail_chk_dvcd = head_trail_chk_dvcd;
	}

	public String getAv_dlng_ncse() {
		return av_dlng_ncse;
	}

	public void setAv_dlng_ncse(String av_dlng_ncse) {
		this.av_dlng_ncse = av_dlng_ncse;
	}

	public String getAv_dlng_amt() {
		return av_dlng_amt;
	}

	public void setAv_dlng_amt(String av_dlng_amt) {
		this.av_dlng_amt = av_dlng_amt;
	}

	public String getRpc_psblyn() {
		return rpc_psblyn;
	}

	public void setRpc_psblyn(String rpc_psblyn) {
		this.rpc_psblyn = rpc_psblyn;
	}

	public String getNcse_amt_chk_dvcd() {
		return ncse_amt_chk_dvcd;
	}

	public void setNcse_amt_chk_dvcd(String ncse_amt_chk_dvcd) {
		this.ncse_amt_chk_dvcd = ncse_amt_chk_dvcd;
	}
	
	
}
