class Recipe {
    constructor(name, props) {
        this.name = name;
        this.props = props;
    }

    render(el) {
        let html = `<div id='${this.props.id}' class='recipe'><h1>Fabriquer ${this.props.output[0].quantity} ${this.name}</h1><p>${JSON.stringify(this.props)}</p>`;
        el.innerHTML += html;
    }
}

export default Recipe;