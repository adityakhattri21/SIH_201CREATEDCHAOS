const userTypes = ["user","lawyer","other"]
const User = require("../modals/user.modal")
const bcrypt = require("bcrypt")
const jwt = require("jsonwebtoken")
const Login = require("../modals/login.modal")
const ErrorHandler = require("../utils/errorHandler")
const catchAsyncError = require("../middleware/catchAsyncErrors");

exports.createUser = catchAsyncError(async (req,res,next) => {
    const {userType} = req.body
    if(!userType) return next(new ErrorHandler('Send UserType idiot',400));

    if(!userTypes.includes(userType)) return next(new ErrorHandler('Invalid User Type',400));

    if(userType==="user"){
        const {firstName, lastName, email, gender, contact, city, state ,postalCode, aadharNumber, password} = req.body
        if(!firstName || !lastName || !email || !gender || !contact || !city || !state || !postalCode ||!aadharNumber ||!password){
            return next(new ErrorHandler("Parameter missing bruh!",400));
        }

        const existingUser = await Login.findOne({email})

        if(existingUser) return next(new ErrorHandler("User Already Exists",400));

        const salt = await bcrypt.genSalt(10);
        const hashedPass = await bcrypt.hash(password, salt);
        const user = await User.create(req.body)
        await Login.create({
            email,
            password: hashedPass,
            uid: user["_id"],
            userType
        })
        return res.status(200).json({msg:"Wohhooo !! User Created ", success:true})
    }
    return next(new ErrorHandler("Route under Construction ! ",500));
})