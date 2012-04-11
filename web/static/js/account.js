/**
 * Created by PyCharm.
 * User: xiejian
 * Date: 1/13/12
 * Time: 3:47 PM
 * To change this template use File | Settings | File Templates.
 */

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
    //showtab(0);
    getiploc();

    $(".edit_cont_form input[type='button']").click(function(){
        $(this).parent(".edit_cont_form").attr({action: this.name});
        $(this).parent(".edit_cont_form").submit();
    });


});
