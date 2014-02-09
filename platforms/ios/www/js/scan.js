function alertDismissed() {
    // do nothing
}

function onDeviceReady() {
    jQuery('#scan-btn').on("click", function() {
        cordova.plugins.barcodeScanner.scan(function(result) {
            
            var template = Hogan.compile('<div id="results"><p><span>Barcode Number:</span> <span>{{text}}</span></p><p><span>Barcode Format:</span> <span>{{format}}</span></p></div>');
            
            jQuery('#results').remove();
            jQuery('div.app').append(template.render(result));
            
            //navigator.notification.alert("We got a barcode\n" + "Result: " + result.text + "\n" + "Format: " + result.format + "\n" + "Cancelled: " + result.cancelled, alertDismissed);
        }, function(error) {
            navigator.notification.alert("Scanning failed: " + error, alertDismissed);
        });
    });
}

document.addEventListener('deviceready', onDeviceReady, false);