const app = require("./app");
const dotenv = require('dotenv').config();
require("./database/conn");
const port = process.env.PORT;

const server = app.listen(port,()=>{
    console.log(`Server is up at port ${port}`);
})