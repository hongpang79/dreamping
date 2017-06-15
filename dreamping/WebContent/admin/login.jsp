<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<html>
<head>
<meta http-equiv='Content-Type' content='text/html; charset=UTF-8'>
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">

<title>UrbanSlowCity 관리</title>
<link rel="icon" href="/favicon.ico" type="image/x-icon" />
<link rel="shortcut icon" href="/images/favicon.png" type="image/x-icon" />
<link rel="apple-touch-icon" href="/images/apple-touch-icon.png" />

<script language="JavaScript" type="text/JavaScript">
    function setCookie( name, value, expiredays )
    {
         var todayDate = new Date();
         todayDate.setDate( todayDate.getDate() + expiredays );
         document.cookie = name + "=" + escape( value ) + "; path=/; expires=" + todayDate.toGMTString() + ";";
    }
    function getCookie( name )
    {
         var nameOfCookie = name + "=";
         var x = 0;
         while ( x <= document.cookie.length ){
                 var y = (x+nameOfCookie.length);

                 if ( document.cookie.substring( x, y ) == nameOfCookie ) {
                         if ( (endOfCookie=document.cookie.indexOf( ";", y )) == -1 )
                                         endOfCookie = document.cookie.length;
                         return unescape( document.cookie.substring( y, endOfCookie ) );
                 }

                 x = document.cookie.indexOf( " ", x ) + 1;

                 if ( x == 0 )
                         break;
         }

         return "";
    }
    function e_close()
    {
         setCookie( "E_event", "E_event" , 1);

         document.body.removeChild(document.getElementById('temp_login'));
    }
    function layoutOpen()
    {
        if ( getCookie( "E_event" ) != "E_event" ){
            var div = document.createElement('DIV');
            div.id = 'temp_login';
            div.style.cursor = 'hand';
            div.style.border = '2px solid #000000';
            div.style.zIndex = 1;
            div.style.position = 'absolute';
            div.style.top = 20;
            div.style.left = 20;
            div.style.backgroundColor = '#F1F1F1';
            if(window.XMLHttpRequest) {
                div.innerHTML = '<img src="/admin/img/login/login_ie_78.jpg" onclick="document.body.removeChild(document.getElementById(\'temp_login\'));"><div style="padding-bottom:5px" align="right"><a href="#" onclick="e_close()"><b>오늘하루 그만보기</b></a></div>';
            } else {
                div.innerHTML = '<img src="/admin/img/login/login_ie_6.jpg" onclick="document.body.removeChild(document.getElementById(\'temp_login\'));"><div style="padding-bottom:5px" align="right"><a href="#" onclick="e_close()"><b>오늘하루 그만보기</b></a></div>';
            }
            document.body.appendChild(div);
        }
    }

    function popup_win(url)
    {
            window.open(url,'udb','resizable=false,width=1000,height=600,scrollbars=yes');
    }

    function login_chkform(f)
    {
        if (f.hosting_id.value.match(/^\s*$/)) {
            alert('아이디를 입력하세요.');
            f.hosting_id.focus();
            return false;
        }

        if (typeof f.login_id != "undefined" && f.login_id.value.match(/^\s*$/)) {
            alert('로그인 아이디를 입력하세요.');
            f.login_id.focus();
            return false;
        }

        if (f.passwd.value.match(/^\s*$/)) {
            alert('비밀번호를 입력하세요.');
            f.passwd.focus();
            return false;
        }

        expireDate = new Date;
        expireDate.setDate(expireDate.getDate()+ 30);



setDomain = 'urbanslowcity.com';
        if (f.save_hosting_id.checked) {
            IDSetCookie ("save1fd", "Y", expireDate, "/", setDomain, 0);
            IDSetCookie ("myhostingid", f.hosting_id.value, expireDate, "/", setDomain, 0);
        } else {
            IDSetCookie ("save1fd", "N", expireDate, "/", setDomain, 0);
        }

        if (typeof f.login_id != "undefined" && f.save_login_id.checked) {
            IDSetCookie ("save2fd", "Y", expireDate, "/", setDomain, 0);
            IDSetCookie ("myloginid", f.login_id.value, expireDate, "/", setDomain, 0);
        } else {
            IDSetCookie ("save2fd", "N", expireDate, "/", setDomain, 0);
        }

        IDSetCookie ("mypasswd", '', expireDate, "/", setDomain, 0);


    }


    function IDgetCookieVal (offset) {
      var endstr = document.cookie.indexOf (";", offset);
      if (endstr == -1)
        endstr = document.cookie.length;
      return unescape(document.cookie.substring(offset, endstr));
    }


    function IDGetCookie (name) {
      var arg = name + "=";
      var alen = arg.length;
      var clen = document.cookie.length;
      var i = 0;
      while (i < clen) {
        var j = i + alen;
        if (document.cookie.substring(i, j) == arg)
          return IDgetCookieVal (j);
        i = document.cookie.indexOf(" ", i) + 1;
        if (i == 0) break;
      }
      return null;
    }

    function IDSetCookie (name,value,expires,path,domain,secure) {
      document.cookie = name + "=" + escape (value) +
        ((expires) ? "; expires=" + expires.toGMTString() : "") +
        ((path) ? "; path=" + path : "") +
        ((domain) ? "; domain=" + domain : "") +
        ((secure) ? "; secure" : "");
    }

    function IDstart()
    {
        /*로그인 안되는 경우 안내 layer[2010-11-05 close]
        layoutOpen();
        */
        var save_1 = IDGetCookie("save1fd");
        var save_2 = IDGetCookie("save2fd");

        /**
         * AT신청 후 관리자 주소를 클릭 시 `호스팅아이디`, `로그인아이디` 에 찍어주기
         *
         * @작성자: 박난하
         * @작성일: 2006-01-13
         */
        var hosting_id = '';
        var login_id = '';

        if( hosting_id || login_id )
        {
            document.LoginForm.hosting_id.value = hosting_id;
            if( typeof document.LoginForm.login_id != "undefined" ) document.LoginForm.login_id.value = login_id;
            document.LoginForm.passwd.focus();
            return true;
        }
        // end

        if (save_1 == "Y") {
            var save_1_val = IDGetCookie("userId");
            if (save_1_val != null) {
                document.LoginForm.hosting_id.value = save_1_val;
            }
            document.LoginForm.save_hosting_id.click();
        }

        if (typeof document.LoginForm.login_id != "undefined" && save_2 == "Y") {
            var save_2_val = IDGetCookie("myloginid");
            if (save_2_val != null) {
                document.LoginForm.login_id.value = save_2_val;
            }
            document.LoginForm.save_login_id.click();
        }



        document.LoginForm.hosting_id.focus();
    }

    window.onload = IDstart;
    function setPng24(obj) {
      obj.width=obj.height=1;
      obj.className=obj.className.replace(/\bpng24\b/i,'');
      obj.style.filter = "progid:DXImageTransform.Microsoft.AlphaImageLoader(src='"+ obj.src +"',sizingMethod='image');"
      obj.src='';
      return '';
    }
