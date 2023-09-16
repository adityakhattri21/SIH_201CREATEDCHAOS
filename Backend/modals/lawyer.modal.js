const { Schema, model } = require("mongoose")

const lawyer = new Schema({
    firstName: {
        type: String,
        required: true
    },
    middleName:{
        type:String,
        default:""
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
    cop:{
        type:String,
        required:true
    },
    specialization:[String],
    isNotary:{type:Boolean,
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
    },
    internPosts:[{
        type:Schema.Types.ObjectId,
        ref:"internships"
    }],
    imageURL:{
        type:String,
        required:true,
        default:"https://images.unsplash.com/photo-1503023345310-bd7c1de61c7d?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1965&q=80"
    },
    calendlyId:{
        type:String,
        required:true,
    },
    appliedAt:[{
        appliedAt:{
            type:Date,
            default:Date.now
        },
        opening:{
            type:Schema.Types.ObjectId,
            ref:"Internship"
        }
    }]
})

module.exports = model("lawyers", lawyer)
