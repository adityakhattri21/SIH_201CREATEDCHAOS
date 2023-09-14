const { createPost, getAllPosts, getAllPostsOfUser, getPostById } = require("../controllers/postControllers");
const { isAuthenticatedUser } = require("../middleware/authMiddleware");

const router = require("express").Router()

router.post('/create',isAuthenticatedUser, createPost)
router.get('/',isAuthenticatedUser, getAllPosts)
router.get('/user', isAuthenticatedUser, getAllPostsOfUser)
router.get('/:id', isAuthenticatedUser, getPostById)


module.exports = router