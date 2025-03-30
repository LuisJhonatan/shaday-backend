import express, { Request, Response } from "express";

const app = express();
const PORT = 3000;

// Middleware para manejar JSON
app.use(express.json());

// Ruta de prueba
app.get("/", (req: Request, res: Response) => {
  res.send("¡Hola, Bienvenido a Shaday!");
});

// Iniciar el servidor
app.listen(PORT, () => {
  console.log(`Servidor corriendo en http://localhost:${PORT}`);
});
