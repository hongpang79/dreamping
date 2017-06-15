function Calendar( holidayURL , nameDisp ) {
	var d = new Date() ;

	this.selectYear = d.getFullYear();
	this.selectMonth = ( d.getMonth() +1 );
	this.selectDate = null;

	this.frame = null;
	this.title = null;
	this.titleYear = null;
	this.titleMonth = null;
	this.yearMonthSelect = null;
	this.dateSelect = null;
	this.holidayData = null;
	this.holidayNameDisp = ( nameDisp ?  true : false );

	this.dateCells = new Array;

	this.tmp = null;
	this.target = null;

	if( holidayURL ) {
		try {
			this.request = new XMLHttpRequest();
			if( !this.request ) throw false;
		}
		catch( e ) {
			this.request = new ActiveXObject( 'Msxml2.XMLHTTP' );
			if( !this.request ) this.request = new ActiveXObject( 'Microsoft.XMLHTTP' );
		}
		this.request.onreadystatechange = this.binding( this.setHoliday );
		this.request.open( "GET" , holidayURL , true );
		this.request.setRequestHeader( "Content-Type" , "application/x-www-form-urlencoded" );
		this.request.send();
	}
}

Calendar.prototype.setHoliday = function() {
	if( ( this.request.readyState == 4 ) && ( this.request.status == 200 ) ) {
		var txt = this.request.responseText;
		if( !txt ) return;

		var holidays = txt.split( "\n" );

		this.holidayData = new Object;
		for( var i = 0 , d = null , n = null ; i < holidays.length ; i++ ) {
			d = holidays[ i ].split( ':' )[ 0 ];
			if( !d ) continue;

			n = holidays[ i ].split( ':' )[ 1 ];
			this.holidayData[ d ] = n;
		}
	}
}

Calendar.prototype.binding = function() {
	for(  var i = 0 , args = [] ; i < arguments.length ; i++ ) args.push( arguments[ i ] );

	if( args.length < 1 ) return undefined;

	var func = args.shift();
	var thisObj = this;
	if( typeof( func ) != 'function' ) return undefined;

	return function() {
		return func.apply( thisObj , args );
	};
}

Calendar.prototype.bindEvent = function() {
	for(  var i = 0 , args = [] ; i < arguments.length ; i++ ) args.push( arguments[ i ] );

	if( args.length < 1 ) return undefined;

	var func = args.shift();
	var thisObj = this;
	if( typeof( func ) != 'function' ) return undefined;

	return function() {
		var evt = ( ( arguments.length > 0 ) ? arguments[0] : window.event );
		return func.apply( thisObj , [ evt ].concat( args ) );
	};
}

Calendar.prototype.addEvent = function( src , evtType , func , args ) {
	if( src.attachEvent ) {
		src.attachEvent( 'on' + evtType , this.bindEvent( func , args ) );
	}
	else {
		src.addEventListener( evtType , this.bindEvent( func , args ) , false );
	}
}

Calendar.prototype.removeEvent = function( src , evtType , func , args ) {
	if( src.detachEvent ) {
		src.detachEvent( 'on' + evtType , this.bindEvent( func , args ) );
	}
	else {
		src.removeEventListener( evtType , this.bindEvent( func , args ) , false );
	}
}

