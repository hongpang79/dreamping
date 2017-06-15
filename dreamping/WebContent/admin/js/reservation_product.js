function hideSeasonRows( e )
{
	var srcE = e.target ? e.target : e.srcElement;
	var tb = srcE.offsetParent.offsetParent;

	for( var i = 0 , rName = '' ; i < tb.rows.length ; i++ )
	{
		rName = tb.rows[ i ].getAttribute( 'name' );
		if( !rName ) continue;
		if( rName != 'seasonFrom' ) continue;
		for( var j = 0 ; j < tb.rows[ i ].childNodes.length ; j++ )
		{
			tb.rows[ i ].childNodes.item( j ).style.display = 'none';
		}
		tb.rows[ i ].style.display = 'none';
	}
}

function showSeasonRows( e )
{
	var srcE = e.target ? e.target : e.srcElement;
	var tb = srcE.offsetParent.offsetParent;

	for( var i = 0 , rName = '' ; i < tb.rows.length ; i++ )
	{
		rName = tb.rows[ i ].getAttribute( 'name' );
		if( !rName ) continue;
		if( rName != 'seasonFrom' ) continue;
		for( var j = 0 ; j < tb.rows[ i ].childNodes.length ; j++ )
		{
			tb.rows[ i ].childNodes.item( j ).style.display = '';
		}
		tb.rows[ i ].style.display = '';
	}
}

function hideBusyRows( e )
{
	var srcE = e.target ? e.target : e.srcElement;
	var tb = srcE.offsetParent.offsetParent;

	for( var i = 0 , rName = '' ; i < tb.rows.length ; i++ )
	{
		rName = tb.rows[ i ].getAttribute( 'name' );
		if( !rName ) continue;
		if( rName != 'busyFrom' ) continue;
		for( var j = 0 ; j < tb.rows[ i ].childNodes.length ; j++ )
		{
			tb.rows[ i ].childNodes.item( j ).style.display = 'none';
		}
		tb.rows[ i ].style.display = 'none';
	}
}

function showBusyRows( e )
{
	var srcE = e.target ? e.target : e.srcElement;
	var tb = srcE.offsetParent.offsetParent;

	for( var i = 0 , rName = '' ; i < tb.rows.length ; i++ )
	{
		rName = tb.rows[ i ].getAttribute( 'name' );
		if( !rName ) continue;
		if( rName != 'busyFrom' ) continue;
		for( var j = 0 ; j < tb.rows[ i ].childNodes.length ; j++ )
		{
			tb.rows[ i ].childNodes.item( j ).style.display = '';
		}
		tb.rows[ i ].style.display = '';
	}
}

function toggleDetail( obj )
{
	if( !obj ) return;

	var tbody = obj.offsetParent.offsetParent.getElementsByTagName( 'tbody' )[0];
	var disp = ( obj.getAttribute( 'value' ) == 'T' ? '' : 'none' );
	tbody.style.display = disp;
}

function addRow( e )
{
	var srcE = e;
	var tr = srcE.parentNode.parentNode;
	var tb = tr.parentNode;
	var n = tr.cloneNode( true );
	var ipts = n.getElementsByTagName( 'input' );

	for( var i = 0 ; i < ipts.length ; i++ )
	{
			var name = ipts[ i ].getAttribute( 'name' );
			if( !name ) continue;

			ipts[ i ].setAttribute( 'name' , name.replace( /\[\d+\]/ , '_add[]' ) );
			ipts[ i ].setAttribute( 'value' , '' );
	}

	tb.insertBefore( n , tr.nextSibling );
}

