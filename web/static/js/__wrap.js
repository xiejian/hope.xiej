/**
 * Created by PyCharm.
 * User: xiej
 * Date: 12-2-6
 * Time: 下午8:10
 * To change this template use File | Settings | File Templates.
 */
function n(b_s){
    if(b_s =='B')   {        return 'S';    }
    else if(b_s =='S'){return 'B';}
    else{return 0;}
}

$.tools.validator.fn("[data-equals]", "Value not equal with the $1 field", function(input) {
    var name = input.attr("data-equals"),
        field = this.getInputs().filter("[name=" + name + "]");
    return input.val() == field.val() ? true : [name];
});
$.tools.validator.fn("[minlength]", function(input, value) {
    var min = input.attr("minlength");
    return value.length >= min ? true : {
        en: "Please provide at least " +min+ " character" + (min > 1 ? "s" : ""),
        fi: "Kentän minimipituus on " +min+ " merkkiä"
    };
});

$(function () {
    $("form").validator({
        position: 'bottom left',
        offset: [8, 0],
        message: '<div><em/></div>' // em element is the arrow
    });
    var triggers = $(".modalInput").overlay({
        // some mask tweaks suitable for modal dialogs

        onClose: function(event, tabIndex) {
            $("div.error").remove();
            $("div.modal form").show();
            $('div.modal').find('.form_result').hide();
        },
        mask: {
            color: '#331',
            loadSpeed: 200,
            opacity: 0.8
        },
        effect: 'apple',
        closeOnClick: false
    });
    var triggersF = $(".modalInputF").overlay({
        // some mask tweaks suitable for modal dialogs

        onClose: function(event, tabIndex) {
            $("div.error").remove();
            $("div.modal form").show();
            $('div.modal').find('.form_result').hide();
        },
        onBeforeLoad: function() {
            // grab wrapper element inside content
            var wrap = this.getOverlay().find(".contentWrap");
            // load the page specified in the trigger
            wrap.load(this.getTrigger().attr("href"));
        },
        mask: {
            color: '#331',
            loadSpeed: 200,
            opacity: 0.8
        },
        top:5,
        effect: 'apple',
        closeOnClick: false
    });


    $("div.msg_err,div.msg_suc,div.msg_message").fadeIn('slow', function() {
        // Animation complete
    });


    $("div.modal form").submit(function(e) {

        var form = $(this);

        // client-side validation OK.
        if (!e.isDefaultPrevented()) {

            $.post( form.attr('action'), form.serialize(),function( response ) {
                    if ('goto' in response) {window.location = response.goto;}
                    $('div.modal').find('.form_result').addClass(response.type).html(response.msg );
                }
            );
            form.hide();
            $('div.modal').find('.form_result').fadeIn('slow');
            e.preventDefault();
        }
    });

    $(":date").dateinput({format: "yyyy-mm-dd"});
});

(function() {
    if (window.__twitterIntentHandler) return;
    var intentRegex = /twitter\.com(\:\d{2,4})?\/intent\/(\w+)/,
        windowOptions = 'scrollbars=yes,resizable=yes,toolbar=no,location=yes',
        width = 550,
        height = 420,
        winHeight = screen.height,
        winWidth = screen.width;

    function handleIntent(e) {
        e = e || window.event;
        var target = e.target || e.srcElement,
            m, left, top;

        while (target && target.nodeName.toLowerCase() !== 'a') {
            target = target.parentNode;
        }

        if (target && target.nodeName.toLowerCase() === 'a' && target.href) {
            m = target.href.match(intentRegex);
            if (m) {
                left = Math.round((winWidth / 2) - (width / 2));
                top = 0;

                if (winHeight > height) {
                    top = Math.round((winHeight / 2) - (height / 2));
                }

                window.open(target.href, 'intent', windowOptions + ',width=' + width +
                    ',height=' + height + ',left=' + left + ',top=' + top);
                e.returnValue = false;
                e.preventDefault && e.preventDefault();
            }
        }
    }

    if (document.addEventListener) {
        document.addEventListener('click', handleIntent, false);
    } else if (document.attachEvent) {
        document.attachEvent('onclick', handleIntent);
    }
    window.__twitterIntentHandler = true;
}());
