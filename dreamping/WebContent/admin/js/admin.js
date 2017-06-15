/*모든 onclick에 this.blur()*/

/*
function bluring(){
if(event.srcElement.tagName=="A"||event.srcElement.tagName=="IMG"||event.srcElement.tagName=="INPUT") document.body.focus();
}
document.onfocusin=bluring;
*/

/*결제하기의 토글*/
var old_menu = '';
function menuclick( submenu)
{
if( old_menu != submenu ) {
if( old_menu !='' ) {
old_menu.style.display = 'none';
}
submenu.style.display = 'block';
old_menu = submenu;
} else {
submenu.style.display = 'none';
old_menu = '';
}
}



/*서비스 사용량 모니터링*/
function Show(name) {
    document.all[name].style.display = 'block';
}

  function go_submit()
  {
	var f = document.frm;
	var ul;
	//if(f.service.value == ''){
	//	 alert('서비스를 선택해 주십시오');
	//}
	//else
	//{
    		ul = "/front/php/payment/payment.php?service_type=add_option&email="+f.email.value+"&product_name="+f.product_name.value+"&product_code="+f.product_code.value+"&total_price="+f.total_price.value+"&service_kind="+f.service_kind.value+"&service="+f.service.value;
    		option = 'status:false; dialogWidth: 500px; dialogHeight: 450px; help:no; dialogLeft:120px; dialogTop:150; status:no;scroll:no;'
    		var oWin = showModalDialog( ul, window, option );
    	//}

  } // end of go_submit()



/*file 버튼 이미지로*/
 function file_browse()
    {
        document.form.file.click();
        document.form.text1.value=document.form.file.value;
    }



/*게시판 관리 유형별 레이어 보이기*/
function showDiv1(name1) {
	document.getElementById("show"+name1).style.display = "block";
	document.getElementById("hidden"+name1).style.display = "none";
	document.getElementById("show"+name1).style.position = "static";
	document.getElementById("hidden"+name1).style.position = "absolute";
}

function hiddenDiv1(name1) {
	document.getElementById("hidden"+name1).style.display = "block";
	document.getElementById("show"+name1).style.display = "none";
	document.getElementById("hidden"+name1).style.position = "static";
	document.getElementById("show"+name1).style.position = "absolute";
}



/*게시판 관리 이동창*/
function form_check()
{
	if ( document.frm.is_std[1].checked == true )
	{
		if ( input_format_check ( "frm", "category_name", "카테고리 명칭" ,"E" ,1, 40) == false )
			return false ;
	}

	if ( document.frm.access_type[2].checked == true )
	{
		if ( frm.access_group_list.length == "0" )
		{
			alert("접근 회원그룹을 설정해주십시오" ) ;
			return false ;
		}

		for ( i=0 ; i < frm.access_group_list.length ; i++ )
		{
			frm.current_category_access_group.value += frm.access_group_list[i].value ;

			if ( i != frm.access_group_list.length-1 )
				frm.current_category_access_group.value += ":" ;
		}
	}
	document.frm.action = 'category_create.php' ;
	document.frm.submit();
}

function add_group()
{
        if ( frm.total_group_list.length == 0 )
        {
                alert("등록할 그룹이 없습니다.\n그룹 등록을 먼저 해주세요") ;
                return false ;
        }

        if ( frm.total_group_list.selectedIndex == '-1' )
        {
                alert("등록할 그룹을 먼저 선택해주세요");
                return false ;
        }

	var selected_idx = frm.total_group_list.selectedIndex ;
	var t = frm.access_group_list.length++;

	frm.access_group_list[t].value = frm.total_group_list[selected_idx].value;
	frm.access_group_list[t].text = frm.total_group_list[selected_idx].text;
	frm.access_group_list[t].selected = true;

	j = 0 ;
	for( i=0 ; i < frm.total_group_list.length ; i++ )
	{
		if ( i != selected_idx )
		{
			frm.total_group_list[j].value = frm.total_group_list[i].value ;
			frm.total_group_list[j].text = frm.total_group_list[i].text ;
			j++ ;
		}
	}
	frm.total_group_list.length--;
}

function del_group()
{
        if ( frm.access_group_list.length == 0 )
        {
                alert("제거할 그룹이 없습니다.\n그룹 등록을 먼저 해주세요") ;
                return false ;
        }

        if ( frm.access_group_list.selectedIndex == '-1' )
        {
                alert("제거할 그룹을 먼저 선택해주세요");
                return false ;
        }

	var selected_idx = frm.access_group_list.selectedIndex ;
	var t = frm.total_group_list.length++;

	frm.total_group_list[t].value = frm.access_group_list[selected_idx].value;
	frm.total_group_list[t].text = frm.access_group_list[selected_idx].text;
	frm.total_group_list[t].selected = true;

	j = 0 ;
	for( i=0 ; i < frm.access_group_list.length ; i++ )
	{
		if ( i != selected_idx )
		{
			frm.access_group_list[j].value = frm.access_group_list[i].value ;
			frm.access_group_list[j].text = frm.access_group_list[i].text ;
			j++ ;
		}
	}
	frm.access_group_list.length--;
}