Calendar.prototype.call = function() {
	var todayDay = this.getDay( this.selectYear , this.selectMonth , 1 );
	var dates = this.getMonthDays( this.selectYear , this.selectMonth );
	var dObj = new Date;

	this.titleYear.firstChild.nodeValue = this.selectYear;
	this.titleMonth.firstChild.nodeValue = this.selectMonth;

	for( var i = 0 , dateCnt = 1 ; i < this.dateCells.length ; i++ ) {
		for( var j = 0 , y = null , m = null , d = null ; j < this.dateCells[ i ].length ; j++ ) {
			this.dateCells[ i ][ j ].childNodes[0].nodeValue = '';
			this.dateCells[ i ][ j ].style.cursor = '';
			this.dateCells[ i ][ j ].className = '';
			var cn = null;
			if( ( cn = this.dateCells[ i ][ j ].getElementsByTagName( 'div' ) ).length > 0 ) {
				if( cn[ 0 ].className == 'holiday_text' ) this.dateCells[ i ][ j ].removeChild( cn[ 0 ] );
			}

			if( !( ( i == 0 ) && ( todayDay > j ) ) && ( dates >= dateCnt ) )	{
				this.dateCells[ i ][ j ].childNodes[0].nodeValue = dateCnt++;
				this.dateCells[ i ][ j ].style.cursor = 'pointer';
				if( j == ( this.dateCells[ i ].length -2 ) ) this.dateCells[ i ][ j ].className = 'saturday';
				if( j == ( this.dateCells[ i ].length -1 ) ) this.dateCells[ i ][ j ].className = 'sunday';

				if( this.holidayData ) {
					y = this.selectYear.toString();
					m = ( ( m = this.selectMonth.toString() ).length < 2 ? '0' + m : m );
					d = ( ( d = ( dateCnt -1 ).toString() ).length < 2 ? '0' + d : d );

					if( this.holidayData[ ( y + '-' + m + '-' + d ) ] ) {
						this.dateCells[ i ][ j ].className = 'holiday';
						if( !this.holidayNameDisp ) continue;

						var t = document.createElement( 'div' );
						t.className = 'holiday_text';
						t.appendChild( document.createTextNode( this.holidayData[ ( y + '-' + m + '-' + d ) ] ) );
						this.dateCells[ i ][ j ].appendChild( t );
					}
				}

				if( this.selectYear != dObj.getFullYear() ) continue;
				if( this.selectMonth != ( dObj.getMonth() +1 ) ) continue;
				if( ( dateCnt -1 ) != dObj.getDate() ) continue;
				this.dateCells[ i ][ j ].className = 'today';
			}
			else {
				this.dateCells[ i ][ j ].className = 'empty';
			}
		}
	}
}

Calendar.prototype.decreaseAlpha = function( obj , to , func ) {
	if( to <= 0 ) {
		obj.style.display = 'none';
		if( func ) window.setTimeout( func , 20 );
		return;
	}
	obj.style.filter = 'alpha( opacity=' + to + ' );';
	obj.style.opacity = ( to /100 );
	to -= 8;
	if( to < 0 ) {
		to = 0;
		obj.style.display = 'none';
	}
	window.setTimeout( this.binding( this.decreaseAlpha , obj , to , func ) , 20 );
}

Calendar.prototype.increaseAlpha = function( obj , to , func ) {
	if( to >= 100 ) {
		if( func ) window.setTimeout( func , 20 );
		return;
	}
	obj.style.display = '';
	obj.style.filter = 'alpha( opacity=' + to + ' );';
	obj.style.opacity = ( to /100 );
	to += 8;
	if( to > 100 ) to = 100;
	window.setTimeout( this.binding( this.increaseAlpha , obj , to , func ) , 20 );
}

Calendar.prototype.toggle = function( event , targetID ) {
	if( !this.frame ) this.createFrame();
	if( this.frame.style.display == 'none' ) this.open( event ,targetID );
	else this.close();
}

Calendar.prototype.open = function( event , targetID ) {
	if( !event ) return;
	var srcE = ( event.target ? event.target : event.srcElement );
	if( !srcE ) return;

	if( !this.frame ) this.createFrame();
	this.increaseAlpha( this.frame , 0 );

	this.frame.style.left = document.body.scrollLeft + event.clientX  - 92 + 'px';
	this.frame.style.top = document.body.scrollTop + event.clientY + 10 + 'px';

	if( targetID )
	{
		if( typeof( targetID ) == 'object' ) this.target = targetID;
		else this.target = document.getElementById( targetID );

		this.getTargetValue();
	}

	this.call();
}

Calendar.prototype.close = function() {
	this.decreaseAlpha( this.frame , 100 );
}

Calendar.prototype.mover = function( event ) {
	var srcE = ( event.target ? event.target : event.srcElement );
	if( !srcE.firstChild.nodeValue ) return;

	srcE.setAttribute( 'tmpClass' , srcE.className );
	srcE.className = 'mover';
}

