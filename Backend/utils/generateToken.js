const jwt = require("jsonwebtoken");

const sendToken = (user,userType,res)=>{
    const token =  jwt.sign({user:user , userType:userType},process.env.JWT_SECRET,{
        expiresIn:process.env.JWT_EXPIRES
    });

    res.status(200).json({
        success:true,
        userType:userType,
        user,
        token
    });
}

module.exports = sendToken;