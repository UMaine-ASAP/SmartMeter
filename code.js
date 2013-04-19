$(document).ready(function(){


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
	estimatedCost();
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

function estimatedCost(){
	
    $('foo').click(function() {
    	var i = setInterval(function ()
        {
            if (currentVal === endVal)
            {
                clearInterval(i);
                reset.disabled = false;
                $counter.animate({fontSize: fontSize});
            }
            else
            {
                currentVal++;
                $counter.text(prefix+currentVal).animate({fontSize: '+=1'}, 100);
            }
        }, 100);

    })
}
