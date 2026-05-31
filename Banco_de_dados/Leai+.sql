DROP TABLE IF EXISTS `tbl_emprestimos`;

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
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

LOCK TABLES `tbl_emprestimos` WRITE;

INSERT INTO `tbl_emprestimos` VALUES (1,1,2,'2026-05-25','2026-05-29');

UNLOCK TABLES;


DROP TABLE IF EXISTS `tbl_livros`;

CREATE TABLE `tbl_livros` (
  `id_livro` int NOT NULL AUTO_INCREMENT,
  `titulo_livro` varchar(150) NOT NULL,
  `autor_livro` varchar(100) NOT NULL,
  `copias_disponiveis_livro` int NOT NULL,
  `categoria_livro` varchar(50) DEFAULT 'Geral',
  PRIMARY KEY (`id_livro`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;



LOCK TABLES `tbl_livros` WRITE;

INSERT INTO `tbl_livros` VALUES (2,'Fundamentos da Física: Mecânica','David Halliday',10,'Física'),(3,'1984','George Orwell',8,'Distopia');

UNLOCK TABLES;



DROP TABLE IF EXISTS `tbl_usuarios`;

CREATE TABLE `tbl_usuarios` (
  `id_usuario` int NOT NULL AUTO_INCREMENT,
  `nome_usuario` varchar(100) NOT NULL,
  `email_usuario` varchar(100) NOT NULL,
  `telefone_usuario` bigint DEFAULT NULL,
  PRIMARY KEY (`id_usuario`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;


LOCK TABLES `tbl_usuarios` WRITE;

INSERT INTO `tbl_usuarios` VALUES (1,'Eduardo Rossi','ed2ard02007@gmail.com',11973339066);

UNLOCK TABLES;
