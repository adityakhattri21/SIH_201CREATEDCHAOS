const {Schema,model} = require("mongoose")

const otherSchema = Schema({
firstName:{
    type:String,
    required:true
},
middleName:{
    type:String,
    required:true
},
lastName:{
    type:String,
    required:true
},
isStamp:{
    type:Boolean,
    required:true
},
licence:{
    type:String
},
desc:{
    type:String,
    required:true
}
});

module.exports = ("other",otherSchema);