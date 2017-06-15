<html>
<head>
<title>컴포넌트관리 > 펜션</title>
<meta http-equiv='Content-Type' content='text/html; charset=euc-kr'>
<link rel='stylesheet' type='text/css' href='/admin/css/admin.css'>
<script language=javascript src='/admin/js/common.js'></script>
<script language=javascript src='/admin/js/admin.js'></script>
</head>

<body bgcolor='#FFFFFF' topmargin='0' leftmargin='0'>


	 <!-- 상단 TOP Menu S -->
     <jsp:include page="/admin/product/menu_top.jsp" />
     <!-- 상단 TOP Menu E -->				            
    	
	
	<table border=0 cellpadding=0 cellspacing=0 width=800>
			<tr valign=top>
							<td width=175 bgcolor=F7F7F7>
					<!--왼쪽 타이틀------------------------------------------------->
					<jsp:include page="/admin/product/menu_left.jsp" />
					<!--//왼쪽 타이틀------------------------------------------------->
						
    
    
    
					</td>
					<td width=18><img src=/admin/img/e.gif width=18></td>
					<td width="100%">
						<td align="left" width="50%">
	

<script src="/admin/js/Qwig/Qwig.js" type="text/javascript"></script>


<script language=javascript>
	var swfuboard = null;

	function getCookie(c_name) {
		if (document.cookie.length>0) {
			c_start=document.cookie.indexOf(c_name + "=");

			if (c_start!=-1) {
				c_start=c_start + c_name.length+1;
				c_end=document.cookie.indexOf(";",c_start);
				if (c_end==-1) c_end=document.cookie.length;
				return unescape(document.cookie.substring(c_start,c_end));
			}
		}
	return "";
	}

	function toggleDetailPanel( e )
	{
		var failCheck = document.getElementById( 'useDetailF' );
		if( !e )
		{
			e.returnValue = false;
			if( e.preventDefault ) e.preventDefault();
			failCheck.checked = true;
			return ;
		}

		var srcE = null;
		if( e.target ) srcE = e.target;
		else srcE = e.srcElement;

		if( !srcE )
		{
			e.returnValue = false;
			if( e.preventDefault ) e.preventDefault();
			failCheck.checked = true;
			return ;
		}

		var additionIdx = document.getElementById( 'additionIdx' );
		if( !additionIdx || !additionIdx.value )
		{
			e.returnValue = false;
			if( e.preventDefault ) e.preventDefault();
			failCheck.checked = true;
			return alert( '기본정보를 저장해 주세요' );
		}

		var panel = document.getElementById( 'detailInfo' );
		var disp = ( srcE.getAttribute( 'value' ) == 'T' ? 'inline' : 'none' );
		panel.style.display = disp;
	}

	function saveBasicInfo()
	{
		var f = document.basicInfoForm;

		for( var i = 0 , iptsLabel = { 'name' : '부가서비스명' , 'unit' : '단위' , 'price' : '가격' , 'quantity' : '수량' } , ipts = f.getElementsByTagName( 'input' ) , iptName = null ; i < ipts.length ; i++ )
		{
			iptName = ipts[ i ].getAttribute( 'name' );
			if( !iptName ) continue;
			if( !iptsLabel[ iptName ] ) continue;

			if( !ipts[ i ].value )
			{
				ipts[ i ].focus();
				return alert( iptsLabel[ iptName ] + '을 입력해 주세요' );
			}

			if( ( ( iptName == 'price' ) || ( iptName == 'quantity' ) ) && ( !/[\d]+/.test( ipts[ i ].value ) ) )
			{
				ipts[ i ].focus();
				return alert( iptsLabel[ iptName ] + '에는 숫자만 입력해 주세요' );
			}
		}

		f.submit();
	}

	function saveImageInfo()
	{
		var f = document.imageUploadForm;

		if( document.getElementById( 'useImageT' ).checked )
		{
			for( var i = 0 , imageNames = 0 , iptsLabel = { 'imageWidth' : '가로' , 'imageHeight' : '세로' } , ipts = f.getElementsByTagName( 'input' ) , iptName = null ; i < ipts.length ; i++ )
			{
				iptName = ipts[ i ].getAttribute( 'name' );
				if( iptName == 'imageNames[]' ) imageNames++;
				if( !iptName ) continue;
				if( !iptsLabel[ iptName ] ) continue;

				if( !ipts[ i ].value ) return alert( iptsLabel[ iptName ] + '을 입력해 주세요' );
				if( !/[\d]+/.test( ipts[ i ].value ) ) return alert( iptsLabel[ iptName ] + '에는 숫자만 입력해 주세요' );
			}

			if( imageNames < 1 ) return alert( '이미지가 없습니다' );
		}

		f.submit();
	}

	function startUploadBoard()
	{
		swfuboard.startUpload();
	}

	function browseBoard()
	{
		if( !swfuboard ) newSWFUploadBoard();
		swfuboard.selectFiles();
	}

	function saveDetailInfo()
	{
		var f = document.detailWriteForm;
		f.submit();
	}

	function newSWFUploadBoard()
	{
		swfuboard = new SWFUpload({
			upload_url: "/admin/component/component_upload.php",
			post_params: { 'component' : 'reservation' , 'id' : getCookie( 'PHPSESSID' ) , 'uploader' : 'product_addition_modify' },
			file_size_limit : "1024",file_types : "*.jpg;*.gif",file_types_description : "이미지 파일",file_upload_limit : 10,file_queue_error_handler : uploadHandleErrors,upload_error_handler : uploadHandleErrors,file_dialog_complete_handler : startUploadBoard ,upload_success_handler : imgUploadBoardComplete,flash_url : "/admin/daemon/SWFUpload/swfupload_f9.swf",debug: false}
		);
	}


	function addImageBoard( url )
	{
		Qwig_execute( 0 , 'insertimage' ,  url );
		return;
	}

	function imgUploadBoardComplete( fileObj, server_data )
	{
		if( ( server_data == null ) || ( server_data == undefined ) || ( server_data == 'FAIL' ) ) return alert( '파일 업로드에 실패하였습니다' );

		var result = server_data.split( ':' );
		var fileName = result[1];

		if( !result[1] ) return;

        addImageBoard( result[1] );
	}

    function start()
	{
//		if( !swfuboard ) newSWFUploadBoard();
    }

	if( window.attachEvent ) window.attachEvent( 'onload' , start );
	else window.addEventListener( 'load' , start , false );

