// from data.js
var tableData = data;

// YOUR CODE HERE!
// from data.js

var tableData = data;

var len =tableData.length;

console.log(len);

var tbody = d3.select("tbody");

// console.log(data);

//PART A -- Getting the Table on Screen.

//Step 1: Loop Through `data` and console.log each UFO report object. //Step 2:  Use d3 to append one table row `tr` for 

// each weather report object. Step 3:  Use `Object.entries` to console.log each weather report value. //Step 4: Use d3 to 

// append 1 cell per UFO report value (date, city, state, country, Shape, Duration, Comments). Step 5: Use d3 to update 

//each cell's text with weather report values (weekday, date, high, low)

function init() {

data.forEach(function(UFO) {

  // console.log(UFO);

  var row = tbody.append("tr");

  Object.entries(UFO).forEach(function([key, value]) {

    // console.log(key, value);

  var cell = tbody.append("td");

  cell.text(value);

  });

});

}

var _filteredData;

var _date_ele= d3.select("#form-control-date");

// var _date_value= _date_ele.property("value");

var _date_value= _date_ele.value;

console.log(_date_value);
function filtered_display() {
  tableData.forEach(function(UFO1) {

    // console.log(UFO);
 var row = tbody.append("tr");
 Object.entries(UFO1).forEach(function([key, value]) {

     // console.log(key, value);

    var cell = tbody.append("td");

    cell.text(value);

    });

  });

  }
function my_filteredata(){

    if (_date_value != "") {

     tableData = tableData.filter(function (date) {

     var mydd = date.datetime;

     //return mydd === _date_value;

     return date.datetime === "_date_value";

     console.log(_date_value);

     console.log(date.datetime);

     filtered_display();

  });

}

}

function handleSubmit(){

d3.select("tbody").selectAll("tr").remove();

    // d3.select("tbody").remove();

    // //d3.event.preventDefault();

my_filteredata();

        // d3.select("tbody").selectAll("tr").remove();

  }
var _filter_btn = d3.select("#filter-btn");

// logic to handle onClick event on "Filter Table" button

_filter_btn.on("click", function() {

handleSubmit();
});

init();

