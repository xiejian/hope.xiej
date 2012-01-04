/**
 * Created by PyCharm.
 * User: xiej
 * Date: 12-1-1
 * Time: 下午1:46
 * To change this template use File | Settings | File Templates.
 */
var gv_cont={};

function get_contdata(cid){
    $.getJSON($SCRIPT_ROOT + '/_contdata', {
        c: cid
    }, function(data) {
        gv_cont[cid] = data;
        updatepage_contdata(cid);
    });
    return false;
}
function updatepage_contdata(cid){
    var htm = gv_cont[cid]['name'] + ":<h3>" + gv_cont[cid]["latestpoint"]+"</h3>";
    htm += "<tr><td>Settle Date: "+gv_cont[cid]['settledate'] + "</td><td>BTC Multi:" + gv_cont[cid]["btc_multi"]+"</tr>";
    htm += "<tr><td>Leverage: "+gv_cont[cid]['leverage'] + "</td><td>Description:" + gv_cont[cid]["description"]+"</tr>";
    $("#continfo").html(htm);
    var htm = "";
    $.each(gv_cont[cid]["S"], function(index,val) {
        htm = "<tr><td>S"+(index+1)+"</td><td>"+val["price"]+"</td><td>"+val["rm_lots"]+"</td></tr>" + htm;
    });
    $.each(gv_cont[cid]["B"], function(index,val) {
        htm = htm + "<tr><td>B"+(index+1)+"</td><td>"+val["price"]+"</td><td>"+val["rm_lots"]+"</td></tr>";
    });
    $("#oqueue").html(htm);
    var htm = "";
    $.each(gv_cont[cid]["T"], function(index,val) {
        htm += "<tr><td>"+val["time"]+"</td><td>"+val["price"]+"</td><td>"+val["lots"]+"</td><td>"+val["dir"]+"</td></tr>";
    });
    $("#transhis").html(htm);
}


$(function () {
    get_contdata($("#contract").val());
    $("#contract").change(function(){
        get_contdata($(this).val());
    });
});