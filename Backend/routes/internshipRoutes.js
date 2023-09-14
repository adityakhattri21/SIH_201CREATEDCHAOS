const { getAlljobs, createJob, apply, getSingleJob, deleteJob } = require("../controllers/internshipController");
const { isAuthenticatedUser } = require("../middleware/authMiddleware");

const router = require("express").Router();



router.get("/all",isAuthenticatedUser,getAlljobs);

router.post("/create",isAuthenticatedUser,createJob);

router.post("/apply",isAuthenticatedUser,apply);

router.route("/single/:id").get(isAuthenticatedUser,getSingleJob).delete(isAuthenticatedUser,deleteJob);

module.exports = router;