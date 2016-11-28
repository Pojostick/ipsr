$(function(){
    console.log("ready!");
    $(".pagination").find("a").click(function() {
        appendedURI = "";
        var originalURI = decodeURIComponent($(this).attr('href'))
        if (originalURI.indexOf("checked=") >= 0) {
            // alert(originalURI.indexOf("checked="))
            var url = originalURI
        }else{
            // alert(decodeURIComponent($(this).attr('href')));
            var url = originalURI + "&checked=";
        }
        $('input[type = checkbox]:checked').each(
            function(){
                appendedURI = appendedURI + $(this).attr('name').substring(8,$(this).attr('name').length - 1) + "+";
            }
        )
        var indexOfChecked = url.indexOf("checked=");
        url = url.slice(0, indexOfChecked + 8) + appendedURI + url.slice(indexOfChecked + 8);
        $(this).attr('href', url);
    });
});