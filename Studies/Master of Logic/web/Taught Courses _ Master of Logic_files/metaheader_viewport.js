function writeViewportTag() {
	var deviceSize=getDeviceSize();
	var width=getViewportWidth(deviceSize);
	if (width!='device-width' && navigator.userAgent.match(/msie|edge|trident/i)) return; // IE11 misuses the viewport tag to 'zoom in' on the site even on a desktop computer, so we do not generate the viewport-tag in that case.
	var initialScale=getViewportInitialScale(width, deviceSize);

	document.write('<style type="text/css">');
	document.write('	@-ms-viewport { width: '+width+(width=='device-width'?'':'px')+'; }');
	document.write('<'+'/style>');
	document.write('<meta name="viewport" content="width='+width+(initialScale?', initial-scale='+initialScale:'')+'">');
	if (navigator.userAgent.match(/Android/i)) {
		window.addEventListener("load", hideAddressBar);
	}

	function getViewportWidth(deviceSize) {
		if (!deviceSize) deviceSize=getDeviceSize();
		// Note: calculcate the width of the sitewrapper, add a bit for the scrollbar, and use it instead of '1280' here and in metaheader_viewport2.ihtml
		// Note: calculcate the max width on which responsive design should be used (instead of scaled-down desktop design), and use that instead of '768' here and in metaheader_viewport2.ihtml
		var viewportWidth=(deviceSize.width>=768?1280:'device-width');
//		var viewportWidth=(deviceSize.width>432?1024:deviceSize.width);
		return viewportWidth;
	}

	function getViewportInitialScale(width, deviceSize) {
		if (!deviceSize) return '';
		if (width=='device-width') return 1;
		return deviceSize.width/width;
	}

	function getDeviceSize() {
		if ( window.screen && window.screen.availHeight ) {
			return { width: screen.availWidth, height: screen.availHeight };
		} else if ( window.screen && window.screen.height ) {
			return { width: screen.width, height: screen.height };
		} else if ( document.documentElement && document.documentElement.clientHeight) {
			return { width: document.documentElement.clientWidth, height: document.documentElement.clientHeight };
		} else if ( document.body && document.body.clientHeight ) {
			return { width: document.body.clientWidth, height: document.body.clientHeight };
		} else if (window.innerHeight) {
			return { width: window.innerWidth, height: window.innerHeight };
		} else {
			return null;
		}
	}

	function hideAddressBar() {
		// if the viewport was calculated on the basis of a hidden address bar, hide the address bar after loading.
		// (if not, the following will have no effect because the pageheight won't allow scrolling)
		window.scrollTo(0,1);
	}
}
writeViewportTag();
