$(function(){
  $("input#booking_date").datepicker({
    dateFormat: 'yy-mm-dd'
  });
  $("input#booking_start_at").timepicker({
    hourMin: 8,
    hourMax: 18,
    timeOnlyTitle: '開始時間を選んで下さい',
    stepMinute: 15
  });
  $("input#booking_end_at").timepicker({
    hourMin: 8,
    hourMax: 18,
    timeOnlyTitle: '終了時間を選んで下さい',
    stepMinute: 15
  });
});
