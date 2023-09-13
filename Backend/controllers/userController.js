const userTypes = ["user","lawyer","other"]
const User = require("../modals/user.modal")
const bcrypt = require("bcrypt")
const jwt = require("jsonwebtoken")
const Login = require("../modals/login.modal")

exports.createUser = async (req,res) => {
    const {userType} = req.body
    if(!userType) return res.status(400).json({msg:"Send UserType idiot", success:false})
    if(!userTypes.includes(userType)) return res.status(400).json({msg:"Invalid User type", success:false})
    if(userType==="user"){
        const {firstName, lastName, email, gender, contact, city, state ,postalCode, aadharNumber, password} = req.body
        if(!firstName || !lastName || !email || !gender || !contact || !city || !state || !postalCode ||!aadharNumber ||!password){
            return res.status(400).json({msg:"Parameter missing bruh!", success:false, received: req.body})
        }   
        const existingUser = await Login.findOne({email})
        if(existingUser) return res.status(400).json({msg:"User Already Exists", success:false})
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
    res.status(500).json({msg:"Route under Construction ! ", success:false})
}