	var userAvg = 60; // <-- placeholder
	var stateAvg = 521;
	var natAvg = 958;

	if(userAvg > natAvg && userAvg > stateAvg)
	{
		var max = userAvg;
	}
	else if(stateAvg > userAvg && stateAvg > natAvg)
	{
		var max = stateAvg;
	}
	else if(natAvg > userAvg && natAvg > stateAvg)
	{
		var max = natAvg;
	}

	var mid = max / 2;
	mid = Math.floor(mid);
	var userSize = userAvg * (400/max);
	var stateSize = stateAvg * (400/max); 
	var nationalSize = natAvg * (400/max); 

	$(document).ready(function()
	{
		$(".state").css("width", stateSize + "px");
		$(".user").css("width", userSize + "px");
		$(".national").css("width", nationalSize + "px");
		
		if(userAvg > stateAvg && userAvg > natAvg)
		{
			$(".usage").css('color', 'red');
			$(".user").css('background-color', 'red');
		}

		if(userAvg > stateAvg && userAvg < natAvg)
		{
			$(".usage").css('color', 'orange');
			$(".user").css('background-color', 'orange');

		}
		

		if(userAvg < stateAvg && userAvg < natAvg)
		{		
			$(".usage").css('color', 'green');
			$(".user").css('background-color', 'green');

		}		
	}); 


			$(".userUsage").html("$" + roundNumber((userAvg * .1589), 2));
			$(".stateUsage").html("$" + roundNumber((stateAvg * .1589), 2));
			$(".nationalUsage").html("$" + roundNumber((natAvg * .118), 2));

			$(".userUsage").html(userAvg + " kWh");
			$(".stateUsage").html(stateAvg + " kWh");
			$(".nationalUsage").html(natAvg + " kWh");	
		
	function roundNumber(num, dec) 
	{
		var result = Math.round(num*Math.pow(10,dec))/Math.pow(10,dec);
		return result;
	}