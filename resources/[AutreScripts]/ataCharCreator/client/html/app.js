var charSex = null;
let selectedValues = {
  tshirt: 0,
  pants: 0,
  shoes: 0,
};
let clotheValues = null;

function openCharCreator(enable) {
  if (enable) {
    $("body").css("display", "block");
  } else {
    $("body").css("display", "none");
  }
}

$(document).ready(function () {
  $.post(
    `http://${GetParentResourceName()}/ReadyForGetSetup`,
    JSON.stringify({})
  );
  window.addEventListener("message", function (event) {
    var YourRolePlay = event.data;
    if (YourRolePlay.flap_open == true) {
      openCharCreator(true);
    } else if (YourRolePlay.flap_open == false) {
      openCharCreator(false);
    }
  });

  $("#rotate_left_character").click(function () {
    // console.log('231')
    $.post(
      `http://${GetParentResourceName()}/character_rotation`,
      JSON.stringify({
        rotationType: "left",
      })
    );
  });

  $("#rotate_right_character").click(function () {
    // console.log('231')
    $.post(
      `http://${GetParentResourceName()}/character_rotation`,
      JSON.stringify({
        rotationType: "right",
      })
    );
  });
});

function save() {
  $.post(
    `http://${GetParentResourceName()}/saveAndClose`,
    JSON.stringify({
      sex: charSex,
    })
  );
}

// sliders
function rangeSlider() {
  let slider = document.querySelectorAll(".range-slider");
  let range = document.querySelectorAll(".range-slider__range");
  let value = document.querySelectorAll(".range-slider__value");

  slider.forEach((currentSlider) => {
    value.forEach((currentValue) => {
      let val = currentValue.previousElementSibling.getAttribute("value");
      currentValue.innerText = val;
    });

    range.forEach((elem) => {
      elem.addEventListener("input", (eventArgs) => {
        elem.nextElementSibling.innerText = eventArgs.target.value;
      });
    });
  });
}
rangeSlider();

$(document).ready(function () {
  $(".tablinks").click(function () {
    var index = $(this).attr("data-index");
    $(".page").hide();
    $('section[data-index="' + index + '"]').show();
  });

  $(".tablinks").click(function () {
    $(".tablinks").removeClass("active");
    $(this).addClass("active");
  });
  $("#bactomain").click((e) => {
    if (Number($(".menu").attr("data-page")) > 0) {
      $(`#${Number($(".menu").attr("data-page"))}Page`).css("display", "none");
      $(".menu").attr("data-page", Number($(".menu").attr("data-page")) - 1);
      $(`#${Number($(".menu").attr("data-page"))}Page`).css("display", "block");
    }
    if (Number($(".menu").attr("data-page")) == 0) {
      $(".menu").css("display", "none");
      $(".items,.clothes").css("display", "none");
    }
  });

  $(".itemha").click((e) => {
    $(".options").css("display", "none");
    $(".itemha").removeClass("active");
    $(e.currentTarget).addClass("active");
    $(`#${e.currentTarget.dataset.page}`).css("display", "block");
    $(".btnChangeCloth").attr(
      "data-currentAction",
      e.currentTarget.dataset.name
    );
  });
});

function changeCharacterAppereance(input, name) {
  let inputValue = $("#" + input).val();
  let result = Number(Math.round(inputValue * 10) / 10);

  $.post(
    `http://${GetParentResourceName()}/changeCharacterValue`,
    JSON.stringify({
      result: result,
      name: name,
    })
  );
}

function choosesex(sex) {
  document.getElementById("loader").style.display = "block";

  $(".choosesex").css("display", "none");
  $.post(
    `http://${GetParentResourceName()}/selectSex`,
    JSON.stringify({
      sex: sex,
    })
  );
  charSex = sex;
  setTimeout(() => {
    document.getElementById("loader").style.display = "none";
    $(".options").css("display", "none");
    $(`#${Number($(".menu").attr("data-page"))}Page`).css("display", "block");
    $(".family").css("display", "flex");
    $(".menu").css("display", "flex");
  }, 200);
  $(".menu").attr("data-page", 1);
}

