var express = require("express");
var router = express.Router();
var Note = require("./../models/notes");
//adding notes route to the server
// this route will also work as update route as it can be used to update the route as well.

router.post("/add", async function (req, res) {
  //updateing the existing note it first deletes if that note is alreay present and then adds the new one.
  await Note.deleteOne({ id: req.body.id });
  var newNote = new Note({
    id: req.body.id,
    userId: req.body.userId,
    title: req.body.title,
    content: req.body.content,
  });
  await newNote.save(); // this will save the note to the database
  res.send({ message: "note save to database" + req.body.id });

  // res.send(req.body);
});

//if we want to fetch notes realted to the specific user

router.post("/list", async function (req, res) {
  var notes = await Note.find({ userId: req.body.userid });
  res.json(notes);
});
router.post("/delete", async function (req, res) {
  await Note.deleteOne({ id: req.body.id });
  res.send({ message: "note deleted from database" + req.body.id });
}); // this route will delete the note from the database

module.exports = router;
