/***** 매물 상세 페이지 스크립트 *****/
 // 상담 예약 모달창 기능
$(function() {
  
  // 변수 셋팅
  // 현재 시간이 오후 6시 이상이면 minDate를 내일 날짜로 설정
  let minDate = (new Date().getHours() >= 18) ? new Date(new Date().setDate(new Date().getDate() + 1)) : new Date();
  
  // 현재 날짜를 #bookingDate의 string 형식으로 설정
  let today = new Date().getFullYear() + "-"
  	  today += ((new Date().getMonth() + 1 <= 9) ? '0' + (new Date().getMonth() + 1) : (new Date().getMonth() + 1)) + "-"
  	  today += ((new Date().getDate() <= 9) ? '0' + (new Date().getDate()) : (new Date().getDate()));

  // Datepicker 설정
  $("#bookingDate").datepicker();
  $("#bookingDate").datepicker("option", "dateFormat", "yy-mm-dd");
  $("#bookingDate").datepicker("option", "minDate", minDate);
  $("#bookingDate").datepicker("option", "maxDate", "+1W");

  // Timepicker 설정
  $("#bookingTime").timepicker({
    zindex: 99999,
    timeFormat: 'hh:mm p',
    interval: 60,
    minTime: '10',
    maxTime: '18',
    startTime: '10:00',
    dynamic: false,
    dropdown: true,
    scrollbar: true,
    disabled: true
  });

  // 날짜 먼저 선택할 수 있는 기능
  $("#mouseEnterTime").mouseenter(function() {
    if ($("#bookingDate").val() != "") {
      $("#bookingTime").attr("disabled", false);
      
      // 선택한 날짜가 오늘 날짜이면 현재 시간 기준으로 minTime 변경
      if ($("#bookingDate").val() == today) {
        $("#bookingTime").timepicker("option", "minTime", String(minDate.getHours() + 1));
      }
    }
  });
  $("#mouseEnterTime").click(function() {
    if ($("#bookingDate").val() == "") {
      alert("날짜를 먼저 선택해주세요.");
      return false;
    }
  })

  // 날짜, 시간 선택시에만 예약하기 버튼 활성화
  $("#mouseEnterBooking").mouseenter(function() {
    if ($("#bookingDate").val() != "" && $("#bookingTime").val() != "") {
      $("#consultBookingModal .btn-primary").attr("disabled", false);
    } 
  })
  $("#mouseEnterBooking").click(function() {
    if ($("#bookingDate").val() == "" || $("#bookingTime").val() == "") {
      alert("상담하실 날짜와 시간을 선택해주세요.");
      return false;
    }
  })
});
/***** 매물 상세 페이지 스크립트 끝 *****/