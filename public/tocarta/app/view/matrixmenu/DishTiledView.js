/**
 * @class TC.view.matrixmenu.DishTiledView
 * @extends Ext.Container
 *
 * Tiled View
 * @description This container displays products in a tiled structure
 **/

Ext.define('TC.view.matrixmenu.DishTiledView', {
    extend: 'Ext.DataView',
    xtype: 'matrixmenu-dishtiledview',

    config: {
        layout: 'vbox',
        baseCls: 'tcMatrixMenuDishTiledView',

        items: null

    },

});
