// Cada reducer tendra un state.
const initialState =  {
    citas: [1, 2, 3, 4]
}

export default function(state=initialState, action) {
    // Para el manejo de las acciones se recomienda usar switch-case.
    switch(action.type) {
        case 'AGREGAR_CITA':
            return {
                ...state,
                citas: [...state.citas, action.payload]
            }
        default:
            return state
    }
};