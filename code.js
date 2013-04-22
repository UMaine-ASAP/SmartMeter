$(document).ready(function(){

    var eCost=25;
    var sRange1=80;
    var sRange2=20;
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
	estimatedCost(eCost);
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


// Show a random number during 5s then display the last one 

function estimatedCost(endVal){
    var $counter = $('#counter'),
        startVal = $counter.text(),
        currentVal,
        suffix = '$',
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
           $percentage.text("Normal (" + (current_perc)+'%):');

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
           $percentage.text("Peacks (" + (current_perc)+'%):');

        }, 30);

    },30);

}                                          
                                        

