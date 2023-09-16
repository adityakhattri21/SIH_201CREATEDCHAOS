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
    mageURL:{
        type:String,
        required:true,
        default:"https://images.unsplash.com/photo-1503023345310-bd7c1de61c7d?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1965&q=80"
    },
    state:{
        type:String,
        required:true
    },
    postalCode:{
        type:String,
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