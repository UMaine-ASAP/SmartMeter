var currentDate = new Date();
var currentDay = currentDate.getDate();
var currentMonth = currentDate.getMonth() + 1;
var currentYear = currentDate.getFullYear();

var eKW=200;
var eTree=20;
var eGallon=50;
var sRange1=80;
var sRange2=20;
var eCost=80;

/* Settings in the nav left */

var timescaleChoice,
    selectedPeriod,
    addWeatherData,
    beginSelectedRange,
    endSelectedRange;



$(document).ready(function(){

    
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
    
    $( ".sliderRangeLabel" ).text("0 - 30")

    $( ".sliderRange" ).slider({
                range: true,
                min: 0,
                max: 30,
                values: [ 0, 30],
                slide: function( event, ui ) {
                    $( ".sliderRangeLabel" ).html(ui.values[ 0 ] + " - " + ui.values[ 1 ] );
                    //$( "#amount" ).val( "$" + ui.values[ 0 ] + " - $" + ui.values[ 1 ] );
                }
    });

    



    $('.form_datetime').datetimepicker({
        // We have only the datas for the month of october 2011
        /*
        startDate: (currentYear-2) + '-' + currentMonth + '-' + currentDay, 
        endDate: currentYear + '-' + currentMonth + '-' + currentDay,
        */
        startDate: 2011 + '-' + 10 + '-' + 1, 
        endDate: 2011 + '-' + 10 + '-' + 30, 
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

    

    /* Default values for the submitbutton */

    timescaleChoice = "Month";
   
    selectedPeriod=0;
    addWeatherData=$('#checkBoxWeather').prop("checked");
    beginSelectedRange=  $( ".sliderRange" ).slider( "values", 0 );
    endSelectedRange = $( ".sliderRange" ).slider( "values", 1 );

    buildSVGGraph(timescaleChoice, selectedPeriod, addWeatherData, beginSelectedRange, endSelectedRange);
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

        $('input[id=textSelector]').val(''); //reinitialize the input field when another button is clicked


        $( ".sliderRangeLabel" ).text("0 - 23")
        $( ".sliderRange" ).slider({
                range: true,
                min: 0,
                max: 23,
                values: [ 0, 23 ],
                slide: function( event, ui ) {
                    $( ".sliderRangeLabel" ).html(ui.values[ 0 ] + " - " + ui.values[ 1 ] );
                }
        });

        // weird way to update our picker: first remove then re initialize the same tab
        $('.form_datetime').datetimepicker('remove');
        $('.form_datetime').datetimepicker({
            startDate: 2011 + '-' + 10 + '-' + 1, 
            endDate: 2011 + '-' + 10 + '-' + 30, 
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

        
        // update current timescale
        timescaleChoice = "Day"; 


    }

    //months
    if(cliked_id === "button2") {

        $('#button2.btn-normal').removeClass('btn-normal').addClass('btn-inverse');
        $('#button1.btn-inverse').removeClass('btn-inverse').addClass('btn-normal');
        $('#button3.btn-inverse').removeClass('btn-inverse').addClass('btn-normal');

        $('#textTimescale').text("Select a month");
        $('#textTimescaleRange').text("Select a day range");
        $('input[id=textSelector]').val('');

        $( ".sliderRangeLabel" ).text("0 - 30")
        $( ".sliderRange" ).slider({
                    range: true,
                    min: 0,
                    max: 30,
                    values: [ 0, 30 ],
                    slide: function( event, ui ) {
                        $( ".sliderRangeLabel" ).html(ui.values[ 0 ] + " - " + ui.values[ 1 ] );
                    }
        });

        $('.form_datetime').datetimepicker('remove');
        $('.form_datetime').datetimepicker({
            startDate: 2011 + '-' + 10 + '-' + 1, 
            endDate: 2011 + '-' + 10 + '-' + 30, 
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

        timescaleChoice = "Month";

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
            startDate: 2011 + '-' + 10 + '-' + 1, 
            endDate: 2011 + '-' + 10 + '-' + 30, 
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

        timescaleChoice = "Year";
    }
}

function submitButtonClicked(){

    // We get all the parameters

    
    // for the period we get the two last character and we convert them in int ... quite ugly I know. 
        
    selectedPeriod= $('input[id=textSelector]').val();
    var last2 = parseInt( + selectedPeriod.substr(selectedPeriod.length - 2));

    if (last2 != 0){
        timescaleChoice = timescaleChoice;
        addWeatherData=$('#checkBoxWeather').prop("checked");
        beginSelectedRange=  $( ".sliderRange" ).slider( "values", 0 ) ;
        endSelectedRange = $( ".sliderRange" ).slider( "values", 1 ) ;

        $("svg").remove();
        buildSVGGraph(timescaleChoice, last2, addWeatherData, beginSelectedRange, endSelectedRange);
    }
    
    else{
        alert("Fill all the fields please")
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

//buildSVGGraph(timescaleChoice, selectedPeriod, addWeatherData, selectedRange);

function buildSVGGraph(typeOfGraphToBuild, periodToBuild, weatherToBuild, beginRangeToBuild, endRangeToBuild){

    
   var margin = {top: 20, right: 20, bottom: 30, left: 50},

    width = $('#mySVG').width()- margin.left - margin.right,
    height = 500 - margin.top - margin.bottom;

    var formatPercent = d3.format(".0%");

    var x = d3.scale.ordinal()
        .rangeRoundBands([0, width], .1);

    var y = d3.scale.linear()
        .range([height, 0]);

    var xAxis = d3.svg.axis()
        .scale(x)
        .orient("bottom");

    var yAxis = d3.svg.axis()
        .scale(y)
        .orient("left");

    var svg;


    svg = d3.select("#mySVG").append("svg")
    .attr("height", height + margin.top + margin.bottom)
    .attr("container", 'mySVG')
    .append("g")

    .attr("transform", "translate(" + margin.left + "," + margin.top + ")");

    // The SVG graph:

    $.get('http://localhost:8888/code/bootstrap/data/greenbutton.xml', function(d){ 
        var data = $.xmlToJSON(d)
        data = data.content.IntervalBlock.IntervalReading;

        // So, since green button data is kinda ugly, I'm gonna parse it out here now and maybe we can do something better later

        var threshold = 4700;

        if(typeOfGraphToBuild== "Day"){
            dayGraph(svg, x, y, xAxis, yAxis, width, height, threshold, data, periodToBuild, beginRangeToBuild, endRangeToBuild);
        }

        if(typeOfGraphToBuild== "Month"){
            monthGraph(svg, x, y, xAxis, yAxis, width, height, threshold, data);
        }

        if(typeOfGraphToBuild== "Year"){
           //... Do something
        }        
        
        // TODO on a hover of a certain element ...
        $('.barPeack').hover(function() {
          $(this).css( 'cursor', 'pointer' );
        });

        $('#bar1').click(function() {
          alert("Hello")
          //dayGraph,,,,

        });
    });


}

function monthGraph(svg, x, y, xAxis, yAxis, width, height, threshold, data){

    var total_data_day = [];
    var normal_data_consumption= [];
    var i = 0;
    var consumption_total_per_day =0;
    var consumption_normal_per_day =0;
    var dateOfTheDay;

    // we select the 24*30 first hours... ie the first 31 days ie the first month!

    $.each(data.slice(0, 748), function(ind, val) {

      if(ind%24 != 0 || ind==0){  // for the range 0 to 23 of every day ...

        if (parseInt(val.value.Text, 10)<threshold){
          consumption_normal_per_day = parseInt(val.value.Text, 10) + consumption_normal_per_day; // consomption which is under the threshold
        }

        consumption_total_per_day= parseInt(val.value.Text, 10) + consumption_total_per_day; // total consomption
        dateOfTheDay = new Date(parseInt(val.timePeriod.start.Text, 10) *1000);
      }

      else{
        total_data_day[i] = []; 
        total_data_day[i]['value']= consumption_total_per_day;

        normal_data_consumption[i] = [];  
        normal_data_consumption[i]['value']= consumption_normal_per_day;

        consumption_total_per_day=0;
        consumption_normal_per_day =0;
        total_data_day[i]['time'] = dateOfTheDay;
        normal_data_consumption[i]['time'] = dateOfTheDay;

        i++;

      }
      

    });


    x.domain(total_data_day.map(function(d) { 
      console.log(d.time.getDate());
      return d.time.getDate(); }));

    y.domain([0, d3.max(total_data_day, function(d) { return d.value })]);

    //  in order to have two kinds of datas displayed on the same graph we superpose the normal (in yellow) and the total datas (in red)

    // the "total" bars:
    
    svg.selectAll(".bar")

        .data(total_data_day)          
        .enter().append("rect")
        .attr("id", function(d) {return ("bar" + d.time.getDate()); })

        .attr("x", function(d) {return x(d.time.getDate()); }) // change the date here!
        .attr("width", x.rangeBand())
        .transition().delay(function (d, i) { return i *30;}) // Cutsy animation
        .attr("y", function(d) { return y(d.value);  })
        .attr("height", function(d) {return (height - y(d.value)); })
        .attr("class", function(d) {return "barPeack";})

    // the "normal" bars :
    
    svg.selectAll(".bar")

        .data(normal_data_consumption)          
        .enter().append("rect")

        .attr("x", function(d) {return x(d.time.getDate()); }) 
        .attr("width", x.rangeBand())
        .transition().delay(function (d, i) { return i *30;}) // Cutsy animation
        .attr("y", function(d) { return y(d.value);  })
        .attr("height", function(d) {return (height - y(d.value)); })
        .attr("class", function(d) {return "barNormal";})
        // COMMON SETTINGS FOR THE GRAPH
        
    svg.append("g")
        .attr("class", "x axis")
        .attr("transform", "translate(0," + height + ")")
        .call(xAxis)
    .append("text") 
        //.style("text-anchor", "end") TODO...
        .text("days");

    svg.append("g")
        .attr("class", "y axis")
        .call(yAxis)
      .append("text")
        .attr("transform", "rotate(-90)")
        .attr("y", 8)
        .attr("dy", ".71em")
        .style("text-anchor", "end")
        .text("Killowatt Hours");

} 

function dayGraph(svg, x, y, xAxis, yAxis, width, height, threshold, data, dateOfTheDay, begin, end){
    
    var beginningHour = dateOfTheDay * 24 + -24 + begin; 
    var endHour = dateOfTheDay * 24 + -24 + end +1;

    var hour_data = []
    $.each( data.slice(beginningHour, endHour), function(ind, val) {

      hour_data[ind] = [];
      hour_data[ind]['value'] = parseInt(val.value.Text, 10);
      hour_data[ind]['time'] = new Date(parseInt(val.timePeriod.start.Text, 10)*1000);

    });


    // This if for one DAY: 

    x.domain(hour_data.map(function(d) {
    return d.time.getHours(); }));
    y.domain([0, d3.max(hour_data, function(d) { return d.value; })]);


    svg.selectAll(".bar")

        .data(hour_data)          
        .enter().append("rect")

        .attr("x", function(d) {console.log(d.time.getDate());
        return x(d.time.getHours()); })
        .attr("width", x.rangeBand())
        .transition().delay(function (d, i) { return i *30;}) // Cutsy animation
        .attr("y", function(d) { return y(d.value);  })
        .attr("height", function(d) {return (height - y(d.value)); })
        .attr("class", function(d) {
          if ((d.value)<threshold){
            return "barNormal";
          }
          else {
            return "barPeack";
          }
        })


    // COMMON SETTINGS FOR THE GRAPH
        
    svg.append("g")
        .attr("class", "x axis")
        .attr("transform", "translate(0," + height + ")")
        .call(xAxis);

    svg.append("g")
        .attr("class", "y axis")
        .call(yAxis)
      .append("text")
        .attr("transform", "rotate(-90)")
        .attr("y", 8)
        .attr("dy", ".71em")
        .style("text-anchor", "end")
        .text("Killowatt Hours");


}                                          
                                        

