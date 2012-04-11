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

