const express = require("express");
const app  = express();
const bodyParser = require('body-parser');

app.use(express.json());
app.use(bodyParser.urlencoded({extended:true}))

app.get("/",(req,res,next)=>{
    res.status(200).json({"message":"Working"})
})

module.exports = app;