Calendar.prototype.mout = function( event ) {
	var srcE = ( event.target ? event.target : event.srcElement );
	if( !srcE.firstChild.nodeValue ) return;

	srcE.className = srcE.getAttribute( 'tmpClass' );
}

Calendar.prototype.showDateSelect = function() {
	this.decreaseAlpha( this.yearMonthSelect , 100 , this.binding( this.increaseAlpha , this.dateSelect , 0 ) );
}

Calendar.prototype.showYearMonthSelect = function() {
	this.decreaseAlpha( this.dateSelect , 100 , this.binding( this.increaseAlpha , this.yearMonthSelect , 0 ) );
}

Calendar.prototype.goPrevMonth = function() {
	if( this.selectMonth < 2 ) {
		this.selectYear -= 1;
		this.selectMonth = 12;
	}
	else {
		this.selectMonth -= 1;
	}
	this.call();
}

Calendar.prototype.goNextMonth = function() {
	if( this.selectMonth > 11 ) {
		this.selectYear += 1;
		this.selectMonth = 1;
	}
	else {
		this.selectMonth += 1;
	}
	this.call();
}

Calendar.prototype.toggleYearMonthSelect = function() {
	if( this.yearMonthSelect.style.display == 'none' ) {
		var ipts = this.yearMonthSelect.getElementsByTagName( 'input' );
		if( !this.selectYear) return;
		if( !this.selectMonth ) return;

		var y = this.selectYear.toString();
		var m = this.selectMonth.toString();

		for( var i = 0 , c = null , cnt = 0 ; i < ipts.length ; i++ ) {
			if( !ipts[ i ].type ) continue;
			if( ipts[ i ].type != 'text' ) continue;
			if( ( c = y.charAt( cnt++ ) ) ) ipts[ i ].value = c;
			else ipts[ i ].value = m;
		}

		this.showYearMonthSelect();
	}
	else {
		this.changeYearMonth();
	}
}

