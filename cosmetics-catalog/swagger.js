const swaggerJsdoc = require('swagger-jsdoc');
const swaggerUi = require('swagger-ui-express');

const options = {
  definition: {
    openapi: '3.0.0',
    info: {
      title: 'Cosmetics Product API',
      version: '1.0.0',
      description: 'API documentation for the cosmetics product catalog microservice',
    },
    servers: [
      {
        url: 'http://localhost:3000',
      },
    ],
  },
  apis: ['./routes/*.js'], // Path to route files
};

const specs = swaggerJsdoc(options);

module.exports = {
  swaggerUi,
  specs,
}; 
