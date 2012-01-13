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
            $(li).css("background-color","#ABF");
        else
            $(li).css("background-color","");
    });
}

$(function(){
    activepage(3);
    $("#accountmenu li a").click(function(e){
        e.preventDefault();
        tab = $(this).attr("href");
        showtab(tab);
    });
});
