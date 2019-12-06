import React from 'react';

const Notice = ({notice}) => {

    const { urlToImage, url, title, description } = notice

    return(
        <div className="col s12 m6 l4">
            <div className="card">
                <div className="card-image">
                    <img src={ urlToImage } alt={ title }/>
                </div>
                
                <div className="card-content">
                    <h3>{ title }</h3>
                    <p>{ description }</p>
                </div>
                
                <div className="card-action">
                    <a href={ url } target="blank" rel="noopener noreferrer" className="waves-effect waver-light btn">Show complete news</a>
                </div>
            </div>
        </div>
    )
}

export default Notice;