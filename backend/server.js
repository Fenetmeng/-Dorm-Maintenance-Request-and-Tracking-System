const express = require("express");
const cors = require("cors");
const multer = require("multer");
const fs = require("fs");
const path = require("path");

const app = express();
const PORT = 3000;

app.use(cors());
app.use(express.json());

const dbPath = path.join(__dirname, "db.json");
const uploadsDir = path.join(__dirname, "uploads");

if (!fs.existsSync(uploadsDir)) {
  fs.mkdirSync(uploadsDir);
}

app.use("/uploads", express.static(uploadsDir));

function readDb() {
  const data = fs.readFileSync(dbPath, "utf-8");
  return JSON.parse(data);
}

function writeDb(data) {
  fs.writeFileSync(dbPath, JSON.stringify(data, null, 2));
}

const storage = multer.diskStorage({
  destination: function (req, file, cb) {
    cb(null, uploadsDir);
  },
  filename: function (req, file, cb) {
    const uniqueName = Date.now() + "-" + file.originalname;
    cb(null, uniqueName);
  },
});

const upload = multer({ storage: storage });

// Upload image
app.post("/upload", upload.single("image"), (req, res) => {
  if (!req.file) {
    return res.status(400).json({ message: "No image uploaded" });
  }

  res.status(201).json({
    imageUrl: `http://localhost:${PORT}/uploads/${req.file.filename}`,
    imagePath: req.file.path,
    fileName: req.file.filename,
  });
});

// Get all requests
app.get("/requests", (req, res) => {
  const db = readDb();
  res.json(db.requests || []);
});

// Get single request
app.get("/requests/:id", (req, res) => {
  const db = readDb();
  const request = db.requests.find((item) => String(item.id) === req.params.id);

  if (!request) {
    return res.status(404).json({ message: "Request not found" });
  }

  res.json(request);
});

// Create request
app.post("/requests", (req, res) => {
  const db = readDb();

  const newRequest = {
    id: Date.now(),
    title: req.body.title,
    category: req.body.category,
    location: req.body.location,
    roomNumber: req.body.roomNumber,
    description: req.body.description,
    status: req.body.status || "Pending",
    dateRequested: req.body.dateRequested || new Date().toISOString(),
    userEmail: req.body.userEmail,
    imagePath: req.body.imagePath || null,
  };

  db.requests.push(newRequest);
  writeDb(db);

  res.status(201).json(newRequest);
});

// Update request
app.patch("/requests/:id", (req, res) => {
  const db = readDb();
  const index = db.requests.findIndex(
    (item) => String(item.id) === req.params.id
  );

  if (index === -1) {
    return res.status(404).json({ message: "Request not found" });
  }

  db.requests[index] = {
    ...db.requests[index],
    ...req.body,
  };

  writeDb(db);

  res.json(db.requests[index]);
});

// Delete request
app.delete("/requests/:id", (req, res) => {
  const db = readDb();
  const beforeLength = db.requests.length;

  db.requests = db.requests.filter((item) => String(item.id) !== req.params.id);

  if (db.requests.length === beforeLength) {
    return res.status(404).json({ message: "Request not found" });
  }

  writeDb(db);

  res.json({ message: "Request deleted successfully" });
});

// Feedback
app.get("/feedback", (req, res) => {
  const db = readDb();
  res.json(db.feedback || []);
});

app.post("/feedback", (req, res) => {
  const db = readDb();

  const newFeedback = {
    id: Date.now(),
    requestId: req.body.requestId,
    requestTitle: req.body.requestTitle,
    userName: req.body.userName,
    userEmail: req.body.userEmail,
    rating: req.body.rating,
    comment: req.body.comment,
    createdAt: req.body.createdAt || new Date().toISOString(),
  };

  db.feedback.push(newFeedback);
  writeDb(db);

  res.status(201).json(newFeedback);
});

app.listen(PORT, () => {
  console.log(`DormFix backend running on http://localhost:${PORT}`);
});