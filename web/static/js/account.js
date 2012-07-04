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

var v_gl;
function get_gl(){
    $.getJSON($SCRIPT_ROOT + '/data', {t: 'ua'}, function(data) {
        v_gl = data;
        update_gl();
        $("#acc_his_grid").next().remove();
    });
    return false;
}
function update_gl(){
    var columns = [
        {id: "time", name: "Time", field: "t", width:85,sortable:true,formatter:function(row, cell, value){return parseDate(value);}},
        {id: "s", name: "Action", field: "s",width:80,formatter:function(row, cell, value, columnDef, dataContext){
            if(value =='T'){return '<img src="/static/img/_i_'+dataContext['ty']+'.png" title="'+_dec['t'][dataContext['ty']]+'"/> <img src="/static/img/_i_'+dataContext['bs']+'.png" title="'+_dec['t'][dataContext['bs']]+'"/>';}
            else if(value=='H'){return '<img src="/static/img/logo.s.gif" title="BTCFE contract" style="height:20px;width: 32px;"/> ' +dataContext['ty'];}
            else if(value=='A'){return '<img src="/static/img/logo.s.gif" title="BTCFE new user " style="height:20px;width: 32px;"/> ' +dataContext['ty'];}
            else if(value=='C'){return '<img src="/static/img/logo.s.gif" title="Contract writer" style="height:20px;width: 32px;"/> ' +dataContext['ty'];}
            else if(value=='B'){return '<img src="/static/img/_i_BTC.png" title="Bitcoin"/> ' + dataContext['ty'];}
            else if(value=='R'){return '<img src="/static/img/logo.s.gif" style="height:20px;width: 32px;" title="Refund"/> refund :  ' + dataContext['ty'];}
            else {return value;}
        }},
        {id: "name", name: "Contract", field: "n", width:93, sortable:true,asyncPostRender: rendercontName},
        {id: "point", name: "Point", field: "pt", sortable:true},
        {id: "lt", name: "Lots", field: "lt", width:40,sortable:true},
        {id: "v", name: "Value", field: "v", width:93, sortable:true},
        {id: "pl", name: "Profit/Loss", field: "pl", width:93,sortable:true,formatter: function(row, cell, value){return updn(value);}},
        {id: "btc", name: "BTC In/Out", field: "b", width:93, sortable:true,formatter: function(row, cell, value){return updn(value);}},
        {id: "fee", name: "FEE", field: "fee", width:93, sortable:true,formatter: function(row, cell, value){return updn(value);}}
    ];
    var toptions = {
        enableCellNavigation: true,
        enableColumnReorder: false,
        enableAsyncPostRender: true,
        showHeaderRow: true,
        headerRowHeight: 32,
        rowHeight: 28,
        autoHeight:true
    };

    (v_gl['trans']).getItemMetadata = function (row) {
        if ($.inArray(v_gl['trans'][row]['s'],['B','R','A']) >= 0 ){ return {columns: {1: {colspan: 3 }}}; }
    };

    var vgrid = new Slick.Grid("#acc_his_grid", v_gl['trans'], columns, toptions);

    function filltitle(){
        $(vgrid.getHeaderRowColumn('time')).html(parseDate(v_gl['openbal']['balance_dt']));
        var link = '';
        if(v_gl['openbal']['n'] > 1320019200){  link = '<a title="Click to get more data" href="#" ><↑more↑></a>';     }
        $(vgrid.getHeaderRowColumn('s')).html(link);
        $(vgrid.getHeaderRowColumn('name')).html('<span>　　Opening balance</span>');
        $(vgrid.getHeaderRowColumn('pl')).html('<span>'+updn(v_gl['openbal']['bal_pl'])+'</span>');
        $(vgrid.getHeaderRowColumn('btc')).html('<span>'+updn(v_gl['openbal']['bal_btc'])+'</span>');
        $(vgrid.getHeaderRowColumn('fee')).html('<span>'+updn(v_gl['openbal']['bal_fee'])+'</span>');
        $(vgrid.getHeaderRowColumn('lt')).html('<span title="= Profit/Loss + BTC In/Out + Fee"> sum('+updn(v_gl['openbal']['balance'])+')</span>');
    }
    filltitle();
    $(vgrid.getHeaderRowColumn('s')).click(function(){
        $.getJSON($SCRIPT_ROOT + '/data', {t: 'ua',n:v_gl['openbal']['n']-3600*24*7}, function(data) {
            v_gl = data;
            (v_gl['trans']).getItemMetadata = function (row) {
                if ($.inArray(v_gl['trans'][row]['s'],['B','R','A']) >= 0 ){ return {columns: {1: {colspan: 3 }}}; }
            };
            vgrid.setData(v_gl['trans']);
            vgrid.updateRowCount();

            filltitle();vgrid.render();
        });
    });
}

$(function(){
    activepage(2);
    //showtab(0);
    getiploc();
    //get_gl();

});
