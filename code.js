var currentDate = new Date();
var currentDay = currentDate.getDate()
var currentMonth = currentDate.getMonth() + 1
var currentYear = currentDate.getFullYear()

$(document).ready(function(){
    var eKW=200;
    var eTree=20;
    var eGallon=50;
    var sRange1=80;
    var sRange2=20;
    var eCost=80;

    // The pop up for devices part
    $.extend($.gritter.options, {
        position: 'bottom-left', 
        fade_in_speed: 1000, 
        fade_out_speed: 40,
    });
    setTimeout(function(){
        $.gritter.add({
            title: 'Remember!',
            text: 'On the <a href="dashboard.html" style="color:#ccc">device page</a> you can run a simulation to improve your consumption',
            //stay display on screen    
            sticky: true,
            time: '30',
            class_name: 'my-sticky-class',
            fade: true,
        });

    }, 8000)
    

    $( ".sliderRangeLabel" ).text("0 - 31")

	$( ".sliderRange" ).slider({
				range: true,
				min: 0,
				max: 31,
				values: [ 0, 31 ],
				slide: function( event, ui ) {
					$( ".sliderRangeLabel" ).html(ui.values[ 0 ] + " - " + ui.values[ 1 ] );
				}
	});

    $('.form_datetime').datetimepicker({
        // We assume we have the datas of the last two years
        startDate: (currentYear-2) + '-' + currentMonth + '-' + currentDay, 
        endDate: currentYear + '-' + currentMonth + '-' + currentDay,
        minView:'year',
        maxView:'year',
        startView: 'year',
        // decade: to see all the years
        // year: to see all the months
        // month: to see all the days

        pickerPosition:'bottom-left',
        format: 'MM',
        todayBtn:  0,
        autoclose: 1,
        todayHighlight: 1,
        forceParse: 0,

        showMeridian: 1
    });

    $('#textTimescale').text("Select a month");
    $('#textTimescaleRange').text("Select a day range");

    estimatedCost(eCost);
    estimatedKW(eKW);
    estimatedTree(eTree);
    estimatedGallon(eGallon);
    summaryForTheRange1(sRange1);
    summaryForTheRange2(sRange2);

});



function buttonPush(cliked_id){

    // days
    if(cliked_id === "button1") {
        $('#button1.btn-normal').removeClass('btn-normal').addClass('btn-inverse');
        $('#button2.btn-inverse').removeClass('btn-inverse').addClass('btn-normal');
        $('#button3.btn-inverse').removeClass('btn-inverse').addClass('btn-normal');
        
        $('#textTimescale').text("Select a day");
        $('#textTimescaleRange').text("Select a hour range");
        $('input[id=textSelector]').val(''); //reinitialize the input when another button is clicked

        $( ".sliderRangeLabel" ).text("0 - 24")
        $( ".sliderRange" ).slider({
                range: true,
                min: 0,
                max: 24,
                values: [ 0, 24 ],
                slide: function( event, ui ) {
                    $( ".sliderRangeLabel" ).html(ui.values[ 0 ] + " - " + ui.values[ 1 ] );
                }
        });

        // weird way to update our picker: first remove then re initialize the same tab
        $('.form_datetime').datetimepicker('remove');
        $('.form_datetime').datetimepicker({
            startDate: (currentYear-2) + '-' + currentMonth + '-' + currentDay, 
            endDate: currentYear + '-' + currentMonth + '-' + currentDay,
            minView:'month',
            maxView:'month',
            startView: 'month',
            pickerPosition:'bottom-left',
            format: 'yyyy-MM-dd',
            autoclose: 1,
            todayHighlight: 1,
            forceParse: 0,
            showMeridian: 1
        });
    }

    //months
    if(cliked_id === "button2") {

        $('#button2.btn-normal').removeClass('btn-normal').addClass('btn-inverse');
        $('#button1.btn-inverse').removeClass('btn-inverse').addClass('btn-normal');
        $('#button3.btn-inverse').removeClass('btn-inverse').addClass('btn-normal');

        $('#textTimescale').text("Select a month");
        $('#textTimescaleRange').text("Select a day range");
        $('input[id=textSelector]').val('');

        $( ".sliderRangeLabel" ).text("0 - 31")
        $( ".sliderRange" ).slider({
                    range: true,
                    min: 0,
                    max: 31,
                    values: [ 0, 31 ],
                    slide: function( event, ui ) {
                        $( ".sliderRangeLabel" ).html(ui.values[ 0 ] + " - " + ui.values[ 1 ] );
                    }
        });

        $('.form_datetime').datetimepicker('remove');
        $('.form_datetime').datetimepicker({
            startDate: (currentYear-2) + '-' + currentMonth + '-' + currentDay, 
            endDate: currentYear + '-' + currentMonth + '-' + currentDay,
            minView:'year',
            maxView:'year',
            startView: 'year',
            format: 'MM',
            pickerPosition:'bottom-left',
            autoclose: 1,
            todayHighlight: 1,
            forceParse: 0,
            showMeridian: 1
        });

    }

    //year
    if(cliked_id === "button3") {
        $('#button3.btn-normal').removeClass('btn-normal').addClass('btn-inverse');
        $('#button2.btn-inverse').removeClass('btn-inverse').addClass('btn-normal');
        $('#button1.btn-inverse').removeClass('btn-inverse').addClass('btn-normal');

        $('#textTimescale').text("Select a year");
        $('#textTimescaleRange').text("Select a month range");
        $('input[id=textSelector]').val('');

        $( ".sliderRangeLabel" ).text("0 - 12")
        $( ".sliderRange" ).slider({
                    range: true,
                    min: 0,
                    max: 12,
                    values: [ 0, 12 ],
                    slide: function( event, ui ) {
                        $( ".sliderRangeLabel" ).html(ui.values[ 0 ] + " - " + ui.values[ 1 ] );
                    }
        });

        $('.form_datetime').datetimepicker('remove');
        $('.form_datetime').datetimepicker({
            startDate: (currentYear-2) + '-' + currentMonth + '-' + currentDay, 
            endDate: currentYear + '-' + currentMonth + '-' + currentDay,
            minView:'decade',
            maxView:'decade',
            startView: 'decade',
            pickerPosition:'bottom-left',
            format: 'yyyy',
            autoclose: 1,
            todayHighlight: 1,
            forceParse: 0,

            showMeridian: 1
        });
        

    }
}


