	var target ;
	var spinner;
	var opts;

var popup = {
	/**
	 * Window 팝업을 보여준다.
	 *
	 * @param url URL
	 * @param name 팝업명
	 * @param specObj Spec Object
	 * @return 팝업 객체
	 */
	openWindowPopup : function(url, name, specObj) {
		var defaultSpecsObj = {
			width : '800px',
			height : '600px',
			menubar : 'no',
			status : 'no',
			toolbar : 'no',
			location : 'no',
			titlebar : 'no',
			resizable : 'yes',
			scrollbars: 'no'
		};

		$.extend(true, defaultSpecsObj, specObj);

		defaultSpecsObj.left = (window.screen.width / 2) - (parseInt(defaultSpecsObj.width) / 2);
		defaultSpecsObj.top = (window.screen.height / 2) - (parseInt(defaultSpecsObj.height) / 2);

		var specs = '';
		$.each(defaultSpecsObj, function(property, propertyValue) {
			specs += property + '=' + propertyValue;
			specs += ', ';
		});
		specs = specs.substring(0, specs.lastIndexOf(', '));

		var popupObject = window.open(url, name, specs);
		popupObject.focus();

		return popupObject;
	},

	/**
	 * Modal 팝업을 보여준다.
	 *
	 * @param url URL
	 * @param arguments Object
	 * @param optionObj Options Object
	 * @returns
	 */
	openModalPopup : function(url, arguments, optionsObj) {
		var defaultOptions = {
			center : 'yes',
			dialogWidth : '800px',
			dialogHeight : '600px',
			resizable : 'yes',
			scroll : 'yes'
		};

		$.extend(true, defaultOptions, optionsObj);
		var options = '';
		$.each(defaultOptions, function(property, propertyValue) {
			options += property + ':' + propertyValue;
			options += '; ';
		});
		options = options.substring(0, options.lastIndexOf('; '));

		return window.showModalDialog(url, arguments, options);
	}
};