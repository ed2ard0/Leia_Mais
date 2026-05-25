-- MySQL dump 10.13  Distrib 8.0.43, for Win64 (x86_64)
--
-- Host: localhost    Database: biblioteca
-- ------------------------------------------------------
-- Server version	8.0.43

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `tbl_emprestimos`
--

DROP TABLE IF EXISTS `tbl_emprestimos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tbl_emprestimos` (
  `id_emprestimo` int NOT NULL AUTO_INCREMENT,
  `fk_id_usuario` int DEFAULT NULL,
  `fk_id_livro` int DEFAULT NULL,
  `data_emprestimo` date NOT NULL,
  `data_devolucao_emprestimo` date DEFAULT NULL,
  PRIMARY KEY (`id_emprestimo`),
  KEY `fk_id_usuario` (`fk_id_usuario`),
  KEY `fk_id_livro` (`fk_id_livro`),
  CONSTRAINT `tbl_emprestimos_ibfk_1` FOREIGN KEY (`fk_id_usuario`) REFERENCES `tbl_usuarios` (`id_usuario`) ON DELETE CASCADE,
  CONSTRAINT `tbl_emprestimos_ibfk_2` FOREIGN KEY (`fk_id_livro`) REFERENCES `tbl_livros` (`id_livro`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tbl_emprestimos`
--

LOCK TABLES `tbl_emprestimos` WRITE;
/*!40000 ALTER TABLE `tbl_emprestimos` DISABLE KEYS */;
INSERT INTO `tbl_emprestimos` VALUES (1,1,2,'2026-05-25',NULL);
/*!40000 ALTER TABLE `tbl_emprestimos` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tbl_livros`
--

DROP TABLE IF EXISTS `tbl_livros`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tbl_livros` (
  `id_livro` int NOT NULL AUTO_INCREMENT,
  `titulo_livro` varchar(150) NOT NULL,
  `autor_livro` varchar(100) NOT NULL,
  `copias_disponiveis_livro` int NOT NULL,
  `categoria_livro` varchar(50) DEFAULT 'Geral',
  PRIMARY KEY (`id_livro`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tbl_livros`
--

LOCK TABLES `tbl_livros` WRITE;
/*!40000 ALTER TABLE `tbl_livros` DISABLE KEYS */;
INSERT INTO `tbl_livros` VALUES (1,'As Origens do Totalitarismo','Hannah Arendt',3,'História'),(2,'Fundamentos da Física: Mecânica','David Halliday',3,'Física');
/*!40000 ALTER TABLE `tbl_livros` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tbl_usuarios`
--

DROP TABLE IF EXISTS `tbl_usuarios`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tbl_usuarios` (
  `id_usuario` int NOT NULL AUTO_INCREMENT,
  `nome_usuario` varchar(100) NOT NULL,
  `email_usuario` varchar(100) NOT NULL,
  `telefone_usuario` bigint DEFAULT NULL,
  PRIMARY KEY (`id_usuario`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tbl_usuarios`
--

LOCK TABLES `tbl_usuarios` WRITE;
/*!40000 ALTER TABLE `tbl_usuarios` DISABLE KEYS */;
INSERT INTO `tbl_usuarios` VALUES (1,'Eduardo Rossi de Borba','ed2ard02007@gmail.com',11973339066);
/*!40000 ALTER TABLE `tbl_usuarios` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2026-05-25 14:56:10