Calendar.prototype.createFrame = function() {
	var days = [ '월' , '화' , '수' , '목' , '금' , '토' , '일' ];

	this.frame = document.createElement( 'div' );
	this.frame.setAttribute( 'id' , 'calendar_container' );
	this.frame.style.display = 'none';
	this.frame.style.position = 'absolute';
	this.frame.style.float = 'left';
	this.frame.style.zIndex = 1000;
	this.title = document.createElement( 'div' );
	this.title.setAttribute( 'id' , 'calendar_title' );

	this.prevMonth = document.createElement( 'input' );
	this.prevMonth.type = 'button';
	this.prevMonth.value = '◀';
	this.prevMonth.style.cursor = 'pointer';
	this.prevMonth.style.border = '0px solid white';
	this.prevMonth.style.backgroundColor = 'transparent';
	this.addEvent( this.prevMonth , 'click' , this.goPrevMonth );
	this.title.appendChild( this.prevMonth );
	this.title.appendChild( document.createTextNode( ' ' ) );

	this.titleYear = document.createElement( 'span' );
	this.titleYear.appendChild( document.createTextNode( this.selectYear ) );
	this.title.appendChild( this.titleYear );
	this.title.appendChild( document.createTextNode( '년 ' ) );

	this.addEvent( this.titleYear , 'click' , this.toggleYearMonthSelect );
	this.titleYear.style.cursor = 'pointer';

	this.titleMonth = document.createElement( 'span' );
	this.titleMonth.appendChild( document.createTextNode( this.selectMonth ) );
	this.title.appendChild( this.titleMonth );
	this.title.appendChild( document.createTextNode( '월 ' ) );

	this.addEvent( this.titleMonth , 'click' , this.toggleYearMonthSelect );
	this.titleMonth.style.cursor = 'pointer';

	this.nextMonth = document.createElement( 'input' );
	this.nextMonth.type = 'button';
	this.nextMonth.value = '▶';
	this.nextMonth.style.cursor = 'pointer';
	this.nextMonth.style.border = '0px solid white';
	this.nextMonth.style.backgroundColor = 'transparent';
	this.addEvent( this.nextMonth , 'click' , this.goNextMonth );
	this.title.appendChild( this.nextMonth );

	this.dateSelect = document.createElement( 'table' );
	this.dateSelect.setAttribute( 'id' , 'calendar_date_select' );

	var thead = document.createElement( 'thead' );
	var theadRow = document.createElement( 'tr' );
	thead.appendChild( theadRow );

	var tbodyDate = document.createElement( 'tbody' );

	for( var i = 0 , cell = null , col = null ; i < days.length ; i++ ) {
		cell = document.createElement( 'th' );

		cell.appendChild( document.createTextNode( days[ i ] ) );

		if( days[ i ] == '토' ) cell.className = 'saturday';
		if( days[ i ] == '일' ) cell.className = 'sunday';

		theadRow.appendChild( cell );
	}

	for( var i = 0 , row = null ; i < 6 ; i++ ) {
		row = document.createElement( 'tr' );
		tbodyDate.appendChild( row );
		this.dateCells[ i ] = new Array;
		for( var j = 0 , cell = null ; j < days.length ; j++ ) {
			cell = document.createElement( 'td' );
			row.appendChild( cell );
			this.dateCells[ i ][ j ] = cell;
			this.dateCells[ i ][ j ].appendChild( document.createTextNode( '' ) );

			this.addEvent( this.dateCells[ i ][ j ] , 'click' , this.select );
			this.addEvent( this.dateCells[ i ][ j ] , 'mouseover' , this.mover );
			this.addEvent( this.dateCells[ i ][ j ] , 'mouseout' , this.mout );
		}
	}

	this.yearMonthSelect = document.createElement( 'table' );
	this.yearMonthSelect.setAttribute( 'align' , 'center' );
	this.yearMonthSelect.setAttribute( 'id' , 'calendar_yearmonth_select' );
	this.yearMonthSelect.style.width = '80%';
	this.yearMonthSelect.style.height = '80%';
	this.yearMonthSelect.style.display = 'none';

	var row = this.yearMonthSelect.insertRow(0);
	row.setAttribute( 'valign' , 'middle' );
	row.insertCell( 0 ).appendChild( document.createTextNode( '\u00a0' ) );

	for( var i = 1 , ipt = null ; i < 9 ; i++ ) {
		if( ( i == 5 ) || ( i == 7 ) ) {
			row.insertCell( i ).appendChild( document.createTextNode ( ( ( i == 5 ) ? '년' : '월' ) ) );
			continue;
		}

		if( i == 8 ) {
			ipt = document.createElement( 'input' );
			ipt.type = 'button';
			ipt.value = '변경';
			ipt.style.border = '0px solid white';
			ipt.style.cursor = 'pointer';
			ipt.style.backgroundColor = 'transparent';
			this.addEvent( ipt , 'click' , this.changeYearMonth );

			row.insertCell( i ).appendChild( ipt );
			continue;
		}

		row.insertCell( i );
		row.cells[ i ].setAttribute( 'align' , 'center' );
		row.cells[ i ].setAttribute( 'valign' , 'middle' );

		ipt = document.createElement( 'input' );
		ipt.type = 'button';
		ipt.value = '▲';
		ipt.style.cursor = 'pointer';
		ipt.style.border = '0px solid white';
		ipt.style.backgroundColor = 'transparent';
		this.addEvent( ipt , 'click' , this.plus );
		this.yearMonthSelect.appendChild( ipt );
		row.cells[ i ].appendChild( ipt );
		row.cells[ i ].appendChild( document.createElement( 'br' ) );

		ipt = document.createElement( 'input' );
		ipt.type = 'text';
		ipt.size = ipt.maxLength = ( ( i == 6 ) ? 2 : 1 );
		ipt.style.border = '0px solid white';
		ipt.style.textAlign = 'center';
		ipt.readOnly = true;
		ipt.value = ( ( i == 6 ) ? this.selectMonth.toString() : this.selectYear.toString().charAt( i -1 ) );
		this.yearMonthSelect.appendChild( ipt );
		row.cells[ i ].appendChild( ipt );
		row.cells[ i ].appendChild( document.createElement( 'br' ) );

		ipt = document.createElement( 'input' );
		ipt.type = 'button';
		ipt.value = '▼';
		ipt.style.cursor = 'pointer';
		ipt.style.border = '0px solid white';
		ipt.style.backgroundColor = 'transparent';
		this.addEvent( ipt , 'click' , this.minus );
		row.cells[ i ].appendChild( ipt );
	}
	row.insertCell( 9 ).appendChild( document.createTextNode( '\u00a0' ) );

	this.dateSelect.appendChild( thead );
	this.dateSelect.appendChild( tbodyDate );
	this.frame.appendChild( this.title );
	this.frame.appendChild( this.dateSelect );
	this.frame.appendChild( this.yearMonthSelect );

	var dbody = document.getElementsByTagName( 'body' );
	if( !dbody ) return;
	else dbody = dbody[0];

	dbody.appendChild( this.frame );
}

