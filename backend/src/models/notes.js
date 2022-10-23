//  steps to making model
// 1 we will have to makke the schema first  ie userId, username , Notes , id etc
// 2 after making schema we will name the model and add schema to it.

//making model in mongoose
const mongoose = require("mongoose");
var notesSchema = mongoose.Schema({
  id: {
    type: String,
    unique: true,
    required: true,
  },
  userId: {
    type: String,
    required: true,
  },
  title: {
    type: String,
    required: true,
  },
  content: {
    type: String,
  },
  dateAdded: {
    type: Date,
    default: Date.now(),
  },
});

module.exports = mongoose.model("Note", notesSchema);
