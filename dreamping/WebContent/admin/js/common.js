function isMixedNumStr(str)
{
	theValue=false;

	for(i=0; i<str.length; i++)
	{
		cha = str.substring(i,i+1);
		if ( !((cha >= "A" && cha <= "Z") || (cha >= "a" && cha <= "z") || (cha >= 0 && cha <= 9)) )
		{
			theValue=true;
			break;
		}
	}
	return theValue;
}

function isHexStr(str)
{
	for(i=0; i<str.length; i++)
	{
		if( !((str.charAt(i) >= 0 && str.charAt(i) <= 9) || (str.charAt(i).toUpperCase() >= 'A' && str.charAt(i).toUpperCase() <= 'F')) ) return true;
	}

	return false;
}

function isValidInt(str)
{
	for(i=0; i<str.length; i++)
	{
		if(!(str.charAt(i) >= 0 && str.charAt(i) <= 9)) return true;
	}

	return false;
}

// 숫자형이 아닌 문자제거
function removeValidInt(str)
{
	var re_txt="";

	for(i=0; i<str.length; i++)
	{
		if(str.charAt(i) >= 0 && str.charAt(i) <= 9) re_txt += str.charAt(i);
	}

	return re_txt;
}

function isValidPassword(str)
{
	theValue=false;

	for(i=0; i<str.length; i++)
	{
		cha = str.substring(i,i+1);

		if ( cha <= "9" && cha >= "0" ) theValue=true;
		else if ( (cha >= "A") && (cha <= "Z")) theValue=true;
		else if ( (cha >= "a") && (cha <= "z")) theValue=true;
		else return false;
	}
	return theValue;
}


function isValidEmail(email)
{
	invalidChars = " /:,;";
	if(email == "") {
		return false;
	}
	for(i=0;i<invalidChars.length;i++) {
		badchar = invalidChars.substring(i,i+1);
		if(email.indexOf(badchar, 0) > -1) {
			return false;
		}
	}
	atPos = email.indexOf("@",1);
	if(atPos == -1) {
		return false;
	}
	if(email.indexOf("@",atPos+1) > -1) {
		return false;
	}
	periodPos = email.indexOf(".",atPos)
	if(periodPos == -1) {
		return false;
	}
	if(periodPos + 3 > email.length) {
		return false;
	}
	return true;
}

function CheckAll()
{
	chk = document.getElementById('allcheck').checked;

	for (var i=0;i<document.forms[0].elements.length;i++)
	{
		document.forms[0].elements[i].checked = chk;
	}
}

function CheckList()
{
	var count = 0;

	for (var i = 0; i < document.forms[0].elements.length; i++)
	{
		if (document.forms[0].elements[i].name == "chk[]" && document.forms[0].elements[i].checked == true)
		{
			return true;
		}
	}

	return false;
}

function WinOpen(win_url,win_name,win_width,win_height,win_scroll)
{
	window.open (win_url, win_name, "resizable=1,scrollbars="+win_scroll+",width="+win_width+",height="+win_height+",screenX=0,screenY=0,left=50,top=50");
}

function CheckStrLen(str)
{
	var i, len = 0;

	for(i=0;i < str.length; i++)
		(str.charCodeAt(i) > 255)? len+=2:len++;

	return len;
}

function GetFileType(fileobj)
{
	pathpoint = fileobj.lastIndexOf('.');
	filepoint = fileobj.substring(pathpoint+1,fileobj.length);
	filetype = filepoint.toLowerCase();

	return filetype;
}

function CheckWord(str)
{
	var chk_word = ['\<\!--'];

	for (var i=0;i<chk_word.length;i++)
	{
		re_chk = new RegExp(chk_word[i],"i");
		if (re_chk.test(str))
			return re_chk.source;
	}
	return false;
}

// 우편번호검색
function com_member_zipcode(name1, name2, name3) {
	window.open("/chtml/zipcode.php?template=default&com_zipcode_openerform=document.com_member&com_zipcode_openername1=document.com_member." + name1 + "&com_zipcode_openername2=document.com_member." + name2 + "&com_zipcode_openername3=document.com_member." + name3, "cafe_component_zipcode", "width=447,height=370,scrollbars=yes");
}