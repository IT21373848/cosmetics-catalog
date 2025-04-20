require('dotenv').config();
const express = require('express');
const mongoose = require('mongoose');
const cors = require('cors');
const { swaggerUi, specs } = require('./swagger');
const productRoutes = require('./routes/productRoutes');

const app = express();
const PORT = process.env.PORT || 3000;

// Middleware
app.use(cors());
app.use(express.json());

// Routes
app.use('/api/products', productRoutes);

// Swagger route
app.use('/api-docs', swaggerUi.serve, swaggerUi.setup(specs));

// DB connection
mongoose.connect(process.env.MONGO_URI)
  .then(() => {
    console.log('MongoDB Connected');
    app.listen(PORT, () => {
        console.log(`Server is running at: http://localhost:${PORT}`);
        console.log(`Swagger API Docs available at: http://localhost:${PORT}/api-docs`);
      });
  
  })
  .catch((err) => {
    console.error('MongoDB connection error:', err);
  });
