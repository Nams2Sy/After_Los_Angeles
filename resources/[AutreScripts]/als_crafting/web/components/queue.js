class Queue {
    constructor(name, props) {
        this.name = name;
        this.props = props;
        this.time_left = -1;
        this.intervalId = null;
    }

    setTimeLeft(time_left) {
        this.time_left = time_left;
    }

    startProgress() {
        if (this.time_left == -1) return;
        if (this.intervalId) {
            clearInterval(this.intervalId);
        }
        this.intervalId = setInterval(() => {
            if (this.time_left > 0) {
                this.time_left -= 100; // Diminuer le temps restant de 1 seconde
                this.updateProgress();
            } else {
                clearInterval(this.intervalId);
            }
        }, 100); // Mettre à jour la barre de progression toutes les secondes
    }

    updateProgress() {
        const progressbar = document.getElementById("progress-bar");
        let recipe_time = this.props.recipe.time;
        let time_elapsed = recipe_time - this.time_left / 1000;
        let percent = (time_elapsed * 100) / recipe_time;
        progressbar.style.width = percent + "%";
        progressbar.innerText = percent + "%";
        if (percent >= 100) window.update();
    }

    render(el) {
        let html = document.createElement("div")
        html.classList.add("slot")
        html.innerHTML = `<h1>${this.name}</h1>${this.time_left == -1 ? "" : "<div class='progressbar-wrapper'><div id='progress-bar' class='progress-bar' style='width: 75%;'>75%</div></div>"}`;
        el.appendChild(html)
        this.startProgress();
    }
}

export default Queue;