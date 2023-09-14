const { Schema, model } = require("mongoose")

const lawyer = new Schema({
    firstName: {
        type: String,
        required: true
    },
    middleName:{
        type:String
    },
    lastName: {
        type: String,
        required: true
    },
    email: {
        type: String,
        required: true
    },
    gender: {
        type: String,
        required: true
    },
    contact: {
        type: Number,
        required: true,
        minlength: [10, "Invalid Mobile number"],
        maxLength: [10, "Invalid Mobile number"]
    },
    city: {
        type: String,
        required: true
    },
    state: {
        type: String,
        required: true
    },
    postalCode: {
        type: String,
        required: true
    },
    aadharNumber: {
        type: String,
        required: true,
        minlength: [12, "Invalid Aadhaar Number"],
        maxlength: [12, "Invalid Aadhaar Number"],
    },
    regId: {
        type: String,
        required: true
    },
    specialization:[String],
    notary:{type:Boolean,
            default:false},
    notaryId:{type:String},
    
    courts :[
        {
            type: String,
            required: true
        }
    ],
    bio:{
        type:String,
        required:true
    }
})

module.exports = model("lawyers", lawyer)
