const { HfInference } = require("@huggingface/inference");
const catchAsyncErrors = require("../middleware/catchAsyncErrors");
const Post = require("../modals/post.modal");
const ErrorHandler = require("../utils/errorHandler");

exports.createPost = catchAsyncErrors(async (req, res, next) => {
    const { user, body, userType } = req
    if (userType !== "user") return next(new ErrorHandler("Only Common man allowed!", 401))
    const { heading, time, desc, isAnonymous } = body
    const { _id } = user
    if (!heading || !time || !desc) return next(new ErrorHandler("wtf man ! params missing ;send heading or time or desc ", 400))
    const hf_token = process.env.HF_TOKEN
    const inference = new HfInference(hf_token)
    const model = "MoritzLaurer/DeBERTa-v3-base-mnli-fever-anli"

    const tags = await inference.zeroShotClassification({
        model,
        inputs: [desc],
        parameters: { candidate_labels: ['Anticipatory Bail', 'Arbitration', 'Armed Forces Tribunal', 'Bankruptcy / Insolvency', 'Breach of Contract', 'Child Custody', 'Civil', 'Consumer Court', 'Court Marriage', 'Customs & Central Excise', 'Cyber Crime', 'Divorce', 'Documentation', 'Domestic Violence', 'Family', 'High Court', 'Immigration', 'International Law', 'Labour & Service', 'Landlord/Tenant', 'Media and Entertainment', 'Medical Negligence', 'Motor Accident', 'Muslim Law', 'Patent', 'R.T.I', 'Recovery', 'Supreme Court', 'Tax', 'Wills / Trusts'] }
    })
    console.log(tags)
    await Post.create({
        userId: _id,
        isAnonymous: isAnonymous ? isAnonymous : false,
        heading,
        tags: [],
        desc,
        time
    })
    res.status(200).json({ msg: "Post Created Successfully", success: true })
})

exports.getPostById = catchAsyncErrors(async (req, res, next) => {
    const { id } = req.params
    if (!id) return next(new ErrorHandler("Send Id idiot", 400))
    const post = await Post.findOne({ _id: id }).populate('userId comments.lawyerId')
    if (!post) return next(new ErrorHandler("Invalid id .. reporting to police in 1..2...3.....", 404))
    return res.status(200).json({ post, success: true })
})

exports.getAllPostsOfUser = catchAsyncErrors(async (req, res, next) => {
    const { _id: id } = req.user
    const post = await Post.find({ userId: id }).populate('userId comments.lawyerId')
    if (post.length === 0) return next(new ErrorHandler("User does not have any posts", 404))
    return res.status(200).json({ post, success: true })
})

exports.getAllPosts = catchAsyncErrors(async (req, res, next) => {
    const post = await Post.find({}).populate("userId").populate('userId comments.lawyerId')
    return res.status(200).json({ post, success: true })
})

exports.addComment = catchAsyncErrors(async (req, res, next) => {
    const { user, userType, body } = req
    const { comment, time } = body
    const { id } = req.params
    if (userType !== "lawyer") return next(new ErrorHandler("Only experts allowed to comment", 401))
    if (!id) return next(new ErrorHandler("Which post bruh?? send id", 400))
    if (!comment || !time) return next(new ErrorHandler("Send comment and time", 400))
    const commentBody = {
        lawyerId: user._id,
        comment,
        time
    }
    await Post.findByIdAndUpdate(id, {
        $push: {
            comments: commentBody
        }
    })
    res.status(200).json({ msg: "The comment is postedaa successfullyyyyeeaa", success: true })
})