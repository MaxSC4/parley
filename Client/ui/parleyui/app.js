const dialogue = document.getElementById("dialogue");
const backdrop = document.getElementById("backdrop");
const speakerEl = document.getElementById("speaker");
const lineEl = document.getElementById("line");
const choicesEl = document.getElementById("choices");
const nextBtn = document.getElementById("next");
const closeBtn = document.getElementById("close");

let choices = [];
let activeIndex = 0;

function showContainer() {
  backdrop.style.opacity = "1";
  dialogue.classList.remove("hidden");
  requestAnimationFrame(() => dialogue.classList.add("show"));
}

function hideContainer() {
  dialogue.classList.remove("show");
  backdrop.style.opacity = "0";
  setTimeout(() => {
    dialogue.classList.add("hidden");
    choicesEl.innerHTML = "";
  }, 200);
}

function renderChoices() {
  choicesEl.innerHTML = "";
  choices.forEach((choice, index) => {
    const btn = document.createElement("div");
    btn.className = "choice" + (index === activeIndex ? " active" : "");
    btn.textContent = choice.text;
    btn.addEventListener("click", () => selectChoice(index));
    choicesEl.appendChild(btn);
  });
}

function setActive(index) {
  activeIndex = index;
  const items = choicesEl.querySelectorAll(".choice");
  items.forEach((el, i) => {
    el.classList.toggle("active", i === activeIndex);
  });
}

function selectChoice(index) {
  if (!choices[index]) return;
  Events.Call("Parley:choose", choices[index].id);
}

Events.Subscribe("Parley:show_line", (speaker, text) => {
  choices = [];
  activeIndex = 0;
  speakerEl.textContent = speaker || "";
  lineEl.textContent = text || "";
  choicesEl.innerHTML = "";
  nextBtn.style.display = "inline-flex";
  showContainer();
});

Events.Subscribe("Parley:show_choices", (incoming) => {
  choices = incoming || [];
  activeIndex = 0;
  nextBtn.style.display = "none";
  renderChoices();
  showContainer();
});

Events.Subscribe("Parley:hide", () => {
  hideContainer();
});

nextBtn.addEventListener("click", () => {
  Events.Call("Parley:next");
});

closeBtn.addEventListener("click", () => {
  Events.Call("Parley:close");
});

window.addEventListener("keydown", (event) => {
  if (choices.length > 0) {
    if (event.key === "ArrowDown") {
      setActive((activeIndex + 1) % choices.length);
      event.preventDefault();
    } else if (event.key === "ArrowUp") {
      setActive((activeIndex - 1 + choices.length) % choices.length);
      event.preventDefault();
    } else if (event.key === "Enter") {
      selectChoice(activeIndex);
      event.preventDefault();
    }
  } else {
    if (event.key === "Enter" || event.key === " ") {
      Events.Call("Parley:next");
      event.preventDefault();
    }
  }

  if (event.key === "Escape") {
    Events.Call("Parley:close");
    event.preventDefault();
  }
});

