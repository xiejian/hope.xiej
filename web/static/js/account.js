/**
 * Created by PyCharm.
 * User: xiejian
 * Date: 1/13/12
 * Time: 3:47 PM
 * To change this template use File | Settings | File Templates.
 */
function showtab(tab){
    $('div.account_tab').each(function(i,div){
        if(i == tab)
            $(div).show();
        else
            $(div).hide();
    });
    $('#accountmenu li').each(function(i,li){
        if(i == tab)
            $(li).addClass("active");
        else
            $(li).removeClass("active");
    });
}

function getiploc(){
    $('.ip').each(function(i,td){
        $.get("http://api.hostip.info/get_html.php?ip="+$(td).html()+"&callback=?",function(data){
                $(td).next().html(data.replace(/^(.*)IP:.*$/m, '$1'));
            });
    });
}

function test(){
    return 'hi'
}

$(function(){
    activepage(2);
    showtab(0);
    getiploc();
    $("#accountmenu li a").click(function(e){
        e.preventDefault();
        tab = $(this).attr("href");
        showtab(tab);
    });

});
