var MinNameLength = 3;
var MaxNameLength = 20;
var MinHeight = 120;
var MaxHeight = 220;
var minBrithDay = 1950;
var maxBrithDay = 2018;

$(function () {

  $("#datepicker").dateDropper({
    maxYear: maxBrithDay,
    minYear: minBrithDay,
    startFromMonday: false,
    // large: true,
    // largeDefault: true,
    theme: "picker1",
  });

  $("#register").attr("disabled", "disabled").css("opacity", "0.4");
  $(".gender").click((e) => {
    $(".gender").removeClass("active");
    $(e.currentTarget).addClass("active");
    $("#genderbox").attr("data-gender", e.currentTarget.id);
  });

  $("#datepicker").on("change", (e) => {
    if (
      $("#datepicker").val().split("/")[2] > maxBrithDay ||
      $("#datepicker").val().split("/")[2] < minBrithDay
    ) {
      e.target.value = "";
      successActive(e.target);
      toast("Please Enter Valid Brithday");
    } else {
      errorActive(e.target);
    }
  });

  $(".form-control").on("input", (e) => {
    if (
      $("#name").val().length >= MinNameLength &&
      $("#lastname").val().length >= MinNameLength &&
      Number($("#height").val()) >= MinHeight &&
      Number($("#height").val()) <= MaxHeight
    ) {
      $("#register").removeAttr("disabled").css("opacity", "1");
    } else {
      $("#register").attr("disabled", "disabled").css("opacity", "0.4");
    }
  });
  $(".text-input").on("input", (e) => {
    for (let i = 0; i < e.target.value.length; i++) {
      if (!isNaN(e.target.value[i])) {
        e.target.value = "";
      }
    }
    if (e.target.value.length <= 1) {
      $(e.target).val(e.target.value[0].toUpperCase());
    }
    if (
      $(e.target).val().length < MinNameLength ||
      $(e.target).val().length > MaxNameLength
    ) {
      successActive(e.target);
    } else {
      errorActive(e.target);
    }
  });
  $("#height").on("input", (e) => {
    if (
      Number($("#height").val()) < MinHeight ||
      Number($("#height").val()) > MaxHeight
    ) {
      successActive(e.target);
    } else {
      errorActive(e.target);
    }
  });
  $("input").on({
    keydown: function (e) {
      if (e.which === 32) return false;
    },
  });

  // Disable form submit
  $("input").submit(function () {
    return false;
  });
});

function successActive(elem) {
  $(elem).addClass("error");
  $(elem).removeClass("success");
  $(elem).parent().children()[0].setAttribute("src", "./assets/imgs/error.svg");
  $(elem).parent().children()[0].style.display = "block";
  $(elem).parent().children()[0].style.filter =
    "drop-shadow(2px 2px 5px #9a024b)";
}

function errorActive(elem) {
  $(elem).removeClass("error");
  $(elem).addClass("success");
  $(elem)
    .parent()
    .children()[0]
    .setAttribute("src", "./assets/imgs/success.svg");
  $(elem).parent().children()[0].style.display = "block";
  $(elem).parent().children()[0].style.filter =
    "drop-shadow(2px 2px 5px #08a616)";
}

$(function () {
  $.post(`https://${GetParentResourceName()}/ready`, JSON.stringify({}));
  $("#register").on("click", (e) => {
    $.post(
      `https://${GetParentResourceName()}/register`,
      JSON.stringify({
        firstname: $("#name").val(),
        lastname: $("#lastname").val(),
        dateofbirth: $("#datepicker").val(),
        sex: $("#genderbox").attr("data-gender"),
        height: $("#height").val(),
      })
    );
  });
});

function show_popup() {
  $("body").fadeOut();
  document.body.style.display = "none";
  $(".visible").hide();
  $("#main").css({ transform: "", filter: "" }).attr("disabled", "disabled");
}

function alphanumeric(inputtxt) {
  var letterNumber = /^[0-9a-zA-Z]+$/;
  if (inputtxt.value.match(letterNumber)) {
    return true;
  } else {
    return false;
  }
}

function toast(msg) {
  $("#toastmsg").html(msg);
  $(".toast").css({ left: "40%", opacity: "1" });
  setTimeout(() => {
    $(".toast").css({ left: "20%", opacity: "0" });
  }, 5000);
}

window.addEventListener("message", (event) => {
  switch (event.data.action) {
    case "loading":
      $("#main")
        .css({
          transform: "scale(0.0) translate(-25vw,10vw)",
          filter: "blur(4px)",
        })
        .attr("disabled", "disabled");
      $(".visible").show().animate(
        {
          right: "0vw",
          top: "7vw",
        },
        {
          easing: "easeOutQuint",
          duration: 600,
          queue: false,
        }
      );
      $(".visible").animate(
        {
          opacity: 1,
        },
        {
          duration: 200,
          queue: false,
        }
      );

      window.setTimeout(show_popup, 1000);
      break;
    case "enableui":
      document.body.style.display = event.data.enable ? "flex" : "none";
      break;
    case "toast":
      toast(event.data.msg);
      break;
    case "setConfig":
      MinNameLength = event.data.config.MinNameLength;
      MaxNameLength = event.data.config.MaxNameLength;
      MinHeight = event.data.config.MinHeight;
      MaxHeight = event.data.config.MaxHeight;
      minBrithDay = event.data.config.minBrithDay;
      maxBrithDay = event.data.config.maxBrithDay;
      break;

    default:
      console.log("unknow!");
      break;
  }
});
