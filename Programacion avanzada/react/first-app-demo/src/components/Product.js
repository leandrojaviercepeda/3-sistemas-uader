import React from 'react';

const Product = ({product}) => {
    return (
        <div>
            <h1>{product.name}</h1>
            <p>price: {product.price} $</p>
        </div>
    );
};

export default Product;