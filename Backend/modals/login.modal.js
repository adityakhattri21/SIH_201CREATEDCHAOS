const {Schema, model} = require("mongoose")

const login = new Schema({
    email: {
        type:String,
        required:true
    },
    password:{
        type:String,
        required:true
    },
    uid:{
        type:Schema.Types.ObjectId,
        required:true,
        ref:"users"
    },
    userType:{
        type:String,
        required:true
    }
})

module.exports = model("logins", login)