<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<script type="text/javascript">
 if( /iPhone|iPad|iPod|BlackBerry|Android|Windows CE|LG|MOT|SAMSUNG|SonyEricsson|webOS|IEMobile|Opera Mini/i.test(navigator.userAgent) ) {
	 location.href = "/Reservation.do?step=one&agent=mobile";
 }
 else {
	 location.href = "/Reservation.do?step=one&agent=pc";
 }
 </script>