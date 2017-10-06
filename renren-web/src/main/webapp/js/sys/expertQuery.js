$(function () {
    $("#jqGrid").jqGrid({
        url: '../sys/expert/list',
        datatype: "json",
        colModel: [	
            { label: '索引', name:'expertId', index: 'expertId', width: 30},
			{ label: '姓名', name: 'name', index: 'name', width: 60 }, 	
			{ label: '技术职称', name: 'experttitle', index: 'expertTitle', width: 80 }, 
			{ label: '最高学历', name: 'highestedu', index: 'highestEdu', width: 80 }, 
			{ label: '担任职务', name: 'expertjob', index: 'expertJob', width: 60 }, 	
			{ label: '研究领域', name: 'researchfield', index: 'researchField', width: 80 }, 	
			{ label: '研究方向', name: 'researchdirection', index: 'researchDirection', width: 80 }, 	
			{ label: '手机号', name: 'mobile', index: 'mobile', width: 80 }, 	
			{ label: '状态', name: 'status', index: 'status', width: 40,formatter: function(value, options, row){
				if(value == "1") {
					return "启用";
				} else if(value == "0") {
					return "禁用";
				}
			} },
			{ label: '操作列', name: 'status', index: 'status', width: 80 ,formatter: function(value, options, row){
				return "&nbsp;<a id=\"show_btn\" class=\"abc\" href=\"#\" expertId=\""+row.expertId+"\">查看<a>";
			}}
			
        ],
		viewrecords: true,
        height: 385,
        rowNum: 10,
		rowList : [10,30,50],
        rownumbers: false, 
        rownumWidth: 25, 
        autowidth:true,
        multiselect: true,
        pager: "#jqGridPager",
        jsonReader : {
            root: "page.list",
            page: "page.currPage",
            total: "page.totalPage",
            records: "page.totalCount"
        },
        prmNames : {
            page:"page", 
            rows:"limit", 
            order: "order"
        },
        gridComplete:function(){
        	//隐藏grid底部滚动条
        	$("#jqGrid").closest(".ui-jqgrid-bdiv").css({ "overflow-x" : "hidden" }); 
        }
    });
    $("#query_btn").click(function(){
    	var page = $("#jqGrid").jqGrid('getGridParam','page');
		$("#jqGrid").jqGrid('setGridParam',{ 
			postData:{'name': $("#input_name").val(), 'highestEdu': $("#select_highestEdu").val(), 'researchField': $("#select_researchField").val(), 'researchDirection': $("#select_researchDirection").val()},
            page:page
        }).trigger("reloadGrid");
    });
    $("#reset_btn").click(function(){
    	$("#input_name").val("");
    	$("#select_highestEdu").val("");
    	$("#select_researchField").val("");
    	$("#select_researchDirection").val("");
    });
    
  //研究领域 研究方向联动
    for (var key in researchData)
    {
        $("#select_researchField").append("<option value='"+key+"'>"+key+"</option>");
    }
    $("#select_researchField").change(function(){
        var now_researchField=$(this).val();
        $("#select_researchDirection").html('<option value="">请选择研究方向</option>');
        for(var k in researchData[now_researchField])
        {
            var now_researchDirection=researchData[now_researchField][k];
            $("#select_researchDirection").append('<option value="'+now_researchDirection+'">'+now_researchDirection+'</option>');
        }
    });
    $("#jqGrid").on("click","#show_btn",function(){
    	var expertId = $(this).attr("expertid");
    	window.open("../sys/expertDetail.html?expertId=" + expertId);
    });
    $("#jqGrid").on("click","#modify_btn",function(){
    	var expertId = $(this).attr("expertid");
    	window.sessionStorage.setItem("modify_expertId",expertId);
    	window.open("../sys/expertModify.html?expertId=" + expertId);
    });
    $("#jqGrid").on("click","#onoff",function(){
    	var oper = $(this).attr("oper");
    	var expertId = $(this).attr("expertid");
    	var data = {"expertId":expertId,"status":oper};
    	$.ajax({
			type: "POST",
		    url: "../sys/expert/onoff",
            contentType: "application/json",
		    data: JSON.stringify(data),
		    success: function(r){
				if(r.code == 0){
					alert('操作成功', function(index){
						$("#jqGrid").trigger("reloadGrid");
					});
				}else{
					alert(r.msg);
				}
			}
		});
    });
});

var vm = new Vue({
	el:'#rrapp',
	data:{
		showList: true,
		title: null,
		sysExpert: {},
		q:{
			name: null,
			highestEdu: null,
			researchField: null,
			researchDirection: null
		}
	},
	methods: {
		query: function () {
			vm.reload();
		},
		add: function(){
			vm.showList = false;
			vm.title = "新增";
			vm.sysExpert = {};
		},
		update: function (event) {
			var expertId = getSelectedRow();
			if(expertId == null){
				return ;
			}
			vm.showList = false;
            vm.title = "修改";
            
            vm.getInfo(expertId)
		},
		saveOrUpdate: function (event) {
			var url = vm.sysExpert.expertId == null ? "../sys/expert/save" : "../sys/expert/update";
			$.ajax({
				type: "POST",
			    url: url,
                contentType: "application/json",
			    data: JSON.stringify(vm.sysExpert),
			    success: function(r){
			    	if(r.code === 0){
						alert('操作成功', function(index){
							vm.reload();
						});
					}else{
						alert(r.msg);
					}
				}
			});
		},
		del: function (event) {
			var expertIds = getSelectedRows();
			if(expertIds == null){
				return ;
			}
			
			confirm('确定要删除选中的记录？', function(){
				$.ajax({
					type: "POST",
				    url: "../sys/expert/delete",
                    contentType: "application/json",
				    data: JSON.stringify(expertIds),
				    success: function(r){
						if(r.code == 0){
							alert('操作成功', function(index){
								$("#jqGrid").trigger("reloadGrid");
							});
						}else{
							alert(r.msg);
						}
					}
				});
			});
		},
		getInfo: function(expertId){
			$.get("../sys/expert/info/"+expertId, function(r){
                vm.sysExpert = r.sysExpert;
            });
		},
		reload: function (event) {
			vm.showList = true;
			var page = $("#jqGrid").jqGrid('getGridParam','page');
			$("#jqGrid").jqGrid('setGridParam',{ 
				postData:{'name': vm.q.name, 'highestEdu': vm.q.highestEdu, 'researchField': vm.q.researchField, 'researchDirection': vm.q.researchDirection},
                page:page
            }).trigger("reloadGrid");
		},
		show: function () {
			var expertId = getSelectedRow();
			
			if(expertId == null){
				return ;
			}
		    window.open("../sys/expertDetail.html?expertId=" + expertId);
		},
		addExpert: function() {
			window.open("../sys/expertAdd.html");
		},
		importExcel: function() {
			window.open("../sys/excelUpload.html",'','height=100,width=400,top=400,left=400,toolbar=no,menubar=no,scrollbars=no, resizable=no,location=no, status=no');
//			window.open("../sys/excelUpload.html");
		}
	}
});