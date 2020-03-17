import React, { Component } from 'react'

class Formulary extends Component {
    state = {
        category:'general'
    }

    changeCategory = e => {
        this.setState({
            category: e.target.value
        }, () => {
            //Pasarlo a al home para consultar por categoria
            this.props.getNotices(this.state.category)
        })
    }

    render() {
        return (
            <div className="searching row">
                <div className="col s12 m8 offset-2">
                    <form>
                        <h2> Search news by category </h2>

                        <div className="input-field col s12 m8">
                            <select onChange={ this.changeCategory }>
                                <option value="general">        General         </option>
                                <option value="business">       Business         </option>
                                <option value="entertainment">  Entertainment    </option>
                                <option value="health">         Health           </option>
                                <option value="technology">     Technology      </option>
                            </select>
                        </div>
                    </form>
                </div>
            </div>
        )
    }
}

export default Formulary
