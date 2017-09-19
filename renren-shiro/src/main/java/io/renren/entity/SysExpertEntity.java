package io.renren.entity;


import java.io.Serializable;
import java.util.Date;


/**
 * 专家信息表
 * 
 * @author chenshun
 * @email sunlightcs@gmail.com
 * @date 2017-09-19 20:14:09
 */
public class SysExpertEntity implements Serializable {
	private static final long serialVersionUID = 1L;
	
	//
	private Long expertId;
	//专家姓名
	private String name;
	//性别
	private String gender;
	//民族
	private String nation;
	//党派
	private String party;
	//身份证号
	private String idnum;
	//出生日期
	private String birth;
	//最高学历
	private String highestedu;
	//毕业院校
	private String graduateschool;
	//所学专业
	private String major1;
	//从事专业
	private String major2;
	//单位性质
	private String unitproperty;
	//是否院士，1是，0否
	private String isacademician;
	//技术职称
	private String experttitle;
	//担任职务
	private String expertjob;
	//在职情况,1在职，0离职
	private String onduty;
	//移动电话
	private String mobile;
	//传真
	private String fax;
	//电子邮件
	private String email;
	//通信地址
	private String address;
	//邮政编码
	private String postcode;
	//研究领域
	private String researchfield;
	//研究方向
	private String researchdirection;
	//熟悉语种
	private String language;
	//熟练程度
	private String proficiency;
	//专业简历
	private String resume;
	//推荐单位名称
	private String recommendunit;
	//工作单位名称
	private String workunit;
	//备注
	private String remark;
	//创建时间
	private Date createTime;
	//创建者ID
	private Long createUserId;
	//修改时间
	private Date modifyTime;
	//修改者ID
	private Long modifyUserId;
	
	private String status;