/*컬러선택*/
function colorTb(frm, view_frm)
{
	window.open('/admin/component/colortable.php?frm=' + frm + '&view_frm=' + view_frm,'ctable','resizable=false,width=320,height=190,scrollbars=no');
}

function colorView(frm, view_frm)
{
	var val = frm.value;
	val = val.replace(/#/g,'');

	if(val && !(isHexStr(val)))
	{
		if(val.length < 6)
		{
			var blank = '';
			for(i=1; i<=(6 - val.length); i++) blank += '0';
			val = '#' + val + blank;
			view_frm.style.backgroundColor = val;
		}
		else if(val.length == 6) view_frm.style.backgroundColor = val;
	}
}


// 입력값 형식 체크
	function check_value(obj, type)
	{
		var val = obj.value;

		if(type == "int")
		{
			if(val.length > 0 && isValidInt(val))
			{
				re_txt = removeValidInt(val);
				alert('숫자만 입력이 가능합니다.');
				if(re_txt) obj.value = re_txt;
				obj.focus();
			}
		}
		else if(type == "alphanum")
		{
			if(val.length > 0 && isMixedNumStr(val))
			{
				alert('영문자와 숫자만 입력이 가능합니다.');
				obj.focus();
			}
		}
	}

// 항목관리의 셀렉트박스/체크박스/라디오버튼항목에 "," 사용불가
	function check_titlevalue(obj)
	{
		var obj_val = obj.value;
		var result = true;
		var re_val = "";

		for(i=0; i<obj_val.length; i++)
		{
			if(obj_val.charAt(i) == ",")
			{
				result = false;
				break;
			}
		}

		if(result == false)
		{
			for(i=0; i<obj_val.length; i++)
			{
				if(obj_val.charAt(i) != ",") re_val += obj_val.charAt(i);
			}

			alert("항목에 ','는 사용할 수 없습니다.");
			obj.value = re_val;
			obj.focus();
		}
	}


/**********************************************************************************************************/
// 셀렉트박스 순서 설정
	var org_arr = new Array();
	var new_arr = new Array();

	function view_list(type, list)
	{
		var arr_len = 0;
		var arr;
		var list;

		switch(type)
		{
			// orginal
			case 1 : arr = org_arr; break;
			// new
			case 2 : arr = new_arr; break;
		}

		arr_len = arr.length;
		list.length = arr_len;

		for(i=0; i<arr_len; i++)
		{
			list.options[i].text = arr[i]['text'];
			list.options[i].value = arr[i]['value'];
		}
	}

	// ->
	function add_list(o_list, n_list)
	{
		var o_list_len = o_list.length;
		var n_list_len = n_list.length;
		var exists = false;

		for(i=0,n=0,c=0; i<o_list.length; i++)
		{
			if(o_list.options[i].selected == true && o_list.options[i].value != '')
			{
				exists = true;
				for(j=0; j<n_list_len; j++)
				{
					if(n_list.options[j].value == o_list.options[i].value && n_list.options[j].text == o_list.options[i].text)
					{
						exists = false;
						break;
					}
				}

				if(exists == true)
				{
					n_list_len++;
					n_list.length = n_list_len;

					var idx = n_list_len - 1;

					n_list.options[idx].text = o_list.options[i].text;
					n_list.options[idx].value = o_list.options[i].value;

					idx = new_arr.length;

					new_arr[idx] = new Array();
					new_arr[idx]['text'] = o_list.options[i].text;
					new_arr[idx]['value'] = o_list.options[i].value;
					c++;
				}
				else
				{
					rewrite_arr(1, n, o_list.options[i].text, o_list.options[i].value);
					n++;
				}
			}
			else
			{
				rewrite_arr(1, n, o_list.options[i].text, o_list.options[i].value);
				n++;
			}
		}

		if(exists == true)
		{
			org_arr.length = org_arr.length - c;
			view_list(1, o_list);
		}
	}

	// <-
	function remove_list(o_list, n_list)
	{
		var o_list_len = o_list.length;
		var n_list_len = n_list.length;
		var idx = '';

		for(i=0,n=0,c=0; i<n_list_len; i++)
		{
			if(n_list.options[i].selected == true)
			{
				o_list_len++;
				o_list.length = o_list_len;

				// 기본항목
				var tmp = n_list.options[i].value.split('|');
				if(tmp[0] == 0)
				{
					for(j=1; j<(o_list_len-1); j++)
					{
						if(!idx && o_list.options[j].value == '') idx = j;
						if(idx && j >= idx) rewrite_arr(1, j+1, o_list.options[j].text, o_list.options[j].value);
					}
				}

				if(!idx) idx = o_list_len - 1;

				o_list.options[idx].text = n_list.options[i].text;
				o_list.options[idx].value = n_list.options[i].value;

				rewrite_arr(1, idx, o_list.options[idx].text, o_list.options[idx].value);
				c++;
			}
			else
			{
				rewrite_arr(2, n, n_list.options[i].text, n_list.options[i].value);
				n++;
			}
		}

		new_arr.length = new_arr.length - c;
		view_list(2, n_list);
		view_list(1, o_list);
	}

	// ->,<- 의 작업에 따라 org_arr, new_arr 변수를 재설정한다.
	function rewrite_arr(type, idx, text, value)
	{
		if(type == 1)
		{
			org_arr[idx] = new Array();

			org_arr[idx]['text'] = text;
			org_arr[idx]['value'] = value;
		}
		else if(type == 2)
		{
			new_arr[idx] = new Array();

			new_arr[idx]['text'] = text;
			new_arr[idx]['value'] = value;
		}
	}

	// 리스트의 순서변경
	function move_seq(type, n_list, num)
	{
		var n_list_len = n_list.length;
		var new_idx = n_list.selectedIndex;
		var tmp = new Array();

		if(new_idx < 0)
		{
			alert('항목을 선택하세요.');
			return;
		}

		switch(type)
		{
			// 맨위로 이동
			case 1 :
				tmp['newtext'] = n_list.options[new_idx].text;
				tmp['newvalue'] = n_list.options[new_idx].value;

				for(i=new_idx; i>0; i--)
				{
					n_list.options[i].text = n_list.options[i-1].text;
					n_list.options[i].value = n_list.options[i-1].value;
				}

				n_list.options[0].text = tmp['newtext'];
				n_list.options[0].value = tmp['newvalue'];

				n_list.options[0].selected = true;
				break;
			// 한칸 위로 이동
			case 2 :
				if(new_idx == 0) break;

				tmp['newtext'] = n_list.options[new_idx].text;
				tmp['newvalue'] = n_list.options[new_idx].value;

				n_list.options[new_idx].text = n_list.options[new_idx-1].text;
				n_list.options[new_idx].value = n_list.options[new_idx-1].value;

				n_list.options[new_idx-1].text = tmp['newtext'];
				n_list.options[new_idx-1].value = tmp['newvalue'];

				n_list.options[new_idx-1].selected = true;
				break;
			// 한칸 아래로 이동
			case 3 :
				if(new_idx == (n_list_len-1)) break;

				tmp['newtext'] = n_list.options[new_idx].text;
				tmp['newvalue'] = n_list.options[new_idx].value;

				n_list.options[new_idx].text = n_list.options[new_idx+1].text;
				n_list.options[new_idx].value = n_list.options[new_idx+1].value;

				n_list.options[new_idx+1].text = tmp['newtext'];
				n_list.options[new_idx+1].value = tmp['newvalue'];

				n_list.selectedIndex = new_idx+1;
				n_list.options[new_idx+1].selected = true;
				break;
			// 맨아래로 이동
			case 4 :
				tmp['newtext'] = n_list.options[new_idx].text;
				tmp['newvalue'] = n_list.options[new_idx].value;

				for(i=new_idx; i<(n_list_len-1); i++)
				{
					n_list.options[i].text = n_list.options[i+1].text;
					n_list.options[i].value = n_list.options[i+1].value;
				}

				n_list.options[n_list_len-1].text = tmp['newtext'];
				n_list.options[n_list_len-1].value = tmp['newvalue'];

				n_list.options[n_list_len-1].selected = true;
				break;
			// 원하는 위치로 이동
			case 5 :
				for(i=0; i<=num.length; i++)
				{
					if(!(num.charAt(i) >= 0 && num.charAt(i) <= 9))
					{
						alert('이동할 위치는 숫자만 지정해 주세요.');
						break;
					}
				}

				if(num < 1 || num > n_list_len)
				{
					alert('이동할 위치가 잘못 지정되었습니다.');
					break;
				}

				tmp['newtext'] = n_list.options[new_idx].text;
				tmp['newvalue'] = n_list.options[new_idx].value;

				if(num > new_idx)
				{
					for(i=new_idx; i<(num-1); i++)
					{
						n_list.options[i].text = n_list.options[i+1].text;
						n_list.options[i].value = n_list.options[i+1].value;
					}
				}
				else
				{
					for(i=new_idx; i>=num; i--)
					{
						n_list.options[i].text = n_list.options[i-1].text;
						n_list.options[i].value = n_list.options[i-1].value;
					}
				}

				n_list.options[num-1].text = tmp['newtext'];
				n_list.options[num-1].value = tmp['newvalue'];

				n_list.options[num-1].selected = true;
				break;
		}
	}

	//게시판 스킨관리 창 2008-11-26 추가
	function move_skin()
	{
		window.open('menu.php?component=board&file=bbs_skin_admin', 'skin_admin', 'toolbar=no,scrollbars=auto,top=200,left=300,width=990,height=750');
	}
/**********************************************************************************************************/
