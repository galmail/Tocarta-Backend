Ext.ns('Ext.i18n');

/**
 * @class Ext.18n.Bundle
 * @version 0.1-touch
 * 	
 * @author Maximiliano Fierro (elmasse)
 */

Ext.require('Ext.i18n.PropertyReader', function(){
	
	
	Ext.i18n.Bundle = Ext.extend(Ext.data.Store,{ 
	
	model: 'PropertyModel',
	
	/**
	 * @cfg defaultLanguage {String}. 
	 */
	defaultLanguage: 'es-ES',
	/**
	 * @cfg bundle {String} Bundle name. Default to 'myApp'
	 */
	bundle: 'myApp',
	/**
	 * @cfg method {String} The HTTP method used to retrieve the bundle file from server. Default to GET
	 */
	method: 'GET',
	/**
	 * @cfg resourceExt {String} the resource file extension.
	 */
	resourceExt: '.properties',
	/**
	 * @cfg path {String} a path where the bundle files are located. Default to ''.
	 */
	path: '',
	/**
	 * @cfg lang {String} language code in the form xx-YY where:
	 * 		xx: Language code (2 characters lowercase) YY: Country code (2 characters upercase).
	 */
	
	//private
	loadFlag: false,
	
	/**
	 * @constructor
	 */
	constructor: function(config){
		config = config || {};
		Ext.apply(this, config);
		
		this.language = this.formatLanguageCode(this.lang || this.guessLanguage()); 

	    Ext.i18n.Bundle.superclass.constructor.call(this, {
	    	autoLoad: true,
	    	proxy: this.createProxy(this.buildURL(this.language)),
	        reader: new Ext.i18n.PropertyReader()
	    });

		this.proxy.on('exception', this.loadParent, this, {single: true});
	},
	
	/**
	 * @private
	 * @method gessLanguage will try to guess the language based on browser settings. 
	 */
	guessLanguage: function(){
		return (navigator.language || navigator.browserLanguage
				|| navigator.userLanguage || this.defaultLanguage);
	},
	
	/**
	 * @method: getMsg Returns the content associated with the bundle key or {bundle key}.undefined if it is not specified.
	 * @param: key {String} Bundle key.
	 * @return: {String} The bundle key content. 
	 */
	getMsg: function(key){
		return this.getById(key)? Ext.util.Format.htmlDecode(this.getById(key).get('value')) : key + '.undefined';
	},
	
	/**
	 * @method: onReady The fn that will be called when the Bundle file is loaded.
	 * @param: fn {Function}
	 */
	onReady: function(fn){
		this.readyFn = fn;
		this.on('loaded', this.readyFn, this, {single: true});
	},
	
	/**
	 * @override
	 */
	onProxyLoad: function(operation) {
		if(operation.wasSuccessful()){
			Ext.i18n.Bundle.superclass.onProxyLoad.call(this, operation);
			this.fireEvent('loaded');
		}
    },
	
	
	/**
	 * @private
	 */
	buildURL: function(language){
		var url = '';
		if (this.path) url+= this.path + '/';
		url+=this.bundle;
		if (language) url+= '_'+language;
		url+=this.resourceExt;
		return url;
	},
	
	/**
	 * @private
	 */
	loadParent: function(){
		var url = this.buildURL();
		this.proxy = this.createProxy(url);
		this.load();			
	},
	
	/**
	 * @private
	 */
	createProxy: function(url){
		return new Ext.data.AjaxProxy({
    		url: url, 
    		method: this.method,
				reader: new Ext.i18n.PropertyReader(),
				getMethod: function(){
					return this.method;
				}
    	});
	},
	
	/**
	 * @private
	 */
	formatLanguageCode: function(lang){
		var langCodes = lang.split('-');
		langCodes[0] = (langCodes[0]) ? langCodes[0].toLowerCase() : '';
		langCodes[1] = (langCodes[1]) ? langCodes[1].toUpperCase() : '';
		return langCodes.join('-');
	}

});
	
	
	
	
});



