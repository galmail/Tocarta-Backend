/**
 * Config.js
 * All configuration and variables used in the app
 */

var CURRENT_ENV = "prod"; // options: mock, dev, staging, open, prod
// var CURRENT_DEVICE = "ios"; // options: android, ios

/*** development (mocked services) ***/
if(CURRENT_ENV == "mock"){
	$tc = {
		server: 'http://localhost:3000',
		nodeserver: 'http://analytics.tocarta.es',
		// online: true, // when online, images should be fetched from a remote server, otherwise from filesystem
		testing: true, // when testing, images should be fetched from server, otherwise from Amazon
		s3_path: "http://s3.amazonaws.com/tocarta-test",
		images_path: '/www/resources/img/',
		pusherKey: 'c9c649f5255c17685066',
		timeout: 5000,
  		fullPath: null,
  		relPath: '/www/services/',
  		currentTable: 1,
  		defaultLanguage: 'es',
		time_to_display_msg: 5000,
		click: 'click' // click event instead of tap
	};
}
/*** development (in browser) ***/
else if(CURRENT_ENV == "dev"){
	$tc = {
		server: 'http://localhost:3000',
		nodeserver: 'http://localhost:5000',
		// online: true, // when online, images should be fetched from a remote server, otherwise from filesystem
		testing: false, // when testing, images should be fetched from server, otherwise from Amazon
		s3_path: "http://s3.amazonaws.com/tocarta-prod",
		images_path: '/www/resources/img/',
		pusherKey: 'c9c649f5255c17685066',
		protocol: 'ajax', // Options: jsonp, ajax
		timeout: 8000,
  		fullPath: null,
  		relPath: '/cli/c/',
		currentTable: 1,
  		defaultLanguage: 'es',
		time_to_display_msg: 5000,
		click: 'click' // click event instead of tap
	};
}
/*** staging (in iPad) ***/
else if(CURRENT_ENV == "staging"){
	$tc = {
		server: 'http://tocarta-admin-staging.herokuapp.com',
		nodeserver: 'http://analytics.tocarta.es',
		// online: false, // when online, images should be fetched from a remote server, otherwise from filesystem
		testing: false, // when testing, images should be fetched from server, otherwise from Amazon
		s3_path: "http://s3.amazonaws.com/tocarta-test",
		protocol: 'ajax', // Options: jsonp, ajax
		timeout: 8000,
		pusherKey: 'c9c649f5255c17685066',
  		fullPath: null,
  		relPath: '/cli/c/',
		currentTable: 1,
  		defaultLanguage: 'es',
		time_to_display_msg: 5000,
		click: 'tap' // click event instead of tap
	};
}
/*** open (iPad for open app) ***/
else if(CURRENT_ENV == "open"){
	$tc = {
		server: 'http://demo.tocarta.es',
		nodeserver: 'http://analytics.tocarta.es',
		// online: false, // when online, images should be fetched from a remote server, otherwise from filesystem
		testing: false, // when testing, images should be fetched from server, otherwise from Amazon
		s3_path: "http://s3.amazonaws.com/tocarta-demo",
		protocol: 'ajax', // Options: jsonp, ajax
		timeout: 8000,
		pusherKey: 'ee7fdd527dabde0bd6b6',
  		fullPath: null,
  		relPath: '/cli/c/',
		currentTable: 1,
  		defaultLanguage: 'es',
		time_to_display_msg: 5000,
		click: 'tap' // click event instead of tap
	};
}
/*** production (iPad ready app) ***/
else if(CURRENT_ENV == "prod"){
	$tc = {
		server: 'http://admin.tocarta.es',
		nodeserver: 'http://analytics.tocarta.es',
		// online: false, // when online, images should be fetched from a remote server, otherwise from filesystem
		testing: false, // when testing, images should be fetched from server, otherwise from Amazon
		s3_path: "http://s3.amazonaws.com/tocarta-prod",
		protocol: 'ajax', // Options: jsonp, ajax
		timeout: 8000,
		pusherKey: 'd20cf40b86a0639e33cc',
	  	fullPath: null,
	  	relPath: '/cli/c/',
		currentTable: 1,
  		defaultLanguage: 'es',
		time_to_display_msg: 5000,
		click: 'tap' // click event instead of tap
	};
	// overwrite console.log
	// console.log = function(){};
	// log errors to proxy server
	window.onerror = $tc.logError;
}
else {
	alert('bad environment!');
}

///// Common methods for all environments /////

$j.extend($tc,{
	validate_license_key: "validate_license_key",
	get_restaurant: "get_restaurant_info",
	supported_langs: "get_supported_langs",
	get_images_to_download: "get_images_to_download",
	confirm_downloaded_images: "confirm_downloaded_images",
	send_order_url: "make_order",
	call_waiter: "call_waiter",
	checkin_table: "checkin_table",
	checkout_table: "checkout_table",
	get_sent_order_items: "get_sent_order_items",
	request_bill: "request_bill",
	submit_survey: "submit_survey",
	reset_license: "reset_license",
	im_alive: "im_alive"
});

