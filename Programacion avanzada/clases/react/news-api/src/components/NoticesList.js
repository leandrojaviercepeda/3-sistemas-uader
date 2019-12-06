import React from 'react';
import Notice from './Notice'

const ListaNoticias = ({ notices }) => (
    <div className='row'>
        {notices.map(notice => (<Notice key={notice.url} notice={ notice }></Notice>))}
    </div>
)

export default ListaNoticias;