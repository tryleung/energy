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

