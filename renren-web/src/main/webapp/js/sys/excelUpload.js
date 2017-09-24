$(function () {
    $(":button").click(function () {
        ajaxFileUpload();
    })
})
function ajaxFileUpload() {
    $.ajaxFileUpload
    (
        {
            url: '/../sys/expert/upload', //用于文件上传的服务器端请求地址
            secureuri: false, //是否需要安全协议，一般设置为false
            fileElementId: 'file', //文件上传域的ID
            dataType: 'content', //返回值类型 一般设置为json
            success: function (data, status)  //服务器成功响应处理函数
            {
            	var resObj = JSON.parse(data);
            	if(resObj.code == "0") {
            		$("#message").text("您已经成功上传"+resObj.count+"个专家");
            	} else {
            		var msg = resObj.msg;
            		if(msg != null && msg != "") {
            			$("#message").text(msg);
            		} else {
            			$("#message").text("文件格式或数据不对，请检查后重新上传");
            		}
            		
            	}
                
            },
            error: function (data, status, e)//服务器响应失败处理函数
            {
            	$("#message").text("上传出错");
            }
        }
    )
    return false;
}