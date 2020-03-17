import React, {Component, Fragment} from 'react';
import Product from './Product';

class ProductList extends Component {
    state = {
        products:  [
            {id: 1, name: 'Camiseta ReactJS', price: 300},
            {id: 2, name: 'Camiseta VueJS', price: 350},
            {id: 3, name: 'Camiseta Angular', price: 400},
            {id: 4, name: 'Camiseta NodeJS', price: 500}
        ]
    }
    componentDidMount () { //Esta listo el componente
        console.log(1); 
    }
    componentWillMount () {
        console.log(2); //Antes de que este listo el documento
    }
    componentWillUpdate () {
        console.log(3); //Cuando se actualiza algun documento
    }
    componentWillUnmount () {
        console.log(4);
    }
    render () {

        //Aqui es un buen lugar para crear variables y pasar atributos
        const {products} = this.state
        console.log(products);
        

        return (
            <Fragment>

                <h1> Products list </h1>

                { products.map(product => (//voy recorriendo los productos
                    <Product 
                        key = {product.id}
                        product = {product}
                    />
                ))}

            </Fragment>
        );
        
    }
}

export default ProductList;