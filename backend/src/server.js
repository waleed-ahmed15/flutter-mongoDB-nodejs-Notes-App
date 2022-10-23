const express = require("express");
const app = express();

var mongoose = require("mongoose");

var bodyparser = require("body-parser");
app.use(bodyparser.urlencoded({ extended: false }));

// when we set bodyparser.urlencoded({extended:false}); this means the nested objects are not allowed to be sent
//if set to true it will allow to send the nested objects

mongoose
  .connect(
    "mongodb+srv://waleedahmed:123123123@cluster0.kietqff.mongodb.net/notesAppdb"
  )
  .then(function () {
    app.get("/", function (req, res) {
      res.send("api is running up");
    });
    const notesRouter = require("./routes/Note");
    app.use("/notes", notesRouter); //it will handle notes routes
  });

const PORT = process.env.PORT || 5000;
app.listen(PORT, function () {
  console.log("sever started at port 5000");
});
