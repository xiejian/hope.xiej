/*
var gv_cont={},gv_user={};

function get_userdata(){
    $.getJSON($SCRIPT_ROOT + '/_userdata', {
    }, function(data) {
        gv_user = data;
    });
}
function get_contdata(cid){
    $.getJSON($SCRIPT_ROOT + '/_contdata', {
        c: cid
    }, function(data) {
        gv_cont[cid] = data;
    });
}
function get_contlp(clist){
    $.getJSON($SCRIPT_ROOT + '/_contdata', {
        cl:clist
    }, function (data) {
        $.each(data, function (key, val) {
            $.each(val, function (key2, val2) {
                gv_cont[key][key2] = val2;
            });
        });
    });
}
 */


function activepage(page){
    $('.topnav li').each(function(i,li){
        if(i == page)
            $(li).addClass("active")
        else
            $(li).removeClass("active")
    });
}

function showtab(tab){
    $('div.subm_tab').each(function(i,div){
        if(i == tab)
            $(div).show();
        else
            $(div).hide();
    });
    $('.submenu li').each(function(i,li){
        if(i == tab)
            $(li).addClass("active");
        else
            $(li).removeClass("active");
    });
}
$.ajaxSetup({ cache: false });

$(function () {
    $(".submenu li a").click(function(e){
        e.preventDefault();
        tab = $(this).attr("href");
        showtab(tab);
    });
});

/*for SlickGrid*/
function rendercontName(cellNode, row, dataContext, colDef) {
    var htm = '<a name="'+dataContext['c']+'" href="'+$SCRIPT_ROOT + '/contract?c=' + dataContext['c'] + '" class="modalInputF" rel="#cont_overlay">' + dataContext['n'] + '</a>';
    $(cellNode).html(htm);
    init_modalInputF($(cellNode).find('a.modalInputF'));
}
function updn_formatter(row, cell, value, columnDef, dataContext ) {
    if(value > 0){return '<span class="up">+'+value+'%</span>';}
    if (value < 0){return '<span class="dn"> '+value+'%</span>';}
    else {return ' - ';}
}

function multi_sort(e, args) {
    var cols = args.sortCols;
    this.setData(this.getData().sort(function (dataRow1, dataRow2) {
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
    }));
    this.invalidate();
    this.render();
}
var _dec = {'t':{'O':'Open','C':'Close','B':'Buy','S':'Sell'},
    'st':{'N':'New', 'P':'Open Approved', 'O':'Trading', 'C':'Closed', 'Q':'Settle Approved', 'S':'Settled', 'A':'Achieved', 'R':'Rejected','D':'Deleted'},
    'r':{"W":"World Wide","N":"North America","L":"Latin America / Carib.","O":"Oceania / Australia","M":"Middle East","E":"Europe","A":"Asia","F":"Africa"},
    's': {"C":"Currency","I":"Stock Index","M":"Commodity","S":"Sports","P":"Politic","E":"Entertainment","N":"Natural","O":"Others"}};

/*basefuncion*/
function parseDate(tdate) {
    var system_date = new Date(Date.parse(tdate));
    var user_date = new Date();
    if (K.ie) {
        system_date = Date.parse(tdate.replace(/( \+)/, ' UTC$1'))
    }
    var diff = Math.floor((user_date - system_date) / 1000);
    if (diff <= -2592000) {return "in "+Math.round(-diff / 2592000) + " months";}
    if (diff <= -86400) {return "in "+Math.round(-diff / 86400) + " days";}
    if (diff <= -3600) {return "in "+Math.round(-diff / 3600) + " hours";}
    if (diff <= -60) {return "in "+Math.round(-diff / 60) + " minutes";}
    if (diff < -15) {return "in "- diff + " seconds ago";}
    if (diff < 15) {return "just now";}
    if (diff < 60) {return diff + " seconds ago";}
    if (diff <= 3600) {return Math.round(diff / 60) + " minutes ago";}
    if (diff <= 86400) {return Math.round(diff / 3600) + " hours ago";}
    if (diff < 2592000) {return Math.round(diff / 86400) + " days ago";}
    else {return Math.round(diff / 2592000) + " months ago";}

}

var K = function () {
    var a = navigator.userAgent;
    return {
        ie: a.match(/MSIE\s([^;]*)/)
    }
}();
