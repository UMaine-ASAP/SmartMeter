var currentDate = new Date();
var currentDay = currentDate.getDate();
var currentMonth = currentDate.getMonth() + 1;
var currentYear = currentDate.getFullYear();


/* General principle: we load the XML green button document with all the datas. Inside the document we get all the values and parse them to get the data for each day.
Once the document ready the elements on the page are initialized with these values and we redraw the SVG graph as soon as the user change the parameters.
 */


var eCost=80;

/* Settings in the nav left */

var timescaleChoice,
    selectedPeriod,
    addWeatherData,
    beginSelectedRange,
    endSelectedRange;


// To launch the application we need a MAMP server + going to this URL: http://localhost:8888/code/dashboard.html

// Initialization of the variables

$(document).ready(function(){

    // The pop up //
    $.extend($.gritter.options, {
        position: 'bottom-left', 
        fade_in_speed: 1000, 
        fade_out_speed: 40,
    });
    setTimeout(function(){
        $.gritter.add({
            title: 'Remember!',
            text: 'On the <a href="dashboard.html" style="color:#ccc">device page</a> you can run a simulation to improve your consumption',
            sticky: true,//stay display on screen   
            time: '30',
            class_name: 'my-sticky-class',
            fade: true,
        });

    }, 8000)
    

    // The slider 
    $( ".sliderRangeLabel" ).text("1 - 30")
    $( ".sliderRange" ).slider({
                range: true,
                min: 1,
                max: 30,
                values: [ 1, 30],
                slide: function( event, ui ) {
                    $( ".sliderRangeLabel" ).html(ui.values[ 0 ] + " - " + ui.values[ 1 ] );
                }
    });

    // The datepicker
    $('input[id=textSelector]').val('October');
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
    $('#checkBoxWeather').prop('checked', false);
    selectedPeriod=0;
    addWeatherData=$('#checkBoxWeather').prop("checked");
    beginSelectedRange=  $( ".sliderRange" ).slider( "values", 0 );
    endSelectedRange = $( ".sliderRange" ).slider( "values", 1 );


    buildSVGGraph(timescaleChoice, selectedPeriod, addWeatherData, beginSelectedRange, endSelectedRange);
    

});


// When the user clicks on one of the three buttons concerning the duration

function buttonPush(cliked_id){

    // days
    if(cliked_id === "button1") {
        $('#button1.btn-normal').removeClass('btn-normal').addClass('btn-inverse'); // change the style of the button
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
        // disabled the checkbox for the weather
        $('#weatherRow').css("opacity", 0.5);
        $('#rangeRow').css("opacity", 1);
        $('#periodRow').css("opacity", 1);
        $('#checkBoxWeather').attr('disabled', true);
        $('#checkBoxWeather').prop('checked', false);

    }

    //months
    if(cliked_id === "button2") {

        $('#button2.btn-normal').removeClass('btn-normal').addClass('btn-inverse');
        $('#button1.btn-inverse').removeClass('btn-inverse').addClass('btn-normal');
        $('#button3.btn-inverse').removeClass('btn-inverse').addClass('btn-normal');

        $('#textTimescale').text("Select a month");
        $('#textTimescaleRange').text("Select a day range");
        $('input[id=textSelector]').val('');

        $( ".sliderRangeLabel" ).text("1 - 30")
        $( ".sliderRange" ).slider({
                    range: true,
                    min: 1,
                    max: 30,
                    values: [ 1, 30 ],
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
        $('#weatherRow').css("opacity", 1);
        $('#rangeRow').css("opacity", 1);
        $('#periodRow').css("opacity", 1);
        $('#checkBoxWeather').attr('disabled', false);


    }

    //year
    if(cliked_id === "button3") {
        $('#button3.btn-normal').removeClass('btn-normal').addClass('btn-inverse');
        $('#button2.btn-inverse').removeClass('btn-inverse').addClass('btn-normal');
        $('#button1.btn-inverse').removeClass('btn-inverse').addClass('btn-normal');

        $('#textTimescale').text("Select a year");
        $('#textTimescaleRange').text("Select a month range");
        $('input[id=textSelector]').val('');

        $( ".sliderRangeLabel" ).text("1 - 12")
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
        $('#checkBoxWeather').attr('disabled', true);
        $('#weatherRow').css("opacity", 0.5);
        $('#rangeRow').css("opacity", 0.5);
        $('#periodRow').css("opacity", 0.5);
        
    }
}

// If the user click on the submit button

function submitButtonClicked(){

    // We get all the parameters
    // for the period we get the two last character and we convert them in int ... quite ugly I know. 
        
    selectedPeriod= $('input[id=textSelector]').val();
    var last2 = parseInt( + selectedPeriod.substr(selectedPeriod.length - 2));

    if (last2 != 0){
        //timescaleChoice = timescaleChoice;
        addWeatherData=$('#checkBoxWeather').prop("checked");
        beginSelectedRange=  $( ".sliderRange" ).slider( "values", 0 ) ;
        endSelectedRange = $( ".sliderRange" ).slider( "values", 1 ) ;

        // we remove the svg graph and replace it with another with new parameter
        $("svg").remove();
        buildSVGGraph(timescaleChoice, last2, addWeatherData, beginSelectedRange, endSelectedRange);
    }
    
    else{
        alert("Fill all the fields please")
    }

}


// When the user clicks on a specific bar of the graph

function zoomInTheGraph(d, i){

    $("svg").remove();
    buildSVGGraph("Day", i+1, addWeatherData, 0, 23);

    $('#weatherRow').css("opacity", 0.5);
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

        $('#checkBoxWeather').attr('disabled', true);
        $('#checkBoxWeather').prop('checked', false);
        timescaleChoice="Day";
}


// initialization of the Estimated cost field
function estimatedCost(value){
    var $estimateCost = $('#estimatedCost');
        $estimateCost.text("$ " + value);

}

// initialization of the Total KW/H cost field
function estimatedKW(endVal, duration){
    var $counter = $('#textCircle1'),
        startVal = $counter.text(),
        currentVal,
        suffix = 'kWh',
        currentVal = startVal;
    // due to the very hight value we don't implement a counter but display directly the value    
    $counter.text(endVal+" "+suffix);
    
}

// initialization of the Tree field
function estimatedTree(endVal){

    var $counter = $('#textCircle2'),
        startVal = 0,
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
    }, 20);
}

