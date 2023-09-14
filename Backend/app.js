const express = require("express");
const app  = express();
const bodyParser = require('body-parser');
const loginRoutes = require("./routes/userRoutes")
const errorMiddleware = require("./middleware/errorMiddleware");
const postRoutes = require("./routes/postRoutes")
const internshipRoute = require("./routes/internshipRoutes");

app.use(express.json());
app.use(bodyParser.urlencoded({extended:true}))

app.get("/",(req,res,next)=>{
    res.status(200).json({"message":"Working"})
})
app.use("/user",loginRoutes)
app.use('/post', postRoutes)
app.use("/job",internshipRoute);
app.use(errorMiddleware)

module.exports = app;