</script>
<style type="text/css">
/* 베이스 css 여기는 base.css를 링크 시켜주시고, 아래 스타일은 알맞은 css 파일에 첨부해주세요.*/
body {
    width:524px;
    height:404px;
    margin:0;
    padding:0;
    font-family:"돋움", Dotum, "굴림",  Gulim;
    font-size:12px;
    line-height:140%;
    color:#515151;

    }

h1, h2, h3, h4, h5, h6, form, input, ul, li, dl, dt, dd {margin:0; padding:0;}
ul, li {list-style:none;}

a {text-decoration:none; color:#515151;}

img {border:none;}
li img {vertical-align:top;}
.frame {position:absolute; left:50%; top:50%;margin-left : -330px; margin-top:-202px}

.MarginNone {margin:0 !important;}

.BackgroundNone {background:none !important;}

.png24 {tmp:expression(setPng24(this));}

/* login 관련 스타일 */

.loginWrap {
    width:660px;
    height:208px;
    color:#6e6d6c;
    background:url(/admin/img/login/login_bg.gif) no-repeat;
    border:4px solid #87bcf2;
    }
    .loginWrap h3 {float:left; margin:131px 85px 0 20px;}

    .loginForm {
        float:left;
        width:396px;
        height:160px;
        margin-top:23px;
        background:url(/admin/img/login/login_content_bg.gif) left bottom no-repeat;
        }
    ul.login_tab {float:left; width:396px; background:url(/admin/img/login/tab_bg.gif) left top repeat-x;}
    ul.login_tab li {float:left;}

    #loginType01 {position:absolute; clear:both; width:100%;}

    #loginType01 dl {
        clear:both;
        float:left;
        width:374px;
        margin:26px 0 0 22px;
        padding-bottom:11px;
        white-space:nowrap;
        background:url(/admin/img/login/line_dot.gif) left bottom no-repeat;
        display:inline;
        }
        .loginForm dt {clear:both; float:left; margin-left:21px; display:inline;}
        .loginForm dd {float:left;}
            .loginInput {width:118px; border:1px solid #cecece;}
            .btn {margin:-4px 0 0 5px;}

        p.find {clear:both; float:left; width:100%; margin-top:10px; text-align:center;}
        p.find a {padding:0 9px 0 7px; display:inline-block;}
            .no_btn {background:none !important;}


    ul.explan {clear:both; width:630px; color:#666; padding:8px;}
    ul.explan li {margin-bottom:3px;}
    ul.explan li a {color:#4189d4;}

</style>
</head>
<body>
<FORM METHOD="post" name='LoginForm' action='/admin/loginProcess.jsp' onSubmit="return login_chkform( this )">
<div class="frame">
<h2><img src="/admin/img/login/title_admin_login.gif" alt="관리자 로그인" /></h2>
<div class="loginWrap">
<h3><img src="/admin/img/login/login_title.png" alt="LOG IN" class="png24" /></h3>
    <div class="loginForm">
        <ul class="login_tab">
            <li><a href="#"><img src="/admin/img/login/tab01_on.gif" alt="대표운영자" id="login_tab01" onclick="chgTab(1)" /></a></li>
        </ul>

        <div style="position:relative; float:left; width:100%;">
        <div id="loginType01">
        <dl>
            <dt><img src="/admin/img/login/text_id.gif" alt="대표아이디" /></dt>
            <dd><input type="text" class="loginInput"  name="userId" tabindex="1" type="text"/> 
            <!-- <input type="checkbox" name="save_hosting_id" tabindex="2" type="checkbox" id="elm_hosting_id"/> <label for="elm_hosting_id">저장</label></dd> -->
            <dt><span id="elm_sub_admin1"></span></dt>
            <dd><span id="elm_sub_admin2"></span><br/></dd>
            <dt><img src="/admin/img/login/text_pw.gif" alt="비밀번호" /></dt>
            <dd><input class="loginInput" name="passwd" tabindex="3" type="password"/> </dd>
            <dd class="btn"><a href="#"><input type="image" tabindex="7" src="/admin/img/login/btn_login.gif" alt="로그인"/></a></dd>
        </dl>
<!--        
        <p class="find"><a href="#" onclick="popup_win('https://urbanslowcity.com/user/idsearch/')">아이디/비밀번호 찾기</a>
         <br><a href="#" onclick="layoutOpen(); return false;"><u><strong>관리자 로그인이 되지 않으세요?</strong></u></a></p>
 -->
        </div>

        </div>

    </div>

</div>
    <ul class="explan">
        <li>* 아이디와 비밀번호를 입력하시면 관리자로 로그인 하실 수 있습니다.</li>
    </ul>
</div>
</form>
</body>

</html>
