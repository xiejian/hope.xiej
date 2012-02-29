/**
 * Created by PyCharm.
 * User: xiejian
 * Date: 1/13/12
 * Time: 3:47 PM
 * To change this template use File | Settings | File Templates.
 */
function showtab(tab){
    $('div.bitcoin_tab').each(function(i,div){
        if(i == tab)
            $(div).show();
        else
            $(div).hide();
    });
    $('#bitcoinmenu li').each(function(i,li){
        if(i == tab)
            $(li).addClass("active");
        else
            $(li).removeClass("active");
    });
}

$(function(){
    activepage(3);
    showtab(0);
    $("#bitcoinmenu li a").click(function(e){
        e.preventDefault();
        tab = $(this).attr("href");
        showtab(tab);
    });
});
