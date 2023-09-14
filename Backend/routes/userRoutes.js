
const { createUser, loginUser,getUser } = require("../controllers/userController");
const { isAuthenticatedUser } = require("../middleware/authMiddleware");

const router = require("express").Router()

router.post("/create", createUser)
router.post("/login",loginUser);


//test route
router.post("/test",isAuthenticatedUser,(req,res,next)=>{
    res.status(200).json({
        user:req.user
    });
})

router.get("/fetch",isAuthenticatedUser,getUser)

module.exports = router