/**
 * Created by PyCharm.
 * User: xiej
 * Date: 12-1-1
 * Time: 下午1:46
 * To change this template use File | Settings | File Templates.
 */
var gv_cont={};
var v_userd;

function get_contdata(cid){
    $.getJSON($SCRIPT_ROOT + '/data', {
        t:'tc',n: cid
    }, function(data) {
        gv_cont = data;
        gv_cont['id']=cid;
        updatepage_contdata();
        update_tradeform();
    });
    return false;
}
function updatepage_contdata(){
    var settledt = new Date(gv_cont['settledate']);
    var htm = "<tr><th>settle date:</th><td>"+parseDate(settledt) + "</td><th>BTC multi:</th><td>" + gv_cont["btc_multi"]+"</td></tr>";
    htm += "<tr><th>leverage:</th><td>"+gv_cont['leverage']*100 + "%</td><th>write fee:</th><td>" + gv_cont["write_fee"]*1000+"‰</td></tr>";
    $("#continfo").html(htm);
    var htm = "";
    $.each(gv_cont["S"], function(index,val) {
        htm = "<tr><td><span class='gr'>　S"+(index+1)+"</span></td><td>"+val["point"]+"</td><td>"+val["rm_lots"]+"</td></tr>" + htm;
    });
    htm = htm + '<tr><td colspan="3" ><div></div></td></tr>';
    $.each(gv_cont["B"], function(index,val) {
        htm = htm + "<tr><td><span class='gr'>　B"+(index+1)+"</span></td><td>"+val["point"]+"</td><td>"+val["rm_lots"]+"</td></tr>";
    });
    var cname = '<a name="'+gv_cont['id']+'" href="/contract?c='+gv_cont['id']+'" class="modalInputF" rel="#cont_overlay">'+gv_cont['name']+'</a> 　';
    var cprice;
    if(gv_cont["ch"] > 0){ cprice = gv_cont["latestpoint"]+' <span class="up">(+'+gv_cont["ch"]+' %)</span>'; }
    else if(gv_cont["ch"] < 0){ cprice = gv_cont["latestpoint"]+' <span class="dn">('+gv_cont["ch"]+' %)</span>'; }
    else    { cprice = gv_cont["latestpoint"]+' <span class="gr">('+gv_cont["ch"]+' %)</span>';}
    $("h3.contheader").html(cname+cprice);
    init_modalInputF($("h3.contheader a"));

    $("#oqueue").html(htm);
    var htm = "";
    $.each(gv_cont["T"], function(index,val) {
        htm += "<tr><td>"+parseDate(val["time"])+"</td><td>"+val["point"]+"</td><td>"+val["lots"]+'</td><td><img src="/static/img/_i_' +val["dir"]+'.png"></td></tr>';
    });
    $("#transhis").html(htm);
    $("input#t_point").val(gv_cont["latestpoint"]);
    clickpoint();
}

function clickpoint(){
    $("table#oqueue tr,table#transhis tr").click(function(){
        var vpoint = $(this).find("td:eq(1)").html();
        var vlots = $(this).find("td:eq(2)").html();
        $("input#t_point").val(vpoint);
        $("input#t_lots").val(vlots);
        update_tradeform()
    });
}