function changeCam(type) {
  $.post(
    `http://${GetParentResourceName()}/changeCam`,
    JSON.stringify({
      type: type,
    })
  );
}

function leftHandle(input, name) {
  let inputValue = $("#" + input + "value").val();
  let result = Math.round(inputValue * 10) / 10;

  if (Number(inputValue) > Number($("#" + input + "value").attr("min"))) {
    $("#" + input + "value").val(Number(inputValue) - 1);
  } else {
    $("#" + input + "value").val(Number($("#" + input + "value").attr("max")));
  }
  $.post(
    `http://${GetParentResourceName()}/changeCharacterValue`,
    JSON.stringify({
      result: Number($("#" + input + "value").val()),
      name: name,
    })
  );
}

function rightHandle(input, name) {
  let inputValue2 = $("#" + input + "value").val();
  let resultr = Math.round(inputValue2 * 10) / 10;
  if (Number(inputValue2) < Number($("#" + input + "value").attr("max"))) {
    $("#" + input + "value").val(Number(inputValue2) + 1);
  } else {
    $("#" + input + "value").val(Number($("#" + input + "value").attr("min")));
  }

  $.post(
    `http://${GetParentResourceName()}/changeCharacterValue`,
    JSON.stringify({
      result: Number($("#" + input + "value").val()),
      name: name,
    })
  );
}

function backbtn(name, name2) {
  $(`#${name}`).css("display", "block");
  $(`#${name2}`).css("display", "none");
  if (name === "0Page" || name === "1Page") {
    $(".items,.clothes").css("display", "none");
  } else {
    $(".clothes").css("display", "none");
    $(".items").css("display", "block");
  }
}

function nextbtn(name, name2) {
  $(`#${name}`).css("display", "block");
  $(`#${name2}`).css("display", "none");
  if (name == "2Page") {
    $(".items").css("display", "flex");
    $(".clothes").css("display", "none");
    $(".items .itemha").removeClass("active");
    $(".items .itemha:first-child").addClass("active");
  }
  if (name == "clothPage") {
    $(".items").css("display", "none");
    $(".clothes").css("display", "flex");
    $(".clothes .itemha").removeClass("active");
    $(".clothes .itemha:first-child").addClass("active");
  }
}

window.addEventListener("message", (event) => {
  switch (event.data.action) {
    case "father":
      $("#fathervalue2").html(event.data.name);
      break;
    case "mother":
      $("#mothervalue2").html(event.data.name);
      break;
    case "hair":
      $("#hairOne2").html(event.data.name);
      break;
    case "asdas":
      $("#sdfsdf").val(event.data.name);
      break;
    case "setConfig":
      // console.log(event.data.config)
      clotheValues = event.data.config;

      break;
    default:
      break;
  }
});

function leftCloth() {
  let type = $(".btnChangeCloth").attr("data-currentAction");
  let val = clotheValues[charSex][type].indexOf(selectedValues[type]);
  let test = clotheValues[charSex][type].length - 1;
  selectedValues[type] = clotheValues[charSex][type][val - 1];
  if (typeof selectedValues[type] == "undefined") {
    selectedValues[type] = clotheValues[charSex][type][test];
  }
  $.post(
    `http://${GetParentResourceName()}/updateCloth`,
    JSON.stringify({
      type: type,
      sex: charSex,
      value: selectedValues[type],
    })
  );
}

function rightCloth() {
  let type = $(".btnChangeCloth").attr("data-currentAction");
  let val = clotheValues[charSex][type].indexOf(selectedValues[type]);
  selectedValues[type] = clotheValues[charSex][type][val + 1];
  if (typeof selectedValues[type] == "undefined") {
    selectedValues[type] = clotheValues[charSex][type][0];
  }
  $.post(
    `http://${GetParentResourceName()}/updateCloth`,
    JSON.stringify({
      type: type,
      sex: charSex,
      value: selectedValues[type],
    })
  );
}
