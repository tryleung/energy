$(function () {
    $.ms_DatePicker({
            YearSelector: ".sel_year",
            MonthSelector: ".sel_month",
            DaySelector: ".sel_day"
    });
    $.ms_DatePicker();
    //研究领域 研究方向联动
    for (var key in researchData)
    {
        $("#researchField").append("<option value='"+key+"'>"+key+"</option>");
    }
    $("#researchField").change(function(){
        var now_researchField=$(this).val();
        $("#researchDirection").html('<option value="">请选择研究方向</option>');
        for(var k in researchData[now_researchField])
        {
            var now_researchDirection=researchData[now_researchField][k];
            $("#researchDirection").append('<option value="'+now_researchDirection+'">'+now_researchDirection+'</option>');
        }
    });
    $("#btn_close").click(function() {
    	window.close();
    	return false;
    });
    
    
    var expertId = GetQueryString("expertId");
	$.get('../sys/expert/info2/'+expertId, function(data){
		var expertObj = JSON.parse(data);
		if(expertObj.code == '0') {
			$("#expertId_id").val(expertObj.sysExpert.expertId);
			$("#name").val(expertObj.sysExpert.name);
			$("#gender").val(expertObj.sysExpert.gender=="1"?"男":"女");
			$("#nation").val(expertObj.sysExpert.nation);
			$("#party").val(expertObj.sysExpert.party);
//			$("#photoPath").html("<img src=\"../sys/expert/photo/"+expertObj.sysExpert.expertId+"\" />");
			$("#idNum").val(expertObj.sysExpert.idnum);
			$("#sel_year").val(expertObj.sysExpert.birth.substr(0,4));
			$("#sel_month").val(expertObj.sysExpert.birth.substr(5,2));
			$("#sel_day").val(expertObj.sysExpert.birth.substr(8,2));
			$("#select_highestEdu").val(expertObj.sysExpert.highestedu);
			$("#graduateSchool").val(expertObj.sysExpert.graduateschool);
			$("#major1").val(expertObj.sysExpert.major1);
			$("#major2").val(expertObj.sysExpert.major2);
			$("#unitProperty").val(expertObj.sysExpert.unitproperty);
			$("#isAcademician").val(expertObj.sysExpert.isacademician);
			$("#expertTitle").val(expertObj.sysExpert.experttitle);
			$("#expertJob").val(expertObj.sysExpert.expertjob);
			$("#onDuty").val(expertObj.sysExpert.onduty);
			$("#mobile").val(expertObj.sysExpert.mobile);
			$("#fax").val(expertObj.sysExpert.fax);
			$("#email").val(expertObj.sysExpert.email);
			$("#address").val(expertObj.sysExpert.address);
			$("#postcode").val(expertObj.sysExpert.postcode);
			$("#researchField").val(expertObj.sysExpert.researchfield);
			$("#researchDirection").val(expertObj.sysExpert.researchdirection);
			$("#language").val(expertObj.sysExpert.language);
			$("#proficiency").val(expertObj.sysExpert.proficiency);
			$("#resume").val(expertObj.sysExpert.resume);
			$("#recommendUnit").val(expertObj.sysExpert.recommendunit);
			$("#workUnit").val(expertObj.sysExpert.workunit);
			$("#remark").val(expertObj.sysExpert.remark);
		}
    });
    
    
    
    
    
    
    
    
    
    
    $("#expertId_id").attr("value",window.sessionStorage.getItem("modify_expertId"));
    $("#btn_save").click(function() {
    	if($("#name").val() == "") {
    		alert("专家姓名不能为空");
    		return false;
    	}
    	if($("#idNum").val() == "") {
    		alert("专家证件号不能为空");
    		return false;
    	}
    	if($("#researchField").val() == "") {
    		alert("研究领域不能为空");
    		return false;
    	}
    	if($("#researchDirection").val() == "") {
    		alert("研究方向不能为空");
    		return false;
    	}
    	$("#form1").ajaxSubmit(function (data) {
        });
    });
});

function GetQueryString(name)
{
     var reg = new RegExp("(^|&)"+ name +"=([^&]*)(&|$)");
     var r = window.location.search.substr(1).match(reg);
     if(r!=null)return  unescape(r[2]); return null;
}