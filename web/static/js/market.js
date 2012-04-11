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
    v_contv = v_contlist['O'].sort(function(x,y){return x['vl']-y['vl'];});
    v_contu = v_contlist['O'].sort(function(x,y){return x['ch']-y['ch'];});
    v_contd = v_contlist['O'].sort(function(x,y){return y['ch']-x['ch'];});
    var htm ='';
    for(i = 0 ; i < v_contv.length && i < 5 ; i++){
        htm += '<tr><td>'+v_contv[i]["n"]+'</td><td>'+v_contv[i]["lp"]+'</td><td>'+v_contv[i]["ch"]+'</td></tr>'
    }
    $("table#top_v").html(htm);
    htm ='';
    for(i = 0 ; i < v_contu.length && i < 5 ; i++){
        htm += '<tr><td>'+v_contv[i]["n"]+'</td><td>'+v_contv[i]["lp"]+'</td><td>'+v_contv[i]["ch"]+'</td></tr>'
    }
    $("table#top_u").html(htm);
    htm ='';
    for(i = 0 ; i < v_contd.length && i < 5 ; i++){
        htm += '<tr><td>'+v_contv[i]["n"]+'</td><td>'+v_contv[i]["lp"]+'</td><td>'+v_contv[i]["ch"]+'</td></tr>'
    }
    $("table#top_d").html(htm);
}


function update_contlist(){
    var ocolumns = [
        {id: "name", name: "Name", field: "n", sortable:true,formatter: function ( row, cell, value, columnDef, dataContext ) {
                return '<a name="'+dataContext['c']+'" href="'+$SCRIPT_ROOT + '/contract?c=' + dataContext['c'] + '" class="modalInputF" rel="#cont_overlay">' + value + '</a>';}
        },
        {id: "fullname", name: "Fullname", field: "fn", sortable:true},
        {id: "settledt", name: "Settle DT", field: "sd", width:120,sortable:true},
        {id: "region", name: "Region", field: "r", sortable:true},
        {id: "sector", name: "Sector", field: "s", sortable:true},
        {id: "latestpt", name: "Latest PT", field: "lp", sortable:true},
        {id: "change", name: "Change", field: "ch", sortable:true,formatter: function ( row, cell, value, columnDef, dataContext ) {
            if(value > 0){return '<span class="up">+'+value+'%</span>';}
            if (value < 0){return '<span class="dn">- '+value+'%</span>';}
            else {return ' - ';}}
        },
        {id: "volume", name: "Volume", field: "vl", sortable:true},
        {id: "trade", name: "", field: "c",formatter: function ( row, cell, value, columnDef, dataContext ) {
            return '<a href="'+$SCRIPT_ROOT + '/trade?c=' + dataContext['c'] + '"> TRADE </a>';}
        }
    ];
    var ncolumns = [
        {id: "status", name: "Status", field: "st", sortable:true},
        {id: "name", name: "Name", field: "n", sortable:true,formatter: function ( row, cell, value, columnDef, dataContext ) {
            return '<a name="'+dataContext['c']+'" href="'+$SCRIPT_ROOT + '/contract?c=' + dataContext['c'] + '" class="modalInputF" rel="#cont_overlay">' + value + '</a>';}
        },
        {id: "fullname", name: "Fullname", field: "fn", sortable:true},
        {id: "opendt", name: "Open DT", field: "od", width:120, sortable:true},
        {id: "settledt", name: "Settle DT", field: "sd", width:120, sortable:true},
        {id: "region", name: "Region", field: "r", sortable:true},
        {id: "sector", name: "Sector", field: "s", sortable:true},
        {id: "owner", name: "Author", field: "o", sortable:true}
    ];
    var ccolumns = [
        {id: "status", name: "Status", field: "st", sortable:true},
        {id: "name", name: "Name", field: "n", sortable:true,formatter: function ( row, cell, value, columnDef, dataContext ) {
            return '<a name="'+dataContext['c']+'" href="'+$SCRIPT_ROOT + '/contract?c=' + dataContext['c'] + '" class="modalInputF" rel="#cont_overlay">' + value + '</a>';}
        },
        {id: "fullname", name: "Fullname", field: "fn", sortable:true},
        {id: "opendt", name: "Open DT", field: "od", width:120, sortable:true},
        {id: "settledt", name: "Settle DT", field: "sd", width:120, sortable:true},
        {id: "region", name: "Region", field: "r", sortable:true},
        {id: "sector", name: "Sector", field: "s", sortable:true},
        {id: "settlept", name: "Settle PT", field: "sp", sortable:true},
        {id: "owner", name: "Author", field: "o", sortable:true}
    ];

    var options = {
        enableCellNavigation: true,
        enableColumnReorder: false
    };
    //var data = [];

    var ogrid = new Slick.Grid("#o_cont_grid", v_contlist['O'], ocolumns, options);
    var ngrid = new Slick.Grid("#n_cont_grid", v_contlist['N'], ncolumns, options);
    var cgrid = new Slick.Grid("#c_cont_grid", v_contlist['C'], ccolumns, options);

    init_modalInputF();
}

$(function () {
    activepage(0);
    showtab(0);
    get_contlist();
});

