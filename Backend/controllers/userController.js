const userTypes = ["user", "lawyer", "other"]
const User = require("../modals/user.modal")
const bcrypt = require("bcrypt")
const Login = require("../modals/login.modal")
const ErrorHandler = require("../utils/errorHandler")
const catchAsyncErrors = require("../middleware/catchAsyncErrors");
const Lawyer = require("../modals/lawyer.modal")
const sendToken = require("../utils/generateToken");

exports.createUser = catchAsyncErrors(async (req, res, next) => {
    //validating request
    const { userType } = req.body
    if (!userType) return next(new ErrorHandler('Send UserType idiot', 400));

    if (!userTypes.includes(userType)) return next(new ErrorHandler('Invalid User Type', 400));

    const { firstName, lastName, email, gender, contact, city, state, postalCode, aadharNumber, password } = req.body
    if (!firstName || !lastName || !email || !gender || !contact || !city || !state || !postalCode || !aadharNumber || !password) {
        return next(new ErrorHandler("Parameter missing bruh!", 400));
    }

    //checking for existing user
    const existingUser = await Login.findOne({ email })
    if (existingUser) return next(new ErrorHandler("User Already Exists", 400));

    //hashing password
    const salt = await bcrypt.genSalt(10);
    const hashedPass = await bcrypt.hash(password, salt);

    //adding data to db
    if (userType === "user") {
        const user = await User.create(req.body)
        await Login.create({
            email,
            password: hashedPass,
            uid: user["_id"],
            userType
        })
        return res.status(200).json({ msg: "Wohhooo !! User Created ", success: true })
    }
    else if (userType === "lawyer") {
        const {bio, courts, regId, calendlyId} = req.body
        if(!bio || !courts || !regId) return next(new ErrorHandler("Missing Parameters for laywer ",400))
        const user = await Lawyer.create(req.body)
        await Login.create({
            email,
            calendlyId,
            password: hashedPass,
            uid: user["_id"],
            userType
        })
        return res.status(200).json({ msg: "Wohhooo !! Lawyer Created ", success: true })
    }
    return next(new ErrorHandler("Route under Construction ! ", 500));
});

exports.loginUser = catchAsyncErrors(async(req,res,next)=>{
    let loginUser;
    const {email,password} = req.body;

    if(!email || !password) return next(new ErrorHandler("Incomplete Credentials",401));

    const reqUser = await  Login.findOne({email:email});

    if(!reqUser) return next(new ErrorHandler("Invalid Credentials",401));

    const comparePwd = await bcrypt.compare(password,reqUser.password);

    if(!comparePwd) return next(new ErrorHandler("Invalid Credentials",401));

    const userType = reqUser.userType;
    if(userType === 'user')
    loginUser = await User.findById(reqUser.uid);
    else if(userType === 'lawyer')
    loginUser = await Lawyer.findById(reqUser.uid);

    sendToken(loginUser,userType,res);
 })

 exports.getUser = catchAsyncErrors(async(req,res,next)=>{
    const {user,userType} = req;
    let userData;
    if(userType === 'user'){
        userData = await User.findById(user);
    }
    else if(userType === 'lawyer'){
        userData = await Lawyer.findById(user);
    }

    res.status(200).json({
        success:true,
        userData:userData,
        userType
    })
 });