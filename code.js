$(document).ready(function(){

    var eKW=200;
    var eTree=20;
    var eGallon=50;
    var sRange1=80;
    var sRange2=20;
    var eCost=80;

	$( ".sliderRange" ).slider({
				range: true,
				min: 0,
				max: 31,
				values: [ 0, 31 ],
				slide: function( event, ui ) {
					$( ".sliderRangeLabel" ).html( ui.values[ 0 ] + " - " + ui.values[ 1 ] );
				}
			});

	buttonPush();
    estimatedCost(eCost)
    estimatedKW(eKW);
    estimatedTree(eTree)
    estimatedGallon(eGallon)
    summaryForTheRange1(sRange1);
    summaryForTheRange2(sRange2);
});

var state;
function buttonPush(){
    $('button').click(function() {
        with($(this)) {
            if(hasClass('btn-success')) removeClass('btn-success').addClass('btn-inverse');
            else removeClass('btn-inverse').addClass('btn-success');
        }
    })
}

function estimatedCost(value){
    var $estimateCost = $('#estimatedCost');
        $estimateCost.text(value + " $");
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
                                        

