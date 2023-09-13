const {Schema, model} = require("mongoose")

const user = new Schema({
    firstName : {
        type:String,
        required:true
    },
    lastName : {
        type:String,
        required:true
    },
    email: {
        type:String,
        required:true
    },
    gender : {
        type:String,
        required:true
    },
    contact : {
        type:Number,
        required:true,
        minlength:[10,"Invalid Mobile number"],
        maxLength:[10,"Invalid Mobile number"]
    },
    city:{
        type:String,
        required:true
    },
    state:{
        type:String,
        required:true
    },
    postalCode:{
        type:Number,
        required:true
    },
    aadharNumber:{
        type:String,
        required:true,
        minlength:[12,"Invalid Aadhaar Number"],
        maxlength:[12,"Invalid Aadhaar Number"],
    },
})

module.exports = model("users", user)