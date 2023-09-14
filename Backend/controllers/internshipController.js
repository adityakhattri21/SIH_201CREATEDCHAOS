const catchAsyncErrors = require("../middleware/catchAsyncErrors");
const Internship = require("../modals/internship.modal");
const Lawyer = require("../modals/lawyer.modal");
const ErrorHandler = require("../utils/errorHandler");

exports.createJob = catchAsyncErrors(async (req,res,next)=>{
    const {user , userType ,body } =req;
    if(userType !=='lawyer') return next(new ErrorHandler("Don't be Nawghty Shawty",401));

    const {heading,desc} = body;
    if(!heading || !desc) return next(new ErrorHandler("Yo I cannot work without both heading and desc"));

    const intern = await Internship.create({
        lawyerId:user,
        heading,
        desc
    });

    const lawyer = await Lawyer.findById(user);

    lawyer.internPosts.push(intern["_id"]);

    await lawyer.save();

    res.status(200).json({
        success:true,
        intern
    });

});

exports.apply = catchAsyncErrors(async(req,res,next)=>{
    const {user,userType} = req;


    if(userType !=='lawyer') return next(new ErrorHandler("Don't be Nawghty Shawty",401));

    const {internId} = req.body;

    if(!internId) return next(new ErrorHandler("Cannot apply at null",401));

    const internPost = await Internship.findById(internId);

    internPost.applicants.push(user);

    await internPost.save();

    const applicant = await Lawyer.findById(user);

    applicant.appliedAt.push(internPost["_id"]);

    await applicant.save();

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

exports.getSingleJob = catchAsyncErrors(async(req,res,next)=>{
    const {userType,params} = req;
    
    if(userType !=='lawyer') return next(new ErrorHandler("Don't be Nawghty Shawty",401));

    const post = await Internship.findById(params.id);

    if(!post) return next(new ErrorHandler("Don't insert wrong id",404));

    res.status(200).json({
        success:true,
        post
    })
});

exports.deleteJob = catchAsyncErrors(async(req,res,next)=>{
    const {userType,params} = req;

    if(userType !=="lawyer") return next(new ErrorHandler("Don't be Nawghty Shawty",401));

    await Internship.findByIdAndDelete(params.id);

    res.status(200).json({
        success:true,
        message:"Deleted Successfully"
    })
})

