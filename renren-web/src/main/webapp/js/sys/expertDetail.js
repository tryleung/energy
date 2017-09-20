$(function () {
	var expertId = GetQueryString("expertId");
	$.get('../sys/expert/info2/'+expertId, function(data){
		var expertObj = JSON.parse(data);
		if(expertObj.code == '0') {
			$("#name").text(expertObj.sysExpert.name);
			$("#gender").text(expertObj.sysExpert.gender=="1"?"男":"女");
			$("#nation").text(expertObj.sysExpert.nation);
			$("#party").text(expertObj.sysExpert.party);
			$("#photoPath").html("<img src=\"../sys/expert/photo/"+expertObj.sysExpert.expertId+"\" />");
			$("#idNum").text(expertObj.sysExpert.idnum);
			$("#birth").text(expertObj.sysExpert.birth);
			$("#highestEdu").text(expertObj.sysExpert.highestedu);
			$("#graduateSchool").text(expertObj.sysExpert.graduateschool);
			$("#major1").text(expertObj.sysExpert.major1);
			$("#major2").text(expertObj.sysExpert.major2);
			$("#unitProperty").text(expertObj.sysExpert.unitproperty);
			$("#isAcademician").text(expertObj.sysExpert.isacademician=="1"?"是":"否");
			$("#expertTitle").text(expertObj.sysExpert.experttitle);
			$("#expertJob").text(expertObj.sysExpert.expertjob);
			$("#onDuty").text(expertObj.sysExpert.onduty=="1"?"是":"否");
			$("#mobile").text(expertObj.sysExpert.mobile);
			$("#fax").text(expertObj.sysExpert.fax);
			$("#email").text(expertObj.sysExpert.email);
			$("#address").text(expertObj.sysExpert.address);
			$("#postcode").text(expertObj.sysExpert.postcode);
			$("#researchField").text(expertObj.sysExpert.researchfield);
			$("#researchDirection").text(expertObj.sysExpert.researchdirection);
			$("#language").text(expertObj.sysExpert.language);
			$("#proficiency").text(expertObj.sysExpert.proficiency);
			$("#resume").text(expertObj.sysExpert.resume);
			$("#recommendUnit").text(expertObj.sysExpert.recommendunit);
			$("#workUnit").text(expertObj.sysExpert.workunit);
			$("#remark").text(expertObj.sysExpert.remark);
		}
    });
	
	$("#btn_close").click(function(){
		window.close();
	});
});

function GetQueryString(name)
{
     var reg = new RegExp("(^|&)"+ name +"=([^&]*)(&|$)");
     var r = window.location.search.substr(1).match(reg);
     if(r!=null)return  unescape(r[2]); return null;
}
