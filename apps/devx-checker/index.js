const express = require('express');
const app = express();
const port = process.env.PORT || 3000;

const secret = process.env.DEVX_SECRET || 'Secret not found';

app.get('/', (req, res) => {
  console.log(`✅ Loaded DEVX_SECRET: ${secret}`);
  res.send(`
    <h1>🔐 Prove AI Internal DevX App</h1>
    <p>This is a simulated internal tool running on EKS.</p>
    <p><strong>Secret:</strong> ${secret}</p>
  `);
});

app.listen(port, () => {
  console.log(`🟢 DevX Checker app running at http://localhost:${port}`);
});