</script>


<!--본문 타이틀------------------------------------------------------------>
<ul class="content_title">
	<li>예약모듈 관리
	<li class="location">펜션객실관리>부가서비스 관리>부가서비스 등록
</ul>

<!--본문---------------------------------------------------------------------->
<form name="basicInfoForm" method="post">

<ul class="bullet_title"><li>부가서비스 기본정보입력</ul>

<table class="product_table" id="product_addition_table">
<col width="200px"></col><col width="300px"></col><col width="150px"></col><col width="150px"></col>
	<tr>
		<th>부가서비스명</td>
		<td><input type="text" name="name" size="40" value=""></td>
		<th>단위</td>
		<td><input type="text" name="unit" size="16" value=""></td>
	</tr>
	<tr>
		<th>가격</td>
		<td><input type="text" name="price" size="30" value=""> 원</td>
		<th>예약상품 1개당<br>판매가능한 수량</td>
		<td><input type='text' name="quantity" size='10' value=""></td>
	</tr>
	<tr>
		<th>부가서비스 설명</th>
		<td colspan="3"><input type='text' name="desc" size='100' value=""></td>
	</tr>
	<!--
	<tr>
		<th>상세정보 사용여부</th>
		<td colspan="3">
			<input type='radio' id="useDetailT" name='useDetail' value="T" onclick="toggleDetailPanel( event );">
			<label for="useDetailT" hidefocus="true">사용</label>
			<input type='radio' id="useDetailF" name='useDetail' value="F" onclick="toggleDetailPanel( event );" checked>
			<label for="useDetailF" hidefocus="true">사용안함</label>
		</td>
	</tr>
	-->
</table>
<input type="hidden" name="useDetail" value="F">
<br>
<center>
	<img src="/admin/aimg/reservation/tbtn_bg_022.gif" align="absmiddle" class="imp"><input type="button" value="기본정보 저장하기" class="bt_a32 tmb22" onclick="saveBasicInfo();">
</center>
<br>

</form>
<!--본문 끝---------------------------------------------------------------------------------------->
<!-- by gckim 2008-03-19 -->


							</td>
					</tr>
				</table>
	<!--footer-->
	<jsp:include page="/admin/footer.jsp" />
	<!--//footer-->
	

</body>
</html>
