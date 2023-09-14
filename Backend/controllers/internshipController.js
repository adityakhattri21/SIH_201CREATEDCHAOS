const catchAsyncErrors = require("../middleware/catchAsyncErrors");
const Internship = require("../modals/internship.modal");
const ErrorHandler = require("../utils/errorHandler");

exports.createIntern = catchAsyncErrors(async (req,res,next)=>{
    const {user , userType ,body } =req;

    if(userType !=='lawyer') return next(new ErrorHandler("Don't be Nawghty Shawty",401));

    const {heading,desc} = body;
    if(!heading || !desc) return next(new ErrorHandler("Yo I cannot work without both heading and desc"));

    const intern = await Internship.create({
        lawyerId:user._id,
        heading,
        desc
    });

    res.status(200).json({
        success:true,
        intern
    });

});

exports.apply = catchAsyncErrors(async(req,res,next)=>{
    const {user,userType} = req;

    if(userType !=='lawyer') return next(new ErrorHandler("Don't be Nawghty Shawty",401));

    const {interId} = req.body;

    const internPost = await Internship.findById(interId);

    internPost.applicants.push(user._id);

    await internPost.save();

    res.status(200).json({
        success:"true",
        message:"Mubarak Ho !! Applied"
    })
});

exports.getAlljobs = catchAsyncErrors(async(req,res,next)=>{
    const posts = await Internship.find();

    res.status(200).json({
        success:true,
        posts
    });
});

exports.getSinglePost = catchAsyncErrors(async(req,res,next)=>{
    const {userType,params} = req;
    
    if(userType !=='lawyer') return next(new ErrorHandler("Don't be Nawghty Shawty",401));

    const post = await Internship.findById(params.id);

    if(!post) return next(new ErrorHandler("Don't insert wrong id",404));

    res.status(200).json({
        success:true,
        post
    })
});

