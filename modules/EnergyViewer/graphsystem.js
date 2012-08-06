var graphSystem;

(function() {
    "use strict";

    graphSystem = {
        //pass this an element and each series of data that you want to graph; it'll return a reference to it so
        //that you can manipulate the graph further in code if need be
        createGraph: function(/* element, dataSeries, chartOptions*/) {
            var element = arguments[0];
            var dataSeries;
            var chartOptions;

            if (arguments.length >= 2) {
                if (Object.prototype.toString.call(arguments[1]) == "[object Array]") {
                    dataSeries = arguments[1];
                } else {
                    //we have to have a data series or the chart makes no sense
                    throw {
                        name: "Invalid parameter",
                        message: "Invalid data series"
                    }
                }
            }

            if (arguments.length === 3) {
                if (Object.prototype.toString.call(arguments[2]) === "[object Object]") {
                    chartOptions = arguments[2];

                    if (Object.keys(chartOptions).length === 0) {
                        throw {
                            name: "Invalid parameter",
                            message: "Invalid chart options"
                        }
                    }
                }
            }

            if (chartOptions == null) {
                //set up default chart options
                //to be safe, let's assume that you're graphing electricity data by default
                chartOptions = {
                    chart: {
                        //which html element to render the chart inside
                        renderTo: element
                    },

                    credits: {
                        enabled: false
                    },

                    rangeSelector: {
                        buttons: [{
                            type: 'day',
                            count: 1,
                            text: '1 d'
                        }, {
                            type: 'week',
                            count: 1,
                            text: '1 wk'
                        }, {
                            type: 'month',
                            count: 1,
                            text: '1 mo'
                        }, {
                            type: 'year',
                            count: 1,
                            text: '1 yr'
                        }, {
                            type: 'all',
                            text: 'All'
                        }],
                        //the default button
                        selected: 1,

                        //the default date editing format -- %b %e, %Y for consistency with the way dates are displayed
                        //this follows the typical format for datestrings; nothing wonky going on here
                        inputEditDateFormat: "%b %e, %Y"
                    },

                    //we can't define a default here because series requires the data to be in scope
                    series: [{
                        name: 'Electricity usage',
                        data: dataSeries, //we assume that they're passing in just one series if they don't set up chart options
                        tooltip: {
                            //the tooltip that appears if you mouse over the data points
                            valueDecimals: 2,
                            valueSuffix: " kWh"
                        }
                    }],

                    plotOptions: {
                        //since this is a line chart, we specify some custom options here
                        line: {
                            dataGrouping: {
                                //smoothed offsets each dataGrouping to the right, so that the grouped data appears at the center
                                //of its time range instead of at the start date (it makes it look right)
                                smoothed: true,

                                //the default approximation for the data series
                                approximation: "sum",

                                //when data points are closer than 40px together, group them into the next largest possible scale
                                groupPixelWidth: 40,

                                //the allowable units that data can be scaled to
                                units: [[
                                    'hour', //e.g. this means that data will never get grouped into points smaller than 1 hour
                                    [1]
                                ], [
                                    'day',  //days must be displayed individually
                                    [1]
                                ], [
                                    'week',
                                    [1]     //ditto with weeks
                                ], [
                                    'month',
                                    [1]     //and with months!
                                ]]
                            }
                        }
                    }
                }
            }

            //let's hope that everything passed here was right!
            self.chart = new Highcharts.StockChart(chartOptions);
            return self.chart;
        },

        getChart: function() {
            if (self.chart === undefined) {
                return false;
            }

            return self.chart;
        },

        //default values for various variables

        defaultCredits: {
            //whether to display credits
            enabled: false
        }
    };
})();