function deleteRow( e )
{
	var srcE = e;
	var tr = srcE.parentNode.parentNode;
	var tb = tr.offsetParent;
	var ipt = srcE.parentNode.parentNode.getElementsByTagName( 'input' )[0];

	var name = null;
	var idName = null;
	var idx = null;
	var match = null;

	name = ipt.getAttribute( 'name' );
	if( name ) match = name.match( /^([\w]+)\[/ );
	if( match ) idName = ( match[1] ? match[1].replace( '_add' , '' ) : null );
	if( name ) match = name.match( /\[(\d+)\]$/ );
	if( match ) idx = ( match[1] ? match[1] : null );

	if( idName && idx )
	{
		try{
			ipt = document.createElement( "<input type='hidden' name='deleted_rows[]' value='" + idx + "'>" );
			ipt = tb.rows[0].cells[0].appendChild( ipt );
		} catch( e ){
			ipt = tb.rows[0].cells[0].appendChild( document.createElement( 'input' ) );
			ipt.setAttribute( 'type' , 'hidden' );
			ipt.setAttribute( 'name' , 'deleted_rows[]' );
			ipt.setAttribute( 'value' , idx );
		}
	}

	for( var i = 0 , chk = 0 ; i < tb.rows.length ; i++ ) if( tb.rows[ i ].getAttribute( 'name' ) == idName ) chk += 1;

	if( chk > 1 ) tb.deleteRow( tr.rowIndex );
	else cleanRow( tr );
}

function cleanRow( tr )
{
	var ipts = tr.getElementsByTagName( 'input' );
	var sels = tr.getElementsByTagName( 'select' );
	for( var i = 0 ; i < ipts.length ; i++ )
	{
			var name = ipts[ i ].getAttribute( 'name' );
			ipts[ i ].setAttribute( 'name' , name.replace( /\[\d+\]/ , '_add[]' ) );
			ipts[ i ].setAttribute( 'value' , '' );
	}
	for( var i = 0 ; i < sels.length ; i++ ) sels[ i ].value = sels[ i ].options[0].getAttribute( 'value' );
}

function productModifyInit()
{
	var spans = document.getElementsByTagName( 'span' );
	for( var i = 0 , name = '' ; i < spans.length ; i++ )
	{
		name = spans[ i ].getAttribute( 'name' );
		if( !name ) continue;
		if( name == 'dateSet' ) setDateSet( spans[ i ] , spans[ i ].getAttribute( 'set' ) );
		if( name == 'timeSet' ) setTimeSet( spans[ i ] , spans[ i ].getAttribute( 'set' ) );
		if( name == 'daysSet' ) setDaysSet( spans[ i ] , spans[ i ].getAttribute( 'set' ) );

		for( var j = 0 , sels = spans[ i ].getElementsByTagName( 'select' ) ; j < sels.length ; j++ )
		{
			if( sels[ j ].attachEvent ) sels[ j ].attachEvent( 'onchange' , changeSetValue );
			else sels[ j ].addEventListener( 'change' , changeSetValue , false );
		}
	}

	var labels = document.getElementsByTagName( 'label' );
	for( var i = 0 , ipts = null ; i < labels.length ; i++ )
	{
		ipts = labels[ i ].getElementsByTagName( 'input' );
		if( ipts.length > 0 )
		{
			if( ipts[ 0 ].attachEvent ) ipts[ 0 ].attachEvent( 'onchange' , inputChange );
			else ipts[ 0 ].addEventListener( 'change' , inputChange , false );
		}
	}

	var useTime = document.getElementsByName( 'useTime' );
	if( useTime.length > 0 )
	{
		if( document.getElementById( 'limitSelect' ).options.length < 1 )
		{
			if( useTime[0].checked ) setLimit( useTime[0] );
			else if( useTime[1].checked ) setLimit( useTime[1] );
			else setLimit( useTime[1] );
		}
	}
}

function inputChange( e )
{
	if( !e ) return;
	if( e.srcElement ) srcE = e.srcElement;
	else srcE = e.target;

	var radio = srcE.offsetParent.getElementsByTagName( 'input' );
	if( radio[ 0 ] ) if( radio[ 0 ].getAttribute( 'type' ) == 'radio' ) radio[ 0 ].checked =  true;
}

function changeSetValue( e )
{
	if( !e ) return;
	if( e.srcElement ) srcE = e.srcElement;
	else srcE = e.target;

	var idName = null , typeFlag = null , ipt = null , iptValue = null , srcValue = null;

	idName = srcE.getAttribute( 'id' );
	changeTypeName = srcE.parentNode.getAttribute( 'id' ).split( '_' )[0];
	if( !idName ) return;

	typeFlag = idName.charAt( idName.length -1 );
	idName = idName.substring( 0 , idName.length -2 );

	ipt = srcE.parentNode.getElementsByTagName( 'input' )[0];
	if( ipt.length < 1 ) return;

	iptValue = ipt.getAttribute( 'value' );
	switch( changeTypeName )
	{
		case 'dateSet' :
			if( ( iptValue == '' ) || ( iptValue == null ) ) iptValue = '0000-00-00';
			iptValue = iptValue.split( '-' );
			break;
		case 'timeSet' :
			if( ( iptValue == '' ) || ( iptValue == null ) ) iptValue = '00:00:00';
			iptValue = iptValue.split( ':' );
			break;
		case 'daysSet' :
			if( ( iptValue == '' ) || ( iptValue == null ) ) iptValue = '0~0';
			iptValue = iptValue.split( '~' );
			break;
	}


	srcValue = srcE.value.toString();

	if( srcValue === '' )
	{
		ipt.setAttribute( 'value' , '' );
		return;
	}

	switch( changeTypeName )
	{
		case 'dateSet' :
			switch( typeFlag )
			{
				case 'y' : iptValue[0] = srcValue; break;
				case 'm' : iptValue[1] = ( srcValue.length < 2 ? '0' + srcValue : srcValue ); break;
				case 'd' : iptValue[2] = ( srcValue.length < 2 ? '0' + srcValue : srcValue ); break;
			}
			ipt.setAttribute( 'value' , iptValue.join( '-' ) );
			break;
		case 'timeSet' :
			switch( typeFlag )
			{
				case 'h' : iptValue[0] = ( srcValue.length < 2 ? '0' + srcValue : srcValue ); break;
				case 'm' : iptValue[1] = ( srcValue.length < 2 ? '0' + srcValue : srcValue ); break;
			}
			ipt.setAttribute( 'value' , iptValue.join( ':' ) );
			break;
		case 'daysSet' :
			switch( typeFlag )
			{
				case 'f' : iptValue[0] = srcValue; break;
				case 't' : iptValue[1] = srcValue; break;
			}
			ipt.setAttribute( 'value' , iptValue.join( '~' ) );
			break;
	}

	var radio = srcE.offsetParent.getElementsByTagName( 'input' );
	if( radio[ 0 ] ) if( radio[ 0 ].getAttribute( 'type' ) == 'radio' ) radio[ 0 ].checked =  true;
}

function setDateSet( obj , data )
{
	var idName = obj.getAttribute( 'id' );
	var sel = null , initOpt = null ,start = 0 , end = 0;
	var unit = { '_y' : '년' , '_m' : '월' , '_d' : '일' };
	var ipt = null;

	if( data )
	{
		data = data.split( '-' );
		dataCnt = 0;
	}

	if( idName )
	{
		idName = idName.split( '_' );
		idName.shift();
		idName = idName.join( '_' );
	}
	if( !idName ) return;

	for( var flag in unit )
	{
		sel = obj.appendChild( document.createElement( 'select' ) );
		sel.setAttribute( 'id' , ( idName + flag ) );
		sel.setAttribute( 'className' , 'input' );

		initOpt = document.createElement( 'option' );
		sel.options.add( initOpt );
		initOpt.setAttribute( 'value' , '' );
		initOpt.appendChild( document.createTextNode( '선택' ) );

		switch( flag )
		{
			case '_y' : start = 2008; end = new Date().getFullYear(); break;
			case '_m' : start = 1; end = 12; break;
			case '_d' : start = 1; end = 31; break;
		}

		for( var i = start , opt = null ; i <= end ; i++ )
		{
			opt = document.createElement( 'option' );
			sel.options.add( opt );
			opt.setAttribute( 'value' , i.toString() );
			opt.appendChild( document.createTextNode( i.toString() ) );
			if( data && data[ dataCnt ] )
			{
				var selected = data[ dataCnt ].toString();
				if( selected.charAt( 0 ) == '0' ) selected = selected.slice( 1 );
				if( i != parseInt( selected ) ) continue;

				opt.selected = true;
			}
		}

		obj.appendChild( document.createTextNode( unit[ flag ] + '\u00a0\u00a0' ) );

		if( data ) dataCnt += 1;
	}
	ipt = document.createElement( 'input' );
	ipt.setAttribute( 'type' , 'hidden' );
	ipt.setAttribute( 'name' , idName );
	obj.appendChild( ipt );
	if( data ) ipt.setAttribute( 'value' , data.join( '-' ) );
}

function setTimeSet( obj , data )
{
	var idName = obj.getAttribute( 'id' );
	var sel = null , initOpt = null ,start = 0 , end = 0;
	var unit = { '_h' : '' , '_m' : '' };
	var ipt = null;

	if( data )
	{
		data = data.split( ':' );
		dataCnt = 0;
	}

	if( idName )
	{
		idName = idName.split( '_' );
		idName.shift();
		idName = idName.join( '_' );
	}
	if( !idName ) return;

	for( var flag in unit )
	{
		sel = obj.appendChild( document.createElement( 'select' ) );
		sel.setAttribute( 'id' , ( idName + flag ) );
		sel.setAttribute( 'className' , 'input' );

		switch( flag )
		{
			case '_h' : start = 0; end = 23; break;
			case '_m' : start = 0; end = 59; break;
		}

		for( var i = start , opt = null ; i <= end ; i++ )
		{
			opt = document.createElement( 'option' );
			sel.options.add( opt );
			opt.setAttribute( 'value' , i );
			opt.appendChild( document.createTextNode( ( i.toString().length < 2 ? '0' + i.toString() : i.toString() ) ) );
			if( data && data[ dataCnt ] )
			{
				var selected = data[ dataCnt ].toString();
				if( selected.charAt( 0 ) == '0' ) selected = selected.slice( 1 );
				if( i != parseInt( selected ) ) continue;

				opt.selected = true;
			}
		}
		obj.appendChild( document.createTextNode( unit[ flag ] + '\u00a0\u00a0' ) );

		if( data ) dataCnt += 1;
	}
	ipt = document.createElement( 'input' );
	ipt.setAttribute( 'type' , 'hidden' );
	ipt.setAttribute( 'name' , idName );
	obj.appendChild( ipt );
	if( data ) ipt.setAttribute( 'value' , data.join( ':' ) );
}

function setDaysSet( obj , data )
{
	var idName = obj.getAttribute( 'id' );
	var sel = null , initOpt = null ,start = 0 , end = 0;
	var days = [ '월요일' , '화요일' , '수요일' , '목요일' , '금요일' , '토요일' , '일요일' ];
	var unit = { '_f' : '부터' , '_t' : '까지' };
	var ipt = null;

	if( data )
	{
		data = data.split( '~' );
		dataCnt = 0;
	}

	if( idName )
	{
		idName = idName.split( '_' );
		idName.shift();
		idName = idName.join( '_' );
	}
	if( !idName ) return;

	for( var flag in unit )
	{
		sel = obj.appendChild( document.createElement( 'select' ) );
		sel.setAttribute( 'id' , ( idName + flag ) );
		sel.setAttribute( 'className' , 'input' );

		initOpt = document.createElement( 'option' );
		sel.options.add( initOpt );
		initOpt.setAttribute( 'value' , '' );
		initOpt.appendChild( document.createTextNode( '선택' ) );

		switch( flag )
		{
			case '_f' : start = 0; end = 6; break;
			case '_t' : start = 0; end = 6; break;
		}

		for( var i = start , opt = null ; i <= end ; i++ )
		{
			opt = document.createElement( 'option' );
			sel.options.add( opt );
			opt.setAttribute( 'value' , i );
			opt.appendChild( document.createTextNode( days[ i ] ) );
			if( data && data[ dataCnt ] )
			{
				var selected = data[ dataCnt ].toString();
				//if( selected.charAt( 0 ) == '0' ) selected = selected.slice( 1 );
				if( i != parseInt( selected ) ) continue;

				opt.selected = true;
			}
		}
		obj.appendChild( document.createTextNode( unit[ flag ] + '\u00a0\u00a0' ) );

		if( data ) dataCnt += 1;
	}
	ipt = document.createElement( 'input' );
	ipt.setAttribute( 'type' , 'hidden' );
	ipt.setAttribute( 'name' , idName );
	obj.appendChild( ipt );
	if( data ) ipt.setAttribute( 'value' , data.join( '~' ) );
}

function setLimit( obj , selNum )
{
	if( !obj ) return;

	var sel = document.getElementById( 'limitSelect' );
	if( !sel ) return;

	var limitType = document.getElementById( 'limitType' );

	var opt = null;
	while( sel.options.length )
	{
		opt = sel.options[ sel.options.length -1 ];
		sel.removeChild( opt );
	}

	if( obj.value == 'T' )
	{
		limitType.firstChild.replaceData( 0 , 2 , '시간' );
		for( var i = 1 ; i <= 24 ; i++ )
		{
			opt = document.createElement( 'option' );
			sel.options.add( opt );
			opt.setAttribute( 'value' , i );
			if( i == selNum ) opt.selected = true;
			opt.appendChild( document.createTextNode( i.toString() ) );
		}
	}
	else
	{
		limitType.firstChild.replaceData( 0 , 2 , '일' );
		for( var i = 1 ; i < 8 ; i++ )
		{
			opt = document.createElement( 'option' );
			sel.options.add( opt );
			opt.setAttribute( 'value' , i );
			if( i == selNum ) opt.selected = true;
			opt.appendChild( document.createTextNode( i.toString() ) );
		}
	}
}

if( document.body.attachEvent )
{
	window.attachEvent( 'onload' , productModifyInit );
}
else
{
	window.addEventListener( 'load' , productModifyInit , false );
}
