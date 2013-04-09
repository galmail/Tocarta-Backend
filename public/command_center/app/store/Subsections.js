/**
 * Subsections Store
 * 
 */
Ext.define('TC.store.Subsections', {
    extend  : 'Ext.data.Store',
    requires: ['TC.model.Subsection'],
    config: {
    	model: 'TC.model.Subsection'
    }
});
