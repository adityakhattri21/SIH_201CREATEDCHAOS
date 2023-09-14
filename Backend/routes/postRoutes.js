const { createPost, getAllPosts, getAllPostsOfUser, getPostById, addComment } = require("../controllers/postControllers");
const { isAuthenticatedUser } = require("../middleware/authMiddleware");

const router = require("express").Router()

router.post('/create',isAuthenticatedUser, createPost)
router.get('/',isAuthenticatedUser, getAllPosts)
router.get('/user', isAuthenticatedUser, getAllPostsOfUser)
router.get('/:id', isAuthenticatedUser, getPostById)
router.patch('/comment/:id',isAuthenticatedUser, addComment)


module.exports = router