// initialization of the Barrels field
function estimatedBarrel(endVal, duration){
    var $counter = $('#textCircle3'),
        startVal = 0,
        currentVal = startVal;
    $counter.css('opacity', '.3');
    
    //For a month the animation is faster regarding the quantity of barrels
    if (duration=="Month"){
        var i = setInterval(function (){
        if (currentVal === endVal){
            clearInterval(i);
            $counter.css('opacity', '1');
        }
        else{
            currentVal++;
            $counter.text(currentVal);
        }
        }, 1);

    }
    if(duration=="Day"){
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

    
}

// regarding the duration selected we update the values of the progress bar range

// Normal consumption
function summaryForTheRange1(endValue, duration){
    var $percentage = $('#percentageNormal');

    if (duration=="Month"){
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
           $percentage.text("Normal consumption (during the day consumption <4700 kWh) : " + (current_perc)+'%');

        }, 30);

        },30);
    }
    if (duration=="Day"){
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
           $percentage.text("Normal consumption (consumption <4700 kWh) : " + (current_perc)+'%');

        }, 30);

        },30);
    }

}

// Peacks consumption
function summaryForTheRange2(endValue, duration){
    console.log("deuxieme graph" + endValue);
    var $percentage = $('#percentagePeak');

    if (duration=="Month"){  
        setTimeout(function(){
            
            var progressBar = $('#progressBar2');
            var perc = endValue ;
            var current_perc = 0;

            var progress = setInterval(function() {
                if (current_perc>=perc) {
                    clearInterval(progress);
                    
                } else {
                    current_perc ++;
                    progressBar.css('width', (perc)+'%');
                }
                $percentage.text("Peacks (during the day consumption >4700 kWh): " + (current_perc)+'%');
               

            }, 30);

        },30);

    }
    
    if (duration=="Day"){

        /* remove*/ 

        setTimeout(function(){
            
            var progressBar = $('#progressBar2');
            progressBar.css('width', (0)+'%'); // to avoid a bug if there is 0%
            var perc = endValue ;
            var current_perc = 0;


            var progress = setInterval(function() {
                if (current_perc>=perc) {
                    clearInterval(progress);
                    
                } else {
                    current_perc ++;
                    progressBar.css('width', (perc)+'%');
                }
                $percentage.text("Peacks (consumption >4700 kWh): " + (current_perc)+'%');
               

            }, 30);

        },30);

    }



}

