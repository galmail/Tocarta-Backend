/**
 * Config.js
 * All configuration and variables used in the app
 */

var CURRENT_ENV = "dev"; // options: mock, dev, staging, prod

/*** development (mocked services) ***/
if(CURRENT_ENV == "mock"){
	
}
/*** development (in browser) ***/
else if(CURRENT_ENV == "dev"){
	$tc = {
		server: 'http://localhost:3000',
		nodeserver: 'http://localhost:5000',
		s3_path: "http://s3.amazonaws.com/tocarta-test",
		images_path: '/www/resources/img/',
		pusherKey: 'c9c649f5255c17685066',
		
		online: true, // when online, images should be fetched from a remote server, otherwise from filesystem
		testing: false, // when testing, images should be fetched from server, otherwise from Amazon
		protocol: 'ajax', // Options: jsonp, ajax
  	fullPath: null,
  	relPath: '/cli/r/',
		currentTable: 0,
  	currentLanguage: 'es',
		time_to_display_msg: 5000,
		click: 'click' // click event instead of tap
	}
}
/*** staging (in iPad) ***/
else if(CURRENT_ENV == "staging"){
	$tc = {
		server: 'http://tocarta-admin-staging.herokuapp.com',
		nodeserver: 'http://tocarta-node-staging.herokuapp.com',
		s3_path: "http://s3.amazonaws.com/tocarta-test",
		images_path: '/www/resources/img/',
		pusherKey: 'c9c649f5255c17685066',
		
		online: false, // when online, images should be fetched from a remote server, otherwise from filesystem
		testing: false, // when testing, images should be fetched from server, otherwise from Amazon
		protocol: 'ajax', // Options: jsonp, ajax
  	fullPath: null,
  	relPath: '/cli/r/',
		currentTable: 0,
  	currentLanguage: 'es',
		time_to_display_msg: 5000,
		click: 'tap' // click event instead of tap
	}
}
/*** production (iPad ready app) ***/
else if(CURRENT_ENV == "prod"){
	$tc = {
		server: 'http://admin.tocarta.es',
		nodeserver: 'http://tocarta-node.herokuapp.com',
		s3_path: "http://s3.amazonaws.com/tocarta-prod",
		images_path: '/www/resources/img/',
		pusherKey: '7eb8d4a46b4a183f76e7',
		
		online: false, // when online, images should be fetched from a remote server, otherwise from filesystem
		testing: false, // when testing, images should be fetched from server, otherwise from Amazon
		protocol: 'ajax', // Options: jsonp, ajax
  	fullPath: null,
  	relPath: '/cli/r/',
		currentTable: 0,
  	currentLanguage: 'es',
		time_to_display_msg: 5000,
		click: 'tap' // click event instead of tap
	}
}
else {
	alert('bad environment!');
}


///// Common methods for all environments /////

$j.extend($tc,{
	validate_license_key: "validate_license_key",
	get_restaurant: "get_restaurant_situation",
	ack_activity: "ack_activity",
	update_all_menus: "update_tablets"
});


///// Common functions for all environments /////

$tc.url = function(method_name){
	return this.server + this.relPath + this[method_name] + '.json';
}

$tc.getUri = function(){
	var me = $tc;
	if(me.online){
		if(me.testing){
			return me.server + me.images_path;
		}
		else {
			return me.s3_path;
		}
	}
	else {
		return "file://localhost" + $tc.fullPath;
	}
}

$tc.formatNumber = function(num){
	var f = parseFloat(num).toFixed(2);
	return f.replace(".",",");
}

$tc.confirmMsg = function(msg,callback){
	Ext.Msg.confirm('',msg,callback);
	// fix yes button
	$j('.x-msgbox-buttons .x-button-action .x-button-label').text($TO.yes_button);
}

$tc.alertMsg = function(msg,callback){
	Ext.Msg.alert('',msg,callback);
}

Ext.require([
	'Ext.util.Inflector'
], function(){
	// lets add some pluralizations
	Ext.util.Inflector.plural(/(orderitem)/i, "order_items");
});

$j(document).ready(function(){
	$j('#tcEnvironmentId').text(CURRENT_ENV);
	if(CURRENT_ENV=='prod'){
		$j('#tcEnvironmentId').hide();
	}
});