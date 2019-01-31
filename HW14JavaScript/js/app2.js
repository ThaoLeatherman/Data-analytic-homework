// // YOUR CODE HERE!

// from data.js

var tableData = data;

var len =tableData.length;

console.log(len);

var _tbody = d3.select("tbody");

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

function filtered_display() {

  _filteredData.forEach(function(UFO1) {

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

    var date_ele= d3.select("#form-control-date");

    var date_value= date_ele.property("value");

    var date_value= date_ele.property("value");

    //  alert("input value " + date_value);

    // alert("input elem" + date_ele); 

   // _filteredData = tableData.filter(datecheck => datecheck.datetime === date_value);

    // console.log("filtereddata check "+ _filteredData.length);

    if (date_value != "") {

     fd = fd.filter(function (date) {

     var mydd = date.datetime;

     return mydd === date_value;
  });

}

  //  _filteredData = tableData.filter(function (el) {

  //     //  return el.datetime === "1/2/2010";

  //     return el.datetime === "1/1/2010";

  //  });
 //  filtered_display();

console.log("Check filter " + _filteredData.value);

console.log(_filteredData);

clear_table_for_load();

}
function handleSubmit(){

  //d3.event.preventDefault();

    clear_table_for_load()

    my_filteredata();

  // d3.select("tbody").selectAll("tr").remove();

}

function clear_table_for_load(){

  d3.select("_tbody").selectAll("tr").remove();

  //d3.select("tbody")

 // _filteredData = Data;

 // date_value= "";

//  myform.clear();

  // document.forms("myform").clear();  

}

init();
handleSubmit();