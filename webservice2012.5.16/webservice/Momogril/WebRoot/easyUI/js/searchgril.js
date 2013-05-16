$(function() {
	setDialog();

	//进入页面，焦点在用户名文本框上
	$("#loginCode").focus();
	
});

/**
 * Ajax执行搜索操作
 * @return
 */
function doSearch() {
	$("#loadmessags").html("搜索中.....");
	$.ajax( {
		async : false,
		cache : false,
		type : 'POST',
		dataType : "json",
		onClickRow:function(rowIndex, rowData){
			//取消选择某行后高亮
			$('#tt').datagrid('unselectRow', rowIndex);
		},
		url : "http://localhost:8090/Momogril/Search_SearchGril",// 请求的action路径
		data : {
			"screen_name" : $("#screen_name").val(),
			"wuid" : $("#uid").val(),
		
		},
		error : function() {// 请求失败处理函数
			alert('请求失败');
		},
		success : function(data) { // 请求成功后处理函数。
			//加载数据
			
			$('#tt').datagrid( {
				
				data : data.data
			}),
          
			$("#loadmessags").html("搜索成功");
			
			if (data == null) {
				$("#loadmessags").html("搜索失败");

			} else if (data.errorMsg != null) {//后台异常处理
			$("#loadmessags").html("搜索失败");
		}
	}
	});
}

/**
 * Ajax执行批量删除操作
 * @return
 */
function doAllDelegate(){
	
	
		var ids = [];
		
		var selectedRow = $('#tt').datagrid('getSelections');
		
		var json= JSON.stringify(selectedRow); 
		
		
		var url = "http://localhost:8090/Momogril/Search_delegate";
		changeStatus(url,json);
			
			
		
	
	
	
}

/**--------------显示图片------------------**/
function optFormater(value,row,index){
	var imageurl = row.original_pic;

	
	
	var detail = '<img src="'+imageurl+'" width="222" height="286" /> ';
	
	return detail;
};
function optFormater2(value,row,index){
	var mid = row.mid;

	var del = '<a href="#" onclick="doDel('+mid+')">删除</a>';
	
	return detail;
};

/**--------------执行删除操作------------------**/
function doDel(mdd){
	$.messager.confirm('删除提示', '你确定永久删除该数据吗?', function(r){
		if (r){
			var url = root+'/ospm/loginInfo/doLoginInfoDelete.jhtml?loginId='+loginId;
			changeStatus(url);
		}
	});
}
/**
 * 修改状态的Ajax
 * @param url
 * @return
 */
function changeStatus(url,data){
	$.ajax({
		async : false,
		cache:false,
		type: 'POST',
		data:{
		
		"listString" :data
		},
		dataType : "json",
		url:url,//请求的action路径
		error: function () {//请求失败处理函数
			alert('请求失败');
		},success:function(data){
			if(data!=null){//返回异常信息
				$.messager.alert('错误提示',data.errorMsg,'error');
			}
			reloadTable();
		}
	});
}

/**
 * 保存
 * @param url
 * @return
 */
function doSave(){
	
	alert('保存成功');
	$.ajax({
		async : false,
		cache:false,
		type: 'POST',
		data:{
		
		"screen_name" : $("#screen_name").val()
		},
		dataType : "json",
		url:"http://localhost:8090/Momogril/Search_doSaveMiuGril",//请求的action路径
		error: function () {//请求失败处理函数
			
		},success:function(data){
			if(data.status=="success"){//返回异常信息
				$.messager.alert('添加成功');
			}
			reloadTable();
		}
	});
			
			
		
	
	
	
}
