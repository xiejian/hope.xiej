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
        $("span.s_toc").addClass("C");
        $("span.s_toc").removeClass("O");
    }
    else{
        $("span.s_toc").addClass("O");
        $("span.s_toc").removeClass("C");
    }
}

var v_userd;
function get_userd(){
    $.getJSON($SCRIPT_ROOT + '/data', {t: 'u'}, function(data) {
        v_userd = data;
        update_userop();
    });
    return false;
}

function update_userop(){
    var cl = {
        cn:{id: "name", name: "Name", field: "n", sortable:true,asyncPostRender: rendercontName},
        mg:{id: "margin", name: "Margin", field: "mg",width:90, sortable:true},
        ot:{id: "orderdt", name: "Order Time", field: "ot", sortable:true,formatter:function(row, cell, value){return parseDate(value);}},
        bs:{id: "bs", name: "B/S", field: "bs", width:50,sortable:true, formatter:function(row, cell, value){return _dec['t'][value];}},
        ct:{id: "ct", name: "Cost", field: "ct", sortable:true},
        pt:{id: "pt", name: "Point", field: "pt", sortable:true},
        pl:{id: "pl", name: "P/L", field: "", width:50,sortable:true,formatter: function ( row, cell, value, columnDef, dataContext ) {
            var pl = dataContext['mv'] - dataContext['ct'];
            if(pl > 0){return '<span class="up">+'+pl+'</span>'; }
            if(pl < 0){return '<span class="dn">'+pl+'</span>'; }
            else    {return pl;}}
        },
        mv:{id: "mv", name: "Market Value", field: "mv", sortable:true},
        lt:{id: "lt", name: "Lots", field: "lt", width:50,sortable:true},
        a:{id: "trade", name: "", field: "c",formatter: function ( row, cell, value, columnDef, dataContext ) {
            return '<a href="'+$SCRIPT_ROOT + '/trade?c=' + dataContext['c'] + '"> TRADE </a>';}
        }
    };
    var pcolumns = [cl.cn,cl.bs,cl.pt,cl.lt,cl.ct,cl.mv,cl.mg,cl.pl];
    var toptions = {
        enableCellNavigation: true,
        enableColumnReorder: false,
        enableAsyncPostRender: true,
        autoHeight:true
    };

    var pgrid = new Slick.Grid("#p_user_grid", v_userd['positions'], pcolumns, toptions);
    pgrid.onSort.subscribe(multi_sort);

}

$(function () {
    activepage(1);
    get_contdata($("#contract").val());
    update_o_c();
    $("#contract").change(function(){
        get_contdata($(this).val());
        update_o_c();
    });
    $("input[name=b_s]").change(function(){
        $("div.trade").removeClass(n($(this).val()));
        $("div.trade").addClass($(this).val());
        update_o_c();
    });
    get_userd();
});