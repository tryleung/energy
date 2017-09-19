$(function () {
    $("#jqGrid").jqGrid({
        url: '../sys/expert/list',
        datatype: "json",
        colModel: [			
			{ label: '姓名', name: 'name', index: 'name', width: 60 }, 	
			{ label: '技术职称', name: 'experttitle', index: 'expertTitle', width: 80 }, 
			{ label: '最高学历', name: 'highestedu', index: 'highestEdu', width: 80 }, 
			{ label: '担任职务', name: 'expertjob', index: 'expertJob', width: 60 }, 	
			{ label: '研究领域', name: 'researchfield', index: 'researchField', width: 80 }, 	
			{ label: '研究方向', name: 'researchdirection', index: 'researchDirection', width: 80 }, 	
			{ label: '手机号', name: 'mobile', index: 'mobile', width: 80 }, 	
			{ label: '状态', name: 'status', index: 'status', width: 40 },
			{ label: '操作列', name: 'status', index: 'status', width: 80 ,formatter: function(value, options, row){
				var html = "<a href=\"#\" id=\"show\">查看<a>&nbsp;&nbsp;<a href=\"#\">修改</a>&nbsp;&nbsp;";
				if(value == "0") {
					return html + "<a href=\"#\">启用<a>";
				} else if(value == "1") {
					return html += "<a href=\"#\">禁用<a>";
				}
			}}
			
        ],
		viewrecords: true,
        height: 385,
        rowNum: 10,
		rowList : [10,30,50],
        rownumbers: true, 
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
		reset: function () {
			vm.q.name= null;
			vm.q.highestEdu= null;
			vm.q.researchField= null;
			vm.q.researchDirection= null;
		}
	}
});