Calendar.prototype.plus = function( event ) {
	var srcE = ( event.target ? event.target : event.srcElement );

	var cI = srcE.parentNode.cellIndex;
	if( ( cI === null ) || ( cI === undefined ) ) return;

	var target = srcE.nextSibling.nextSibling;

	switch( cI ) {
		case 1:
			target.value = 2;
			target.parentNode.nextSibling.getElementsByTagName( 'input' )[1].value = 0;
			return;
			break;
		case 2:
			if( srcE.parentNode.previousSibling.getElementsByTagName( 'input' )[1].value == 1 ) target.value = 9;
			else if( srcE.parentNode.previousSibling.getElementsByTagName( 'input' )[1].value == 2 ) target.value = 1;
			else return;
			break;
		case 3: 
		case 4:
			if( ( this.getIntval( target.value ) +1 ) > 9 ) return;
			target.value = this.getIntval( target.value ) +1;
			break;
		case 6:
			if( ( this.getIntval( target.value ) +1 ) > 12 ) return;
			target.value = this.getIntval( target.value ) +1;
			break;
		default: return;
	}
}

Calendar.prototype.minus = function( event ) {
	var srcE = ( event.target ? event.target : event.srcElement );

	var cI = srcE.parentNode.cellIndex;
	if( ( cI === null ) || ( cI === undefined ) ) return;

	var target = srcE.previousSibling.previousSibling;

	switch( cI ) {
		case 1:
			target.value = 1;
			target.parentNode.nextSibling.getElementsByTagName( 'input' )[1].value = 9;
			return;
			break;
		case 2:
			if( srcE.parentNode.previousSibling.getElementsByTagName( 'input' )[1].value == 1 ) target.value = 9;
			else if( srcE.parentNode.previousSibling.getElementsByTagName( 'input' )[1].value == 2 ) target.value = 1;
			else return;
			break;
		case 3: 
		case 4:
			if( ( this.getIntval( target.value ) -1 ) < 0 ) return;
			target.value = this.getIntval( target.value ) -1;
			break;
		case 6:
			if( ( this.getIntval( target.value ) -1 ) < 1 ) return;
			target.value = this.getIntval( target.value ) -1;
			break;
		default: return;
	}
}

Calendar.prototype.select = function( event ) {
	var srcE = ( event.target ? event.target : event.srcElement );

	if( !srcE ) return;

	if( srcE.nodeName.toLowerCase() != 'td' ) srcE = srcE.parentNode;
	if( srcE.nodeName.toLowerCase() != 'td' ) return;
	this.selectDate = srcE.firstChild.nodeValue;

	if( !this.selectDate ) return;

	if( this.target ) {
		var tnname = this.target.nodeName;
		if( tnname ) tnname = tnname.toLowerCase();
		switch( tnname ) {
			case 'input' : this.target.value = this.getString(); break;
			case 'div' :
			case 'span' :
				if( this.target.childNodes ) {
					for( var i = 0 ; i < this.target.childNodes.length ; i++ ) this.target.removeChild( this.target.childNodes[ i ] );
				}
			case 'textarea' :
				this.target.appendChild( document.createTextNode( this.getString() ) );
				break;
		}
		this.close();
	}
	else this.close();
}