///// Common functions for all environments /////

$tc.url = function(method_name){
	return this.server + this.relPath + this[method_name] + '.json';
};

$tc.logme = function(info){
	setTimeout(function(){
		Ext.create('TC.model.Logger',{
			action: info.action,
			data: info.data,
			timestamp: Date.now(),
			device_id: TC.Setting.get('key')
		}).log();
	},200);
};

$tc.logError = function(msg,url,line){
	try {
		Ext.Ajax.request({
			url: $tc.nodeserver+"/proxy",
			method: 'GET',
			params: {
				error: true,
				tablet_key: TC.Setting.get('key'),
				channel: TC.socket_channel,
				action: {
					msg: encodeURIComponent(msg),
					url: encodeURIComponent(url),
					line: line
				}
			}
		});
	  return true;
	}
	catch(ex){
		return false;
	}
};

$tc.getUri = function(){
	var me = $tc;
	if(Ext.os.is.Desktop || (Ext.browser.is.Safari && !Ext.os.is.Android)){
		if(me.testing){
			return me.server + me.images_path;
		}
		else {
			return me.s3_path;
		}
	}
	else {
		var filepath;
		if(Ext.os.is.Android){
			filepath = "cdvfile://localhost/persistent";
		}
		else {
			if(Ext.os.is.iOS){
				filepath = "file://localhost";
			}
			if(Ext.os.is.iOS7){
				filepath = "cdvfile://localhost/persistent";
			}
		}
		if($tc.fullPath!=null)
			return filepath + $tc.fullPath;
		else {
			return filepath;
		}
	}
};

$tc.formatNumber = function(num){
	var f = parseFloat(num).toFixed(2);
	return f.replace(".",",");
};

$tc.confirmMsg = function(msg,callback){
	Ext.Msg.confirm('',msg,callback);
};

$tc.checkImgUrl = function(relPath){
	if(relPath)
		return $tc.getUri() + relPath;
	else
		return "//:0";
};

$tc.translateSTButtons = function(){
	Ext.MessageBox.YESNO[0].text = $T.no_button;
	Ext.MessageBox.YESNO[1].text = $T.yes_button;
	// fix animations in messages
	Ext.Msg.setShowAnimation(null);
};

$tc.alertMsg = function(msg,callback,cls){
	Ext.Msg.alert('',msg,callback);
	if(cls){
		Ext.Msg.setCls(cls);
	}
	else {
		Ext.Msg.setCls('');
	}
};

$tc.loadScript = function(filename){
	var fileref = document.createElement('script');
  	fileref.setAttribute("type","text/javascript");
  	fileref.setAttribute("src", filename);
	document.getElementsByTagName("head")[0].appendChild(fileref);
};

$tc.loadStylesheet = function(filename){
	if(filename.indexOf("cdvfile")>=0){
		$j.get(filename,function(cssData){
			$tc.loadStylesheetScript(cssData);
		});
		return;
	}
	var fileref = document.createElement('link');
  	fileref.setAttribute("rel","stylesheet");
  	fileref.setAttribute("type","text/css");
  	fileref.setAttribute("href", filename);
	document.getElementsByTagName("head")[0].appendChild(fileref);
};

$tc.loadStylesheetScript = function(thecss){
	var styleElement = document.createElement('style');
  	styleElement.setAttribute("type","text/css");
	styleElement.appendChild(document.createTextNode(thecss));
	document.getElementsByTagName("head")[0].appendChild(styleElement);
};

$tc.getParameterByName = function(name){
  name = name.replace(/[\[]/, "\\\[").replace(/[\]]/, "\\\]");
  var regexS = "[\\?&]" + name + "=([^&#]*)";
  var regex = new RegExp(regexS);
  var results = regex.exec(window.location.search);
  if(results == null)
    return "";
  else
    return decodeURIComponent(results[1].replace(/\+/g, " "));
};

$tc.checkConnection = function(showMsg){
	if(navigator && navigator.connection && navigator.connection.type){
		var conType=navigator.connection.type;
		if(conType==Connection.NONE || conType==Connection.UNKNOWN){
			if(showMsg){
				$tc.alertMsg("Connection is not available.",function(){
					Ext.Viewport.unmask();
					return false;
				});
			}
			return false;
		}
	}
	return true;
};

$j(document).ready(function(){
	if(CURRENT_ENV != 'prod' && CURRENT_ENV != 'open'){
		$j('#tcEnvironmentId').html(CURRENT_ENV + ' <span style="font-size: 10px;">(<a href="#matrixmenu">MatrixMenu</a> | <a href="#slidersurvey">SliderSurvey</a>)');
	}
});
