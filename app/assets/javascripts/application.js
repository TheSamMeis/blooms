// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/sstephenson/sprockets#sprockets-directives) for details
// about supported directives.
//

//= require jquery
//= require jquery_ujs
//= require jquery.ui.all
//= require turbolinks
//= require_tree .


ready =  (
  function() {

  $('div.flowerbox').hover(function() {
    $(this).addClass('hover');
    $(this).find('div.label').css('color','#b4af7c');
  },
  function() {
    $(this).removeClass('hover');
    $(this).find('div.label').css('color','#000');
  });


    $('#datepicker').datepicker(
      {
        altField: '#date',dateFormat: 'yy-mm-dd',
         minDate: 7,
         onSelect: function(){
            var day1 = $("#datepicker").datepicker('getDate').getDate();                 
            var month1 = $("#datepicker").datepicker('getDate').getMonth() + 1;             
    
            var fullDate =  month1 + "-" + day1;

              $( "#dateChoice" ).html( ("") );
              $( "#dateChoice" ).append( (fullDate) );
         }
   
      });

    // $('#datepicker').datepicker(
    //     onSelect: function()
    //           { 
    //             var dateObject = $(this).datepicker('getDate'); 
    //               $( "#typeChoice" ).html( ("") );
    //               $( "#typeChoice" ).append( ("Romantic") );
    // }


  $("nav select").change(function() {
      window.location = $(this).find("option:selected").val();
  });


  $('div.side_box').click(function(){
    window.location = $(this).attr("title");
  });


  $('div.side_box').each(function(){
      var path = window.location.href;
      var current = path.substring(path.lastIndexOf('/'));
      var url = $(this).attr('title');

      if(url == current){
          $(this).addClass('active');
      };
    });  
$('div.frequency_description_button').click(function(){ 
    console.log('clicked')
    $(this).find('div.frequency').addClass('selected_frequency');
    $(this).siblings().find('div.frequency').removeClass('selected_frequency');
 });

 $("#romantic").click(function(){
  console.log("romantic");
    $("#romantic_radio").prop("checked", true);
    $( "#typeChoice" ).html( ("") );
    $( "#typeChoice" ).append( ("Romantic") );
  });
  $("#bright").click(function(){
    $("#brights_radio").prop("checked", true);
    $( "#typeChoice" ).html( ("") );
    $( "#typeChoice" ).append( ("Bright") );
  });
  $("#farmers").click(function(){
    $("#farmers_radio").prop("checked", true);
     $( "#typeChoice" ).html( ("") );
    $( "#typeChoice" ).append( ("Farmer's Choice") );
  });


 $("#2week").click(function(){
    $("#2week_radio").prop("checked", true);
    $( "#frequencyChoice" ).html( ("") );
    $( "#frequencyChoice" ).append( ("2 weeks") );
  });
  $("#4week").click(function(){
    $("#4week_radio").prop("checked", true);
      $( "#frequencyChoice" ).html( ("") );
    $( "#frequencyChoice" ).append( ("4 weeks") );
  });
  $("#holiday").click(function(){
    $("#holiday_radio").prop("checked", true);
      $( "#frequencyChoice" ).html( ("") );
    $( "#frequencyChoice" ).append( ("holiday") );
  });

 $("div.flowerbox").click(function(){
    console.log('clicked')
    $(this).addClass('click');
   $(this).siblings().removeClass('click');
 });


// $('#romantic').click(function(){
//     console.log('clicked_selected')
//     $(this).addClass('selected_flower');
//     $(this).find('div.label').css('color','#FFF');
//   // },
//   // function() {
//   //   $(this).removeClass('hover');
//   //   $(this).find('div.label').css('color','#000');
//   // });

 });

$(document).ready(ready);
$(document).on('page:load',ready);