Calendar.prototype.getTargetValue = function() {
	if( !this.target ) return;
	var tnname = this.target.nodeName;
	if( tnname ) tnname = tnname.toLowerCase();
	var value = null;
	switch( tnname ) {
		case 'input' : value = this.target.value; break;
		case 'div' :
		case 'span' : value = this.target.innerHTML; break;
	}
	if( value ) value = value.split( '-' );
	else
	{
		var dObj = new Date;
		this.selectYear = dObj.getFullYear();
		this.selectMonth = dObj.getMonth() +1;
		return;
	}

	if( ( typeof( value ) == 'object' ) && ( value.length < 3 ) ) return;

	this.selectYear = this.getIntval( value[ 0 ] );
	this.selectMonth = this.getIntval( value[ 1 ] );
	this.selectDate = this.getIntval( value[ 2 ] );
}

Calendar.prototype.changeYearMonth = function() {
	var ipts = this.yearMonthSelect.getElementsByTagName( 'input' );
	for( var i = 0 , cnt = 0 , values = [] ; i < ipts.length ; i++ ) {
		if( ipts[ i ].type != 'text' ) continue;

		values.push( ipts[ i ].value );
	}

	this.selectMonth = this.getIntval( values.pop() );
	this.selectYear = this.getIntval( values.join( '' ) );

	this.titleYear.firstChild.nodeValue = this.selectYear;
	this.titleMonth.firstChild.nodeValue = this.selectMonth;

	this.call();
	this.showDateSelect();
	return;
}

Calendar.prototype.getMonthDays = function( y , m ) {
	m = this.getIntval( m );
	y = this.getIntval( y );

	switch( m ) {
		case 1 : case 3 : case 5 : case 7 : case 8 : case 10 : case 12 : return 31; break;
		case 4 : case 6 : case 9 : case 11 : return 30; break;
		case 2 :
			if( ( y % 4 ) == 0 ) {
				if( ( y % 100 ) == 0 ) {
					if( ( y % 400 ) == 0 ) return 29;
					else return 28;
				}
				else return 29;
			}
			else return 28;
			break;
	}
}

Calendar.prototype.getDay = function( y , m , d ) {
	var cntY = ( ( y -1 ) * 365 ) + Math.floor( ( y -1 ) / 4 ) - Math.floor( ( y -1 ) / 100 ) + Math.floor( ( y -1 ) / 400 );

	for( var i = 1 , cntM = 0 ; i < m ; i++ )  cntM += this.getMonthDays( y , i );

	var cntD = d;

	var day = ( cntY + cntM + cntD ) % 7;

	switch( day ) {
		case 0 : return 6;
		default : return ( day -1 );
	}
}

Calendar.prototype.get = function( withDay ) {
	if( !this.selectYear ) return [];
	if( !this.selectMonth ) return [];
	if( !this.selectDate ) return [];

	withDay = ( typeof( widthDay ) == 'boolean' ? withDay : false );

	var returnValue = [ this.selectYear , this.selectMonth , this.selectDate ];
	if( withDay ) returnValue.push( this.getDay() );

	return returnValue;
}

Calendar.prototype.getString = function( withDay ) {
	var d = this.get();

	withDay = ( typeof( widthDay ) == 'boolean' ? withDay : false );

	if( d[1] < 10 ) d[1] = '0' + d[1];
	if( d[2] < 10 ) d[2] = '0' + d[2];

	var returnValue = d.join( '-' );
	return returnValue + ( withDay ? ( ' ' + this.getDayString() ) : '' );
}

Calendar.prototype.getIntval = function( strVal ) {
	if( strVal === '' ) return 0;
	if( strVal === undefined ) return 0;
	if( strVal === NaN ) return 0;

	if( strVal.toString ) {
		var val = strVal.toString();
	}
	else {
		return parseInt( strVal );
	}

	var val2 = '';
	for( var i = 0 ; i < val.length ; i++ ) {
		if( ( i == 0 ) && ( val.length > 1 ) ) if( val.charAt( i ) == '0' ) continue;
		val2 += val.charAt( i );
	}

	return parseInt( val2 );
}