// Common parameters for the graph to months and days
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

    $.get('bootstrap/data/greenbutton.xml', function(d){ 
        var data = $.xmlToJSON(d)
        data = data.content.IntervalBlock.IntervalReading;
        // By default the threshold value is 4700
        var threshold = 4700;

        if(typeOfGraphToBuild== "Day"){
            dayGraph(svg, x, y, xAxis, yAxis, width, height, threshold, data, periodToBuild, beginRangeToBuild, endRangeToBuild);
        }

        if(typeOfGraphToBuild== "Month"){
            monthGraph(svg, x, y, xAxis, yAxis, weatherToBuild, width, height, threshold, data, beginRangeToBuild, endRangeToBuild);
        }

        if(typeOfGraphToBuild== "Year"){
           alert("This feature has not already been implemented")
        }        
        

    });


}

// specific parameters for the months

function monthGraph(svg, x, y, xAxis, yAxis, weatherVisible, width, height, threshold, data, begin, end){

    var total_data_day = [];
    var normal_data_consumption= [];
    var i = 0;
    var consumption_total_per_day =0;
    var consumption_total_per_month =0;
    var consumption_total_normal_per_month =0;
    var consumption_normal_per_day =0;
    var dateOfTheDay;

    // we select the 24*30 first hours... ie the first 31 days ie the first month!

    $.each(data.slice(begin * 24 -24, end *24+24), function(ind, val) {

      if(ind%24 != 0 || ind==0){  // for the range hour 0 to 23 of everyday ...

        if (parseInt(val.value.Text, 10)<threshold){
          consumption_normal_per_day = parseInt(val.value.Text, 10) + consumption_normal_per_day; // consomption which is under the threshold
        }

        consumption_total_per_day= parseInt(val.value.Text, 10) + consumption_total_per_day; // total consomption for one day
       
        dateOfTheDay = new Date(parseInt(val.timePeriod.start.Text, 10) *1000);
        
      }

      else{
        consumption_total_per_month= consumption_total_per_day + consumption_total_per_month;
        consumption_total_normal_per_month= consumption_normal_per_day+ consumption_total_normal_per_month
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

    // updates of the graphs
    
    estimatedKW(parseInt(consumption_total_per_month),"Month");

    // Number of tree seedlings grown for 10 years
    var numberOfTree= consumption_total_per_month*7.05555/10000*0.039; // conversion in kwH + conversion in tree
    //update of the graph
    estimatedTree(parseInt(numberOfTree));

    //barrels of oil consumed
    var numberOfBarrels= consumption_total_per_month*7.05555/10000*0.43; 
    estimatedBarrel(parseInt(numberOfBarrels), "Month");

    //percentage of normal consumption for the month
    var percentageNormal= consumption_total_normal_per_month*100/consumption_total_per_month;
    summaryForTheRange1(Math.round(percentageNormal), "Month")
    summaryForTheRange2(100-Math.round(percentageNormal),"Month")

    estimatedCost(eCost);


    x.domain(total_data_day.map(function(d) { 
        return d.time.getDate(); }));

    y.domain([0, d3.max(total_data_day, function(d) { return d.value })]);

    //  in order to have two kinds of datas displayed on the same graph we superpose the normal (in yellow) and the total datas (in red)

    // the "total" bars:
    
    svg.selectAll(".bar")
        .data(total_data_day)          
        .enter().append("rect")

        .on("mouseover", function(){
            $('.barPeack').css('cursor', 'pointer'); // the cursor is a pointer

        })
        .on("click", zoomInTheGraph)

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
        .on("mouseover", function(){
            $('.barNormal').css('cursor', 'pointer');

        })

        .on("mouseenter", function(){
           $(this).css('fill', '#ea494a');
        })

        .on("mouseleave", function(){
           $(this).css('fill', '#ff9933');
        })

        
        .on("click", zoomInTheGraph)

        .attr("x", function(d) {return x(d.time.getDate()); }) 
        .attr("width", x.rangeBand())
        .transition().delay(function (d, i) { return i *30;}) // Cutsy animation
        .attr("y", function(d) { return y(d.value);  })
        .attr("height", function(d) {return (height - y(d.value)); })
        .attr("class", function(d) {return "barNormal";})
       
        // Forecasts (a random curve):

    var lineData = [ { "x": 15,   "y": 50},  { "x": 50,  "y": 10},
                   { "x": width/10,  "y": 100}, { "x": 0.1*width+width/10,  "y": 200},
                   { "x": 0.2*width+width/10,  "y": 50},  { "x": 0.3*width+width/10, "y": 150},
                   { "x": 0.4*width+width/10,  "y": 50},  { "x": 0.5*width+width/10, "y": 150},
                   { "x": 0.6*width+width/10,  "y": 50},  { "x": 0.7*width+width/10, "y": 150},
                   { "x": 0.8*width+width/10,  "y": 50},  { "x": 0.9*width+width/10, "y": 100},
                   ];

    var lineFunction = d3.svg.line()
                         .x(function(d) { return d.x; })
                         .y(function(d) { return d.y; })
                         .interpolate("basis");

    svg.append("svg:path")
        .attr("d", lineFunction(lineData))
        .attr("stroke", "black")
        .attr("opacity", 0.6)
        .attr("stroke-width", 2)
        .attr("id", "forecastbar")
        .attr("fill", "none");

    if (weatherVisible == true){
        d3.select("#forecastbar")
            .attr("visibility", "visible")
    }

    if (weatherVisible == false){
        d3.select("#forecastbar")
            .attr("visibility", "hidden")
    }

        // COMMON SETTINGS FOR THE GRAPH
        
    svg.append("g")
        .attr("class", "x axis")
        .attr("transform", "translate(0," + height + ")")
        .call(xAxis)
    .append("text") 
        .attr("x", width-20 )
        .attr("y", -5 )
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

// specific parameters for a day

function dayGraph(svg, x, y, xAxis, yAxis, width, height, threshold, data, dateOfTheDay, begin, end){
    
    var beginningHour = dateOfTheDay * 24 + -24 + begin; 
    var endHour = dateOfTheDay * 24 + -24 + end +1;

    var consumption_total=0;
    var consumption_peack=0;

    var hour_data = []
    $.each( data.slice(beginningHour, endHour), function(ind, val) {

      hour_data[ind] = [];
      hour_data[ind]['value'] = parseInt(val.value.Text, 10);
      hour_data[ind]['time'] = new Date(parseInt(val.timePeriod.start.Text, 10)*1000);

      if ((parseInt(val.value.Text, 10)) > threshold){
        consumption_peack= consumption_peack+ parseInt(val.value.Text, 10);
      }
      consumption_total= consumption_total+ parseInt(val.value.Text, 10)
      
    });
    // updates of the graphs
    
    estimatedKW(consumption_total,"Day");

    // Number of tree seedlings grown for 10 years
    var numberOfTree= consumption_total*7.05555/10000*0.039; // conversion in kwH + conversion in tree
    estimatedTree(parseInt(numberOfTree));
    //barrels of oil consumed
    var numberOfBarrels= consumption_total*7.05555/10000*0.43; 
    estimatedBarrel(parseInt(numberOfBarrels), "Day");

    //percentage of normal consumption for the day
    var percentagePeack= consumption_peack*100/consumption_total;
    summaryForTheRange1(100-Math.round(percentagePeack), "Day")
    summaryForTheRange2(Math.round(percentagePeack),"Day")

    estimatedCost((eCost/30).toFixed(2));


    // This if for one DAY: 

    x.domain(hour_data.map(function(d) {
    return d.time.getHours(); }));
    y.domain([0, d3.max(hour_data, function(d) { return d.value; })]);




    svg.selectAll(".bar")

        .data(hour_data)          
        .enter().append("rect")

        .attr("x", function(d) {
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



    // Phantom power    

    svg.append("svg:line")
        .style("stroke-dasharray", ("3, 3")) 
        .attr("x1", 15)
        .attr("y1", height-95)
        .attr("x2", width-15)
        .attr("y2", height-95)
        .attr("stroke-width", 2)
        .attr("stroke", "black")    
    


    // COMMON SETTINGS FOR THE GRAPH
        
    svg.append("g")
        .attr("class", "x axis")
        .attr("transform", "translate(0," + height + ")")
        .call(xAxis)
     //hours label   
    .append("text")
        .attr("x", width-20 )
        .attr("y", -5 )
        .text("hours")

    // Phantom power label
    svg.append("g")
        .append("text")
        .attr("x", 15)
        .attr("y", height-100)
        .text("Phantom Power")    
    
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
                                        
// happy end
