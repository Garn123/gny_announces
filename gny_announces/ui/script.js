let announceList = [];
let triggered = false;
const wait = (ms) => new Promise((resolve) => setTimeout(resolve, ms));

const TriggerAnnounce = async () => {
  triggered = true;
  if (announceList.length > 0) {
    const announce = announceList[0];
    //
    const body = document.body;
    const mainContainer = document.createElement("div");
    mainContainer.id = "main-Container";
    mainContainer.classList.add(
      "main-container",
      "animate__animated",
      "animate__bounceInDown"
    );
    mainContainer.style.backgroundImage = `url("./assets/${announce.background}")`;
    const text = document.createElement("h3");
    text.textContent = announce.text;
    text.style.color = announce.color;
    text.style.textShadow = `1px 1px 1px ${announce.shadow}`;
    mainContainer.appendChild(text);
    body.appendChild(mainContainer);
    if (mainContainer) {
      setTimeout(() => {
        mainContainer.classList.remove("animate__bounceInDown");
        mainContainer.classList.add("animate__bounceOutUp");
        setTimeout(() => {
          mainContainer.remove();
        }, 1000);
      }, announce.duration);
    }
    await wait(announce.duration + 1000);
    //
    announceList.splice(0, 1);
    TriggerAnnounce();
  } else {
    triggered = false;
  }
};

addEventListener("message", (event) => {
  const data = event.data;
  announceList.push(data);
  if (!triggered) TriggerAnnounce();
  //
});
