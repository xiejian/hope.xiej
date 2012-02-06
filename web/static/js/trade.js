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
    var settledt = new Date(gv_cont[cid]['settledate']);
    var htm = "<tr><td>Settle Date: "+settledt.getFullYear()+"-"+(settledt.getMonth()+1)+"-"+settledt.getDate() + "</td><td>BTC Multi:" + gv_cont[cid]["btc_multi"]+"</tr>";
    htm += "<tr><td>Leverage: "+gv_cont[cid]['leverage'] + "</td><td>Description:" + gv_cont[cid]["name"]+"</tr>";
    $("#continfo").html(htm);
    var htm = "";
    $.each(gv_cont[cid]["S"], function(index,val) {
        htm = "<tr><td>S"+(index+1)+"</td><td>"+val["point"]+"</td><td>"+val["rm_lots"]+"</td></tr>" + htm;
    });
    htm = htm + '<tr><td colspan="3" ><hr/></td></tr>';
    $.each(gv_cont[cid]["B"], function(index,val) {
        htm = htm + "<tr><td>B"+(index+1)+"</td><td>"+val["point"]+"</td><td>"+val["rm_lots"]+"</td></tr>";
    });
    $("h3.contheader").html("<h3>"+gv_cont[cid]['name'] + " : " + gv_cont[cid]["latestpoint"]+"</h3>");
    $("#oqueue").html(htm);
    var htm = "";
    $.each(gv_cont[cid]["T"], function(index,val) {
        htm += "<tr><td>"+val["time"]+"</td><td>"+val["point"]+"</td><td>"+val["lots"]+"</td><td>"+val["dir"]+"</td></tr>";
    });
    $("#transhis").html(htm);
}

function update_o_c(){
    var contname = $("#contract option:selected").html();
    var b_s = $("input[name=b_s]:checked").val();
    var findstr = ":contains('"+contname+"')";
    if ($("table.tt_pos tr").find(findstr).next().html() == n(b_s)){
        $("label#l_toc").html("CLOSE");
    }
    else{
        $("label#l_toc").html("OPEN");
    }

}

$(function () {
    activepage(1);
    get_contdata($("#contract").val());
    $("#contract").change(function(){
        get_contdata($(this).val());
        update_o_c();
    });
    $("input[name=b_s]").change(function(){
        $("div.trade").removeClass(n($(this).val()));
        $("div.trade").addClass($(this).val());
        update_o_c();
    });
});