function estimatedCost(value){
    var $estimateCost = $('#estimatedCost');
        $estimateCost.text("$ " + value);
}




function estimatedKW(endVal){
    var $counter = $('#textCircle1'),
        startVal = $counter.text(),
        currentVal,
        suffix = 'kWh',
        currentVal = startVal;

    $counter.css('opacity', '.3');
        
    var i = setInterval(function (){
        if (currentVal === endVal){
            clearInterval(i);
            $counter.css('opacity', '1');
        }
        else{
            currentVal++;
            $counter.text(currentVal+" "+suffix);
        }
    }, 20);
}

function estimatedTree(endVal){
    var $counter = $('#textCircle2'),
        startVal = $counter.text(),
        currentVal,
        currentVal = startVal;

    $counter.css('opacity', '.3');
        
    var i = setInterval(function (){
        if (currentVal === endVal){
            clearInterval(i);
            $counter.css('opacity', '1');
        }
        else{
            currentVal++;
            $counter.text(currentVal);
        }
    }, 30);
}

function estimatedGallon(endVal){
    var $counter = $('#textCircle3'),
        startVal = $counter.text(),
        currentVal,
        currentVal = startVal;

    $counter.css('opacity', '.3');
        
    var i = setInterval(function (){
        if (currentVal === endVal){
            clearInterval(i);
            $counter.css('opacity', '1');
        }
        else{
            currentVal++;
            $counter.text(currentVal);
        }
    }, 30);
}

function summaryForTheRange1(endValue){

    var $percentage = $('#percentageNormal');

    setTimeout(function(){
        
        var progressBar = $('#progressBar1');
        var perc = endValue;
        var current_perc = 0;

        var progress = setInterval(function() {
            if (current_perc>=perc) {
                clearInterval(progress);
            } else {
                current_perc ++;
                progressBar.css('width', (current_perc)+'%');
            }
           $percentage.text("Normal consumption (<15 kWh) : " + (current_perc)+'%');

        }, 30);

    },30);

}

function summaryForTheRange2(endValue){

    var $percentage = $('#percentagePeak');

    setTimeout(function(){
        
        var progressBar = $('#progressBar2');
        var perc = endValue;
        var current_perc = 0;

        var progress = setInterval(function() {
            if (current_perc>=perc) {
                clearInterval(progress);
            } else {
                current_perc ++;
                progressBar.css('width', (current_perc)+'%');
            }
           $percentage.text("Peacks : " + (current_perc)+'%');

        }, 30);

    },30);

}                                          
                                        

