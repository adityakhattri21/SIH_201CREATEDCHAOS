const {Schema,model, Mongoose} = require("mongoose");

const internShip = new Schema({
    lawyerId:{
        type:Schema.Types.ObjectId,
        ref:'lawyers',
        required:true
    },
    heading:{
        type:String,
        required:true
    },
    desc:{
        type:String,
        required:true
    },
    responsibility:{
    type:String,
        required:true
    },
    qualifications:{
      type:String,
        required:true
    },
    offers:{
        type:String,
        required:true
    },
     createdAt:{
        type:Date,
        default:Date.now
     },
     applicants:[{
        type:Schema.Types.ObjectId,
        ref:'lawyers'
     }]
});

module.exports = model('Internship',internShip);
