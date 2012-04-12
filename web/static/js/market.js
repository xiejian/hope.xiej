/**
 * Created by PyCharm.
 * User: xiejian
 * Date: 1/13/12
 * Time: 5:24 PM
 * To change this template use File | Settings | File Templates.


function parseTwitterDate(tdate) {
    var system_date = new Date(Date.parse(tdate));
    var user_date = new Date();
    if (K.ie) {
        system_date = Date.parse(tdate.replace(/( \+)/, ' UTC$1'))
    }
    var diff = Math.floor((user_date - system_date) / 1000);
    if (diff <= 1) {return "just now";}
    if (diff < 20) {return diff + " seconds ago";}
    if (diff < 40) {return "half a minute ago";}
    if (diff < 60) {return "less than a minute ago";}
    if (diff <= 90) {return "one minute ago";}
    if (diff <= 3540) {return Math.round(diff / 60) + " minutes ago";}
    if (diff <= 5400) {return "1 hour ago";}
    if (diff <= 86400) {return Math.round(diff / 3600) + " hours ago";}
    if (diff <= 129600) {return "1 day ago";}
    if (diff < 604800) {return Math.round(diff / 86400) + " days ago";}
    if (diff <= 777600) {return "1 week ago";}
    return "on " + system_date;
}

// from http://widgets.twimg.com/j/1/widget.js
var K = function () {
    var a = navigator.userAgent;
    return {
        ie: a.match(/MSIE\s([^;]*)/)
    }
}(); */
var v_contlist;
function get_contlist(){
    $.getJSON($SCRIPT_ROOT + '/market', {
        d: 1
    }, function(data) {
        v_contlist = data;
        update_conttop();
        update_contlist();
    });
    return false;
}

function update_conttop(){
    var tcolumns = [
        {id: "name", name: "Name", field: "n",width:65, asyncPostRender: rendercontName},
        {id: "latestpt", name: "Latest PT", field: "lp",width:55},
        {id: "change", name: "Change", field: "ch",width:50, formatter: updn_formatter}
    ];
    var toptions = {
        enableCellNavigation: true,
        enableColumnReorder: false,
        enableAsyncPostRender: true
    };
    //var data = [];
    v_contv = v_contlist['O'].sort(function(x,y){return y['vl']-x['vl'];});
    var vgrid = new Slick.Grid("#top_v_grid", v_contv, tcolumns, toptions);

    v_contd = v_contlist['O'].sort(function(x,y){return y['ch']-x['ch'];});
    var dgrid = new Slick.Grid("#top_d_grid", v_contd, tcolumns, toptions);
    v_contu = v_contlist['O'].sort(function(x,y){return y['ch']-x['ch'];});
    var ugrid = new Slick.Grid("#top_u_grid", v_contu, tcolumns, toptions);
    $(".scrollable[title=top]").scrollable({circular: true}).navigator({navi: '.scrollnavi', naviItem: 'a'}).autoscroll({ autoplay: true });
}

function update_contlist(){

    var ocolumns = [
        {id: "name", name: "Name", field: "n", sortable:true,asyncPostRender: rendercontName},
        {id: "fullname", name: "Fullname", field: "fn", sortable:true},
        {id: "settledt", name: "Settle DT", field: "sd", width:120,sortable:true},
        {id: "region", name: "Region", field: "r", sortable:true},
        {id: "sector", name: "Sector", field: "s", sortable:true},
        {id: "latestpt", name: "Latest PT", field: "lp", sortable:true},
        {id: "change", name: "Change", field: "ch", sortable:true,formatter: updn_formatter},
        {id: "volume", name: "Volume", field: "vl", sortable:true},
        {id: "trade", name: "", field: "c",formatter: function ( row, cell, value, columnDef, dataContext ) {
            return '<a href="'+$SCRIPT_ROOT + '/trade?c=' + dataContext['c'] + '"> TRADE </a>';}
        }
    ];
    var ncolumns = [
        {id: "status", name: "Status", field: "st", sortable:true},
        {id: "name", name: "Name", field: "n", sortable:true,asyncPostRender: rendercontName},
        {id: "fullname", name: "Fullname", field: "fn", sortable:true},
        {id: "opendt", name: "Open DT", field: "od", width:120, sortable:true},
        {id: "settledt", name: "Settle DT", field: "sd", width:120, sortable:true},
        {id: "region", name: "Region", field: "r", sortable:true},
        {id: "sector", name: "Sector", field: "s", sortable:true},
        {id: "owner", name: "Author", field: "o", width:120, sortable:true}
    ];
    var ccolumns = [
        {id: "status", name: "Status", field: "st", sortable:true},
        {id: "name", name: "Name", field: "n", sortable:true,asyncPostRender: rendercontName},
        {id: "fullname", name: "Fullname", field: "fn", sortable:true},
        {id: "settledt", name: "Settle DT", field: "sd", width:120, sortable:true},
        {id: "region", name: "Region", field: "r", sortable:true},
        {id: "sector", name: "Sector", field: "s", sortable:true},
        {id: "settlept", name: "Settle PT", field: "sp", sortable:true},
        {id: "owner", name: "Author", field: "o", width:120, sortable:true}
    ];
    var options = {
        enableCellNavigation: true,
        enableColumnReorder: false,
        multiColumnSort: true,
        enableAsyncPostRender: true
    };
    //var data = [];
    var ogrid = new Slick.Grid("#o_cont_grid", v_contlist['O'], ocolumns, options);
    var ngrid = new Slick.Grid("#n_cont_grid", v_contlist['N'], ncolumns, options);
    var cgrid = new Slick.Grid("#c_cont_grid", v_contlist['C'], ccolumns, options);

    ngrid.onSort.subscribe(function (e, args) {
        var cols = args.sortCols;

        v_contlist['N'].sort(function (dataRow1, dataRow2) {
            for (var i = 0, l = cols.length; i < l; i++) {
                var field = cols[i].sortCol.field;
                var sign = cols[i].sortAsc ? 1 : -1;
                var value1 = dataRow1[field], value2 = dataRow2[field];
                var result = (value1 == value2 ? 0 : (value1 > value2 ? 1 : -1)) * sign;
                if (result != 0) {
                    return result;
                }
            }
            return 0;
        });
        ngrid.invalidate();
        ngrid.render();
    });
}

$(function () {
    activepage(0);
    showtab(0);
    get_contlist();
});

