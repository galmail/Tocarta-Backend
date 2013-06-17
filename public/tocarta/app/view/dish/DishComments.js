/**
 * @class TC.view.dish.DishComments
 * @extends Ext.Panel
 *
 * DishComments Panel
 * @description This panel display the dish comments tab
 **/

Ext.define('TC.view.dish.DishComments', {
	extend: 'Ext.Panel',
	xtype: 'dish-comments-tab',
	config: {
		cls : 'tcDishComments',
		items: [
			{
    		cls: 'tcDishCommentsRating',
    		tpl: [
    			'<h2>'+ $T.dish_evaluation +'</h2>',
					'<ul class="rating ministars">',
          	'<tpl if="rating &gt; 0"><li class="current"></tpl><tpl if="rating &lt; 1"><li class=""></tpl><a href="#"></a></li>',
          	'<tpl if="rating &gt; 1"><li class="current"></tpl><tpl if="rating &lt; 2"><li class=""></tpl><a href="#"></a></li>',
          	'<tpl if="rating &gt; 2"><li class="current"></tpl><tpl if="rating &lt; 3"><li class=""></tpl><a href="#"></a></li>',
          	'<tpl if="rating &gt; 3"><li class="current"></tpl><tpl if="rating &lt; 4"><li class=""></tpl><a href="#"></a></li>',
          	'<tpl if="rating &gt; 4"><li class="current"></tpl><tpl if="rating &lt; 5"><li class=""></tpl><a href="#"></a></li>',
          '</ul>'
    		].join('')
	    },
	    {
	    	html: [
	    		'<div style="overflow:hidden;">',
	    			'<div class="tlt-comment">'+$T.last_comments+'</div>',
	    		'</div>'
	    	].join('')
	    },
	    {
	    	itemId: 'tcDishCommentsDataItemsId',
	    	cls: 'tcDishCommentsDataItems',
    		xtype: 'dataview',
				itemTpl: [
          '<div class="dish_comment">',
          	'<div style="overflow:hidden;">',
              '<ul class="rating ministars">',
              	'<tpl if="rating &gt; 0"><li class="current"></tpl><tpl if="rating &lt; 1"><li class=""></tpl><a href="#"></a></li>',
              	'<tpl if="rating &gt; 1"><li class="current"></tpl><tpl if="rating &lt; 2"><li class=""></tpl><a href="#"></a></li>',
              	'<tpl if="rating &gt; 2"><li class="current"></tpl><tpl if="rating &lt; 3"><li class=""></tpl><a href="#"></a></li>',
              	'<tpl if="rating &gt; 3"><li class="current"></tpl><tpl if="rating &lt; 4"><li class=""></tpl><a href="#"></a></li>',
              	'<tpl if="rating &gt; 4"><li class="current"></tpl><tpl if="rating &lt; 5"><li class=""></tpl><a href="#"></a></li>',
              '</ul>',
              '<span class="dish_comment_author"><tpl if="name.length==0">'+$T.anonymous+'</tpl>{name}</span>',
            '</div>',
            '<div class="dish_comment_text">{description}</div>',
        	'</div>'
				].join('')
	    }
		]
	}
});