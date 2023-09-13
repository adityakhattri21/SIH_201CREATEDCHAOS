const userTypes = ["user", "lawyer", "other"]
const User = require("../modals/user.modal")
const bcrypt = require("bcrypt")
const jwt = require("jsonwebtoken")
const Login = require("../modals/login.modal")
const ErrorHandler = require("../utils/errorHandler")
const catchAsyncError = require("../middleware/catchAsyncErrors");
const Lawyer = require("../modals/lawyer.modal")

exports.createUser = catchAsyncError(async (req, res, next) => {
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
        const {bio, courts, regId} = req.body
        if(!bio || !courts || !regId) return next(new ErrorHandler("Missing Parameters for laywer ",400))
        const user = await Lawyer.create(req.body)
        await Login.create({
            email,
            password: hashedPass,
            uid: user["_id"],
            userType
        })
        return res.status(200).json({ msg: "Wohhooo !! Lawyer Created ", success: true })
    }
    return next(new ErrorHandler("Route under Construction ! ", 500));
})