	public String getStatus() {
        return status;
    }
    public void setStatus(String status) {
        this.status = status;
    }
    /**
	 * 设置：
	 */
	public void setExpertId(Long expertId) {
		this.expertId = expertId;
	}
	/**
	 * 获取：
	 */
	public Long getExpertId() {
		return expertId;
	}
	/**
	 * 设置：专家姓名
	 */
	public void setName(String name) {
		this.name = name;
	}
	/**
	 * 获取：专家姓名
	 */
	public String getName() {
		return name;
	}
	/**
	 * 设置：性别
	 */
	public void setGender(String gender) {
		this.gender = gender;
	}
	/**
	 * 获取：性别
	 */
	public String getGender() {
		return gender;
	}
	/**
	 * 设置：民族
	 */
	public void setNation(String nation) {
		this.nation = nation;
	}
	/**
	 * 获取：民族
	 */
	public String getNation() {
		return nation;
	}
	/**
	 * 设置：党派
	 */
	public void setParty(String party) {
		this.party = party;
	}
	/**
	 * 获取：党派
	 */
	public String getParty() {
		return party;
	}
	/**
	 * 设置：身份证号
	 */
	public void setIdnum(String idnum) {
		this.idnum = idnum;
	}
	/**
	 * 获取：身份证号
	 */
	public String getIdnum() {
		return idnum;
	}
	/**
	 * 设置：出生日期
	 */
	public void setBirth(String birth) {
		this.birth = birth;
	}
	/**
	 * 获取：出生日期
	 */
	public String getBirth() {
		return birth;
	}
	/**
	 * 设置：最高学历
	 */
	public void setHighestedu(String highestedu) {
		this.highestedu = highestedu;
	}
	/**
	 * 获取：最高学历
	 */
	public String getHighestedu() {
		return highestedu;
	}
	/**
	 * 设置：毕业院校
	 */
	public void setGraduateschool(String graduateschool) {
		this.graduateschool = graduateschool;
	}
	/**
	 * 获取：毕业院校
	 */
	public String getGraduateschool() {
		return graduateschool;
	}
	/**
	 * 设置：所学专业
	 */
	public void setMajor1(String major1) {
		this.major1 = major1;
	}
	/**
	 * 获取：所学专业
	 */
	public String getMajor1() {
		return major1;
	}
	/**
	 * 设置：从事专业
	 */
	public void setMajor2(String major2) {
		this.major2 = major2;
	}
	/**
	 * 获取：从事专业
	 */
	public String getMajor2() {
		return major2;
	}
	/**
	 * 设置：单位性质
	 */
	public void setUnitproperty(String unitproperty) {
		this.unitproperty = unitproperty;
	}
	/**
	 * 获取：单位性质
	 */
	public String getUnitproperty() {
		return unitproperty;
	}
	/**
	 * 设置：是否院士，1是，0否
	 */
	public void setIsacademician(String isacademician) {
		this.isacademician = isacademician;
	}
	/**
	 * 获取：是否院士，1是，0否
	 */
	public String getIsacademician() {
		return isacademician;
	}
	/**
	 * 设置：技术职称
	 */
	public void setExperttitle(String experttitle) {
		this.experttitle = experttitle;
	}
	/**
	 * 获取：技术职称
	 */
	public String getExperttitle() {
		return experttitle;
	}
	/**
	 * 设置：担任职务
	 */
	public void setExpertjob(String expertjob) {
		this.expertjob = expertjob;
	}
	/**
	 * 获取：担任职务
	 */
	public String getExpertjob() {
		return expertjob;
	}
	/**
	 * 设置：在职情况,1在职，0离职
	 */
	public void setOnduty(String onduty) {
		this.onduty = onduty;
	}
	/**
	 * 获取：在职情况,1在职，0离职
	 */
	public String getOnduty() {
		return onduty;
	}
	/**
	 * 设置：移动电话
	 */
	public void setMobile(String mobile) {
		this.mobile = mobile;
	}
	/**
	 * 获取：移动电话
	 */
	public String getMobile() {
		return mobile;
	}
	/**
	 * 设置：传真
	 */
	public void setFax(String fax) {
		this.fax = fax;
	}
	/**
	 * 获取：传真
	 */
	public String getFax() {
		return fax;
	}
	/**
	 * 设置：电子邮件
	 */
	public void setEmail(String email) {
		this.email = email;
	}
	/**
	 * 获取：电子邮件
	 */
	public String getEmail() {
		return email;
	}
	/**
	 * 设置：通信地址
	 */
	public void setAddress(String address) {
		this.address = address;
	}
	/**
	 * 获取：通信地址
	 */
	public String getAddress() {
		return address;
	}
	/**
	 * 设置：邮政编码
	 */
	public void setPostcode(String postcode) {
		this.postcode = postcode;
	}
	/**
	 * 获取：邮政编码
	 */
	public String getPostcode() {
		return postcode;
	}
	/**
	 * 设置：研究领域
	 */
	public void setResearchfield(String researchfield) {
		this.researchfield = researchfield;
	}
	/**
	 * 获取：研究领域
	 */
	public String getResearchfield() {
		return researchfield;
	}
	/**
	 * 设置：研究方向
	 */
	public void setResearchdirection(String researchdirection) {
		this.researchdirection = researchdirection;
	}
	/**
	 * 获取：研究方向
	 */
	public String getResearchdirection() {
		return researchdirection;
	}
	/**
	 * 设置：熟悉语种
	 */
	public void setLanguage(String language) {
		this.language = language;
	}
	/**
	 * 获取：熟悉语种
	 */
	public String getLanguage() {
		return language;
	}
	/**
	 * 设置：熟练程度
	 */
	public void setProficiency(String proficiency) {
		this.proficiency = proficiency;
	}
	/**
	 * 获取：熟练程度
	 */
	public String getProficiency() {
		return proficiency;
	}
	/**
	 * 设置：专业简历
	 */
	public void setResume(String resume) {
		this.resume = resume;
	}
	/**
	 * 获取：专业简历
	 */
	public String getResume() {
		return resume;
	}
	/**
	 * 设置：推荐单位名称
	 */
	public void setRecommendunit(String recommendunit) {
		this.recommendunit = recommendunit;
	}
	/**
	 * 获取：推荐单位名称
	 */
	public String getRecommendunit() {
		return recommendunit;
	}
	/**
	 * 设置：工作单位名称
	 */
	public void setWorkunit(String workunit) {
		this.workunit = workunit;
	}
	/**
	 * 获取：工作单位名称
	 */
	public String getWorkunit() {
		return workunit;
	}
	/**
	 * 设置：备注
	 */
	public void setRemark(String remark) {
		this.remark = remark;
	}
	/**
	 * 获取：备注
	 */
	public String getRemark() {
		return remark;
	}
	/**
	 * 设置：创建时间
	 */
	public void setCreateTime(Date createTime) {
		this.createTime = createTime;
	}
	/**
	 * 获取：创建时间
	 */
	public Date getCreateTime() {
		return createTime;
	}
	/**
	 * 设置：创建者ID
	 */
	public void setCreateUserId(Long createUserId) {
		this.createUserId = createUserId;
	}
	/**
	 * 获取：创建者ID
	 */
	public Long getCreateUserId() {
		return createUserId;
	}
	/**
	 * 设置：修改时间
	 */
	public void setModifyTime(Date modifyTime) {
		this.modifyTime = modifyTime;
	}
	/**
	 * 获取：修改时间
	 */
	public Date getModifyTime() {
		return modifyTime;
	}
	/**
	 * 设置：修改者ID
	 */
	public void setModifyUserId(Long modifyUserId) {
		this.modifyUserId = modifyUserId;
	}
	/**
	 * 获取：修改者ID
	 */
	public Long getModifyUserId() {
		return modifyUserId;
	}
}
