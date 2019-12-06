// Redux
import { combineReducers } from 'redux';
// Reducers
import citasReducer from './citasReducer'

// Nos permite declarar multiples reducers.
export default combineReducers({
    citas: citasReducer
})