function update_tradeform(){
    $("span#ts_point").html($("input#t_point").val());
    $("span#ts_lots").html($("input#t_lots").val());
    $("span#ts_btc_multi").html(gv_cont["btc_multi"]);

    $("span#ts_value").html(($("input#t_point").val()*$("input#t_lots").val()*gv_cont["btc_multi"]).toFixed(8)*1);

    var b_s = $("input[name=b_s]:checked").val();
    var lots = $("input#t_lots").val();
    var v_lots =0;
    for(i=0;i<v_userd['pos'].length;i++){
        if (v_userd['pos'][i]['c'] == gv_cont['id']){
            if (v_userd['pos'][i]['bs'] =='B'){v_lots += v_userd['pos'][i]['lt'];}else{v_lots -= v_userd['pos'][i]['lt'];}}
    }
    for(i=0;i<v_userd['ord'].length;i++){
        if (v_userd['ord'][i]['c'] == gv_cont['id'] && v_userd['ord'][i]['ty']=='C'){v_lots -= v_userd['ord'][i]['lt'];}
    }
    var vifc=(b_s == 'S'&& v_lots >= lots) ||(b_s == 'B'&& -v_lots >= lots);
    var vmg=0;
    if (vifc){
        $("span.s_toc").addClass("C");
        $("span.s_toc").removeClass("O");
        $("span#ts_margin").html('0 (close)');
    }
    else{
        $("span.s_toc").addClass("O");
        $("span.s_toc").removeClass("C");
        $("span#ts_leverage").html(gv_cont["leverage"]);
        vmg = ($("input#t_point").val()*$("input#t_lots").val()*gv_cont["btc_multi"]*gv_cont["leverage"]).toFixed(8)*1;
    }
    $("span#ts_margin").html(vmg);
    if (vmg > (v_userd.balance + v_userd.p_l - v_userd.omargin - v_userd.pmargin)){
        $("div.trade form div.hr").html('　Not enough BTC');
        $("div.trade input[type=submit]").attr({disabled:"disabled"});
    }
    else{
        $("div.trade form div.hr").html('　');
        $("div.trade input[type=submit]").removeAttr("disabled");
    }
}

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
            if(value > 0){return '<span class="up">+'+value+' (+'+(value*100/dataContext['ct']).toFixed(1)+'%)</span>'; }
            else if(value < 0){return '<span class="dn">'+value+' ('+(value*100/dataContext['ct']).toFixed(1)+'%)</span>'; }
            else    {return '<span class="gr">'+value+'</span>';}}
        },
        mv:{id: "mv", name: "Market Value", field: "mv",width:70, sortable:true,formatter: function ( row, cell, value, columnDef, dataContext) {
            if(value > dataContext['ct']){return '<span class="up">'+value+'</span>'; }
            else if(value < dataContext['ct']){return '<span class="dn">'+value+'</span>'; }
            else{return '<span class="gr">'+value+'</span>'; }}
        },
        v:{id: "v", name: "Value", field: "v", sortable:true},
        lt:{id: "lt", name: "Lots", field: "lt", width:40,sortable:true},
        rlt:{id: "rlt", name: "Remain Lots", field: "rlt", width:40,sortable:true,formatter: function ( row, cell, value, columnDef, dataContext) {
            if(value == dataContext['lt']){return '<span class="gr">'+value+'</span>'; }
            else {return value;}}
        },
        a:{id: "trade", name: "", field: "c",formatter: function ( row, cell, value, columnDef, dataContext ) {
            return '<a href="'+$SCRIPT_ROOT + '/trade?c=' + dataContext['c'] + '"> TRADE </a>';}
        },
        co:{id: "co", name: "Cancel", field: "o",width:45,formatter: function ( row, cell, value, columnDef, dataContext ) {
            return '<a title="Cancel" href="'+$SCRIPT_ROOT + '/trade?co=' + value + '&c='+dataContext['c']+'"></a>';}
        }
    };
    var pcolumns = [cl.ot,cl.cn,cl.bs,cl.pt,cl.lt,cl.ct,cl.mv,cl.mg,cl.pl];
    var ocolumns = [cl.at,cl.ty,cl.cn,cl.bs,cl.pt,cl.lt,cl.rlt,cl.v,cl.mg,cl.co];
    var toptions = {
        enableCellNavigation: true,
        enableColumnReorder: false,
        enableAsyncPostRender: true,
        multiColumnSort: true,
        rowHeight: 28,
        autoHeight:true
    };
    var ogrid = new Slick.Grid("#o_user_grid", v_userd['ord'], ocolumns, toptions);
    ogrid.onSort.subscribe(multi_sort);
    var pgrid = new Slick.Grid("#p_user_grid", v_userd['pos'], pcolumns, toptions);
    pgrid.onSort.subscribe(multi_sort);
}


$(function () {
    activepage(1);
    get_userd();
    get_contdata($("#contract").val());
    $("#contract").change(function(){
        get_contdata($(this).val());
    });
    $("input[name=b_s]").change(function(){
        $("div.trade").removeClass(n($(this).val()));
        $("div.trade").addClass($(this).val());
        update_tradeform();
    });
    $("input#t_lots,input#t_point").change(function(){
        update_tradeform();
    });
});