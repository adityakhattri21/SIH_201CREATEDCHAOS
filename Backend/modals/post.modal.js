const {Schema, model, default: mongoose} = require("mongoose")

const post = new Schema({
    userId:{
        type: Schema.Types.ObjectId,
        ref :"users",
        required:true
    },
    heading :{
        type:String,
        required:true,
    },
    tags:[{
        type:String,
    }],
    desc:{
        type:String,
        required:true
    },
    time:{
        type:String,
        required:true
    },
    comments:[{
        lawyerId:{
            type:Schema.Types.ObjectId,
            required:true,
            ref:"lawyers"
        },
        comment:String,
        time:String
    }]
})

module.exports = model("posts", post)