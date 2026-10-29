//$(document).ready(function(){
//	var pageHeight = getDocHeight(document);
//	var pageWidth = getDocWidth(document);
////	alert(document.body.scrollWidth);
////	alert(document.body.offsetWidth);
//	var outer = window.parent.document.getElementById('fancybox-wrap');
//	var inner = window.parent.document.getElementById('fancybox-inner');
//	
//	outer.style.height= pageHeight+25 +"px";
//	outer.style.width= pageWidth +20+"px";
//	inner.style.height= pageHeight+12 +"px";
//	inner.style.width= pageWidth +2+"px";
//	parent.$.fancybox.center();
//});
function getDocHeight(doc)
{
	var docHt = 0, docScrollHeight, docOffsetHeight;
	if (navigator.appName=="Microsoft Internet Explorer") 
		docHt = docScrollHeight = doc.body.scrollHeight;
	else
		docHt = docOffsetHeight = doc.body.offsetHeight;
	
	return docHt;
}
function getDocWidth(doc)
{
	var docWt = 0, docScrollWidth, docOffsetWidth;
	if (doc.body.scrollWidth) 
		docWt = docScrollWidth= doc.body.scrollWidth;
	else
		docWt = docOffsetWidth = doc.body.offsetWidth;
	if (docScrollWidth && docOffsetWidth) docHt = Math.max(docScrollWidth, docOffsetWidth);
	return docWt;
}