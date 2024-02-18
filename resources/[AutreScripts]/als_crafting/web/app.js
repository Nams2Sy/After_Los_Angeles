import Queue from "./components/queue.js";
import Recipe from "./components/recipe.js";

const wrapper = document.getElementById("body");
const recipeList = document.getElementById("recipe-list");
const queueList = document.getElementById("queue-list");

hide();
let station_id = -1;

function show(data) {
    station_id = data.station.id;
    wrapper.style.display = "block";
    document.getElementById("station-name").innerText = data.station.type;

    loadRecipes(data.recipes);
    window.update();
}

window.update = () => {
    if (station_id == -1) return;
    
    fetch(`https://${GetParentResourceName()}/getStation`, {
        method: 'POST',
        headers: {
            'Content-Type': 'application/json; charset=UTF-8',
        },
        body: JSON.stringify({
            station_id: station_id
        })
    }).then(resp => resp.json()).then(station => {
        loadQueue(station);
    });
}

function loadRecipes(recipes) {
    recipeList.innerHTML = "";
    recipes.forEach(element => {
        let component = new Recipe(element.output[0].name, element)
        component.render(recipeList);
    });

    var anchors = document.getElementsByClassName('recipe');
    for(var i = 0; i < anchors.length; i++) {
        var anchor = anchors[i];
        anchor.onclick = function() {
            fetch(`https://${GetParentResourceName()}/craft`, {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/json; charset=UTF-8',
                },
                body: JSON.stringify({
                    station_id: station_id,
                    recipe_id: anchor.id
                })
            }).then(resp => resp.json()).then(success => {
                window.update();
                console.log(success);
            });
        }
    }
}

function loadQueue(station) {
    fetch(`https://${GetParentResourceName()}/getStationQueueRecipes`, {
        method: 'POST',
        headers: {
            'Content-Type': 'application/json; charset=UTF-8',
        },
        body: JSON.stringify({
            recipe_queue: station.recipe_queue,
            type: station.type
        })
    }).then(resp => resp.json()).then(recipes => {
        queueList.innerHTML = "";
        recipes.forEach(recipe => {
            let component = new Queue(recipe.output[0].name, {
                recipe: recipe
            });
            if (queueList.innerHTML == "") component.setTimeLeft(station.time_left)
            component.render(queueList);
        });

        let empty = 5-queueList.children.length;
        for (let i = 0; i < empty; i++) {
            let component = new Queue("", "");
            component.render(queueList);
        }
    });
}

function hide() {
    wrapper.style.display = "none"
}

function close() {
    hide()
    fetch(`https://${GetParentResourceName()}/close`);
}

document.addEventListener('keydown', function(event) {
    if (event.key === 'Escape') close();
});

window.addEventListener('message', (event) => {
    if (event.data.type === 'open') {
        show(event.data);
    }
});
