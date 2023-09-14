const jwt = require("jsonwebtoken");
const User = require("../modals/user.modal");
const Lawyer = require("../modals/lawyer.modal");
const catchAsyncErrors = require("./catchAsyncErrors");
const ErrorHandler = require("../utils/errorHandler");

exports.isAuthenticatedUser = catchAsyncErrors(async (req,res,next)=>{
    const {authorization:token} = req.headers;

    if(!token) return next(new ErrorHandler("Login To Continue",401));

    const decodedData = jwt.verify(token,process.env.JWT_SECRET);
    if(decodedData.userType === 'user')
    req.user = await User.findById(decodedData.user._id);
    
    
    else if(decodedData.userType === 'lawyer')
    req.user = await Lawyer.findById(decodedData.user);
    
    req.userType = decodedData.userType

    next();
})