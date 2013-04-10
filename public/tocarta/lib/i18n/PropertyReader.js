Ext.ns('Ext.i18n');

Ext.define("PropertyModel", {
	extend: "Ext.data.Model",
	idProperty: 'key',
	config: {
		fields: ['key', 'value']
	}
});

/**
 * 
 * @class Ext.i18n.PropertyReader
 * PropertyReader is used to read data from a .properties files
 * The .properties file might be in the traditional format which means that comments are accepted.
 * key and value must be separated by the specified propertySeparator. By default a space is used.
 * NOTE: value must be in between " and not '
 * 
 * @author Maximiliano Fierro (elmasse)
 */
Ext.i18n.PropertyReader = Ext.extend( Ext.data.Reader,{
	/**
	 * @cfg propertySeparator: {String}. Default: " ". Optional
	 */
	propertySeparator: " ",		

	/**
	 * @constructor
	 */
	constructor: function(config){
		config = config || {};
	    
		Ext.applyIf(config, {
	        idProperty: 'id',
	        successProperty: 'success',
	        totalProperty: 'total',
			model: Ext.ModelMgr.types['PropertyModel']
	    });
		
		//call super
		Ext.i18n.PropertyReader.superclass.constructor.call(this, config); 
		
	},
	

	/**
	 * @override
	 */
	read: function(response){
		var propertyFile = response.responseText;
		if(!propertyFile)
			throw {message: "PropertyReader.read: File not found"};
						
		return this.readRecords(propertyFile);
	},

	/**
	 * @override
	 */
	readRecords: function(propertyFile){
		var totalRecords = 0, success = true;
		var Record = this.recordType;
		var records = [];
		
		var f = this.readLines(propertyFile);
		
		for(var i = 0; i < f.length; i++){
			var key, value, kLim;
			kLim = f[i].indexOf(this.propertySeparator);
			key = String(f[i].substring(0, kLim));
			value = f[i].substring(kLim+1).trim().replace(/\"/g, '');
			
			var record = Ext.ModelMgr.create({
			    value : value,
			    key  : key
			}, 'PropertyModel');
			//bad Model implementation
			record.id = key;	
			records[i] = record;
		}
		
		return new Ext.data.ResultSet({
            total  : records.length,
            count  : records.length,
            records: records,
            success: success
        });
	
	},
	
	createAccessor: Ext.emptyFn,
	
	//private
	readLines: function(file){
		var aux = String(file).split('\n');
		var lines = new Array();
		
		for(var i = 0; i < aux.length; i++){
			if(aux[i].indexOf("#") < 0 || (aux[i].indexOf("#") > aux[i].indexOf("\""))){
				var line = aux[i];//Ext.util.Format.trim(aux[i]);
				if(line)
					lines.push(line);
			}	
		}
		return lines;
	}

});

//Ext.data.ReaderMgr.registerType('property', Ext.i18n.PropertyReader);