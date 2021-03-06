%rebase base position='文件分享'
<script src="/assets/js/clipboard/clipboard.min.js"></script>
<div class="page-body">
    <div class="row">
        <div class="col-lg-12 col-md-12 col-sm-12 col-xs-12">
            <div class="widget">
                <div class="widget-header bordered-bottom bordered-themesecondary">
                    <i class="widget-icon fa fa-tags themesecondary"></i>
                    <span class="widget-caption themesecondary">文件分享</span>
                    <div class="widget-buttons">
                        <a href="#" data-toggle="maximize">
                            <i class="fa fa-expand"></i>
                        </a>
                        <a href="#" data-toggle="collapse">
                            <i class="fa fa-minus"></i>
                        </a>
                        <a href="#" data-toggle="dispose">
                            <i class="fa fa-times"></i>
                        </a>
                    </div>

                </div><!--Widget Header-->
                <div style="padding:-10px 0px;" class="widget-body no-padding">
                    <div class="tickets-container">
                        <div class="table-toolbar" style="float:left">
                            <a id="ulfileshare" href="/ulfileshare" class="btn btn-primary ">
                                <i class="btn-label fa fa-cloud-upload"></i>文件上传
                            </a>
                            <span style="color:#666666;">注意:&nbsp;如果要生成链接，文件名称尽量不要含有中文或特殊字符，以免下载异常</span>
                            %if msg.get('message'):
                                <span style="color:{{msg.get('color','')}};font-weight:bold;">&emsp;{{msg.get('message','')}}</span>
                            %end
                        </div>
                       <table id="myLoadTable" class="table table-bordered table-hover"></table>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
<script type="text/javascript">
$(function(){
    /**
    *表格数据
    */
    var editId;        //定义全局操作数据变量
    var isEdit;
    $('#myLoadTable').bootstrapTable({
          method: 'post',
          url: '/api/getfileshareinfo',
          contentType: "application/json",
          datatype: "json",
          cache: false,
          checkboxHeader: true,
          striped: true,
          pagination: true,
          pageSize: 15,
          pageList: [10,20,50],
          search: true,
          showColumns: true,
          showRefresh: true,
          minimumCountColumns: 2,
          clickToSelect: true,
          smartDisplay: true,
          //sidePagination : "server",
          sortOrder: 'asc',
          sortName: 'id',
          columns: [{
              field: 'xid',
              title: '编号',
              align: 'center',
              valign: 'middle',
              width:25,
              //sortable: false,
	      formatter:function(value,row,index){
                return index+1;
              }
          },{
              field: 'filename',
              title: '文件名称',
              align: 'center',
              valign: 'middle',
              sortable: false,
          },{
              field: 'filetime',
              title: '创建时间',
              align: 'center',
              valign: 'middle',
              sortable: false
          },{
              field: 'filesize',
              title: '文件大小',
              align: 'center',
	      valign: 'middle',
              sortable: false
	 },{
              field: '',
              title: '操作',
              align: 'center',
              valign: 'middle',
              width:200,
              formatter:getinfo
          }]
      });

    //定义列操作
    function getinfo(value,row,index){
        eval('rowobj='+JSON.stringify(row));
        //定义编辑按钮样式，只有管理员或自己编辑的任务才有权编辑
        //if("{{session.get('access',None)}}" == '1' || "{{session.get('name',None)}}" == rowobj['userid']){
	    if ("{{urladdr.get('url','None')}}" == '1' )  {
                var style_download = '&nbsp;<a class="btn-sm btn-info" disabled>';
	    }else{
		var style_download = '&nbsp;<button class="btncwf" data-clipboard-text="{{urladdr.get('url','None')}}/filesharesign/'+rowobj['signdata']+'">';
	    }
        //定义删除按钮样式，只有管理员或自己编辑的任务才有权删除
        //if({{session.get('access',None)}} == '1' || "{{session.get('name',None)}}" == rowobj['userid']){
        //    var style_del = '&nbsp;<a href="/delbackupset/'+rowobj['filename']+'" class="btn-sm btn-danger" onClick="return confirm(&quot;确定删除?&quot;)"> ';
        //}else{
        //    var style_del = '&nbsp;<a class="btn-sm btn-danger" disabled>';
        //}

        return [
            style_download,
                '<i class="fa fa-download">复制链接</i>',
            '</button>',

            /*style_del,
                '<i class="fa fa-times"> 删除</i>',
            '</a>'*/
        ].join('');
    }
})
</script>

<script type="text/javascript">
function myCopy(){
	var ele = document.getElementById("textdata");
	ele.select();
	document.execCommand("Copy");
	alert("复制成功");
}
</script>
<script>
    var clipboard = new Clipboard('.btncwf');

    clipboard.on('success', function(e) {
        alert("链接已复制到剪切板");
    });

    clipboard.on('error', function(e) {
        console.log(e);
    });
</script>
