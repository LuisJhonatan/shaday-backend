import express, { Request, Response } from "express";
import cors from "cors";
import authRoutes from "./routes/auth.routes";

const app = express();
const PORT = 3000;

// Cors para permitir solicitudes desde el frontend
app.use(
  cors({
    origin: "http://localhost:5000",
    credentials: true,
  })
);

// Middleware para parsear el cuerpo de las solicitudes
app.use(express.json());

//Rutas de la API
app.use("/api/auth", authRoutes);

// Ruta principal de la API
app.get("/", (_: Request, res: Response) => {
  res.send("¡Hola, Bienvenido a la API Shaday!");
});

// Iniciar el servidor
app.listen(PORT, () => {
  console.log(`Servidor corriendo en http://localhost:${PORT}`);
});
