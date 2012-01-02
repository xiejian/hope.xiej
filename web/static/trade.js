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
    var htm = "";
    $.each(gv_cont[cid]["q"]["S"], function(index,val) {
        htm += "<tr><td>S"+index+"</td><td>"+val["price"]+"</td><td>"+val["rm_lots"]+"</td></tr>";
    });
    $.each(gv_cont[cid]["q"]["B"], function(index,val) {
        htm += "<tr><td>B"+index+"</td><td>"+val["price"]+"</td><td>"+val["rm_lots"]+"</td></tr>";
    });
    $("#oqueue").html(htm);
    var htm = "";
    $.each(gv_cont[cid]["t"], function(index,val) {
        htm += "<tr><td>"+val["time"]+"</td><td>"+val["price"]+"</td><td>"+val["lots"]+"</td><td>"+val["dir"]+"</td></tr>";
    });
    $("#transhis").html(htm);
}


$(function () {
    $("#contract").change(function(){
        get_contdata($(this).val());
    });
});