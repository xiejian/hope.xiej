var gv_cont={},gv_user={};

function get_userdata(){
    $.getJSON($SCRIPT_ROOT + '/_userdata', {
    }, function(data) {
        gv_user = data;
    });
}
function get_contdata(cid){
    $.getJSON($SCRIPT_ROOT + '/_contdata', {
        c: cid
    }, function(data) {
        gv_cont[cid] = data;
    });
}
function get_contlp(clist){
    $.getJSON($SCRIPT_ROOT + '/_contdata', {
        cl:clist
    }, function (data) {
        $.each(data, function (key, val) {
            $.each(val, function (key2, val2) {
                gv_cont[key][key2] = val2;
            });
        });
    });
}

$(function () {
    get_userdata();

    $("#contract").change(function(){
        get_contdata($(this).val());
        get_userdata();
        get_contlp(1);
    });
});