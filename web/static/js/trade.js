/**
 * Created by PyCharm.
 * User: xiej
 * Date: 12-1-1
 * Time: 下午1:46
 * To change this template use File | Settings | File Templates.
 */
var gv_cont={};

function get_contdata(cid){
    $.getJSON($SCRIPT_ROOT + '/data', {
        t:'tc',n: cid
    }, function(data) {
        gv_cont[cid] = data;
        updatepage_contdata(cid);
    });
    return false;
}
function updatepage_contdata(cid){
    var settledt = new Date(gv_cont[cid]['settledate']);
    var htm = "<tr><th>settle date:</th><td>"+parseDate(settledt) + "</td><th>BTC multi:</th><td>" + gv_cont[cid]["btc_multi"]+"</td></tr>";
    htm += "<tr><th>leverage:</th><td>"+gv_cont[cid]['leverage']*100 + "%</td><th>write fee:</th><td>" + gv_cont[cid]["write_fee"]*1000+"‰</td></tr>";
    $("#continfo").html(htm);
    var htm = "";
    $.each(gv_cont[cid]["S"], function(index,val) {
        htm = "<tr><td>S"+(index+1)+"</td><td>"+val["point"]+"</td><td>"+val["rm_lots"]+"</td></tr>" + htm;
    });
    htm = htm + '<tr><td colspan="3" ><hr/></td></tr>';
    $.each(gv_cont[cid]["B"], function(index,val) {
        htm = htm + "<tr><td>B"+(index+1)+"</td><td>"+val["point"]+"</td><td>"+val["rm_lots"]+"</td></tr>";
    });
    var cname = '<a name="'+cid+'" href="/contract?c='+cid+'" class="modalInputF" rel="#cont_overlay">'+gv_cont[cid]['name']+'</a> 　';
    var cprice;
    if(gv_cont[cid]["ch"] > 0){ cprice = gv_cont[cid]["latestpoint"]+' <span class="up">(+'+gv_cont[cid]["ch"]+' %)</span>'; }
    else if(gv_cont[cid]["ch"] < 0){ cprice = gv_cont[cid]["latestpoint"]+' <span class="dn">('+gv_cont[cid]["ch"]+' %)</span>'; }
    else    { cprice = gv_cont[cid]["latestpoint"]+' <span class="gr">('+gv_cont[cid]["ch"]+' %)</span>';}
    $("h3.contheader").html(cname+cprice);
    init_modalInputF($("h3.contheader a"));

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
        at:{id: "addtime", name: "Add @", field: "at",sortable:true,formatter:function(row, cell, value){return parseDate(value);}},
        cn:{id: "name", name: "Name", field: "n", sortable:true,asyncPostRender: rendercontName},
        mg:{id: "margin", name: "Margin", field: "mg",width:80, sortable:true},
        ot:{id: "opentime", name: "Open @", field: "ot", sortable:true,formatter:function(row, cell, value){return parseDate(value);}},
        ty:{id: "ty", name: "O/C", field: "ty", width:40,sortable:true, formatter:function(row, cell, value){
            return '<img src="/static/img/_i_'+value+'.png" title="'+_dec['t'][value]+'"/>';}},
        bs:{id: "bs", name: "B/S", field: "bs", width:40,sortable:true, formatter:function(row, cell, value){
            return '<img src="/static/img/_i_'+value+'.png" title="'+_dec['t'][value]+'"/>';}},
        ct:{id: "ct", name: "Cost", field: "ct",width:70, sortable:true},
        pt:{id: "pt", name: "Point", field: "pt",width:70, sortable:true},
        pl:{id: "pl", name: "P/L", field: "pl", width:100,sortable:true,formatter: function ( row, cell, value, columnDef, dataContext) {
            if(value > 0){return '<span class="up">+'+value+' ('+value*100/dataContext['ct']+' %)</span>'; }
            else if(value < 0){return '<span class="dn">'+value+' ('+value*100/dataContext['ct']+' %)</span>'; }
            else    {return '<span class="gr">'+value+'</span>';}}
        },
        mv:{id: "mv", name: "Market Value", field: "mv",width:70, sortable:true,formatter: function ( row, cell, value, columnDef, dataContext) {
            if(value > dataContext['ct']){return '<span class="up">'+value+'</span>'; }
            else if(value < dataContext['ct']){return '<span class="dn">'+value+'</span>'; }
            else{return '<span class="gr">'+value+'</span>'; }}
        },
        v:{id: "v", name: "Value", field: "v", sortable:true},
        lt:{id: "lt", name: "Lots", field: "lt", width:50,sortable:true},
        rlt:{id: "rlt", name: "Remain Lots", field: "rlt", width:50,sortable:true,formatter: function ( row, cell, value, columnDef, dataContext) {
            if(value == dataContext['lt']){return '<span class="gr">'+value+'</span>'; }
            else {return value;}}
        },
        a:{id: "trade", name: "", field: "c",formatter: function ( row, cell, value, columnDef, dataContext ) {
            return '<a href="'+$SCRIPT_ROOT + '/trade?c=' + dataContext['c'] + '"> TRADE </a>';}
        },
        co:{id: "co", name: "Cancel", field: "o",width:45,formatter: function ( row, cell, value, columnDef, dataContext ) {
            return '<a href="'+$SCRIPT_ROOT + '/trade?co=' + value + '&c='+dataContext['c']+'"><img src="/static/img/_i_eject.png" title="Cancel"/></a>';}
        }
    };
    var pcolumns = [cl.ot,cl.cn,cl.bs,cl.pt,cl.lt,cl.ct,cl.mv,cl.mg,cl.pl];
    var ocolumns = [cl.at,cl.ty,cl.cn,cl.bs,cl.pt,cl.lt,cl.rlt,cl.v,cl.mg,cl.co];
    var toptions = {
        enableCellNavigation: true,
        enableColumnReorder: false,
        enableAsyncPostRender: true,
        multiColumnSort: true,
        autoHeight:true
    };

    var ogrid = new Slick.Grid("#o_user_grid", v_userd['orders'], ocolumns, toptions);
    ogrid.onSort.subscribe(multi_sort);
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