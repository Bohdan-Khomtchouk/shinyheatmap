
var x;
$( document ).ready(function() {
    var isOpera = !!window.opera || navigator.userAgent.indexOf(' OPR/') >= 0;
    // Opera 8.0+ (UA detection to detect Blink/v8-powered Opera)
    var isChrome = !!window.chrome && !isOpera;   // Chrome 1+
    if (!isChrome) {
        alert( "For the best user experience, we recommend using the Google Chrome browswer, available at:\nhttp://www.google.com/chrome/");
    } 
  
$('#manuBtn').click(function(){
	x = 1;
        $('#autogenModal').modal('hide').one('hidden.bs.modal',function(){
                $('#summaryBSModal').modal('show');
        });
});

$('#gBack').click(function(x){

	if(window.x == '1'){
	   $('#summaryBSModal').modal('hide').one('hidden.bs.modal',function(){
		$('#autogenModal').modal('show');
		});
	}
	else{
	  $('#summaryBSModal').modal('hide');
	}
});

$('#downloadSet').click(function(){
   $('#ioAlert').children('div').children('p').html("<p><strong>Your dataset  has been downloaded!</strong> Edit your data then save your work and upload the dataset.</p>")

});

$('.nav-tabs > li:nth-child(2)').click(function(event){
	$('.progress-bar').css("width",0);

});
$('.nav-tabs > li:nth-child(1)').click(function(event){
	$('.progress-bar').css("width",0);


});


$('#selectGenes').parent().click(function(event){
$('#autoAnalysis').removeAttr("disabled");

});

$('#autoAnalysis').click(function(event){
$('#formatDEButton2').removeAttr("disabled");

});


//var $holder = $('#platLink').detach();
//#$('#summaryBSModal').next().next().children().children().children().first().after